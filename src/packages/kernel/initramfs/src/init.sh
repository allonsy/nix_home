#!/bin/sh

set -euo pipefail

export PATH=/usr/bin:/bin:/sbin
export SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt

RECOVERY_MODE=0

mkdir /sys || echo "sys exists"
mkdir /proc || echo "proc exists"
mkdir /dev || echo "dev exists"
mkdir /mnt

mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t devtmpfs devtmpfs /dev

for arg in $(cat /proc/cmdline); do
    case "$arg" in
        recovery|recovery=1)
            RECOVERY_MODE=1
            ;;
    esac
done

UUID='91676ab0-5980-4b25-916f-647c54d24ff2'
DEVICE=$(findfs UUID="$UUID")

if [ "$RECOVERY_MODE" -eq 1 ]; then
    echo "Recovery flag detected. Executing recovery.sh..."
    mount "$DEVICE" -o rw /mnt

    /bin/sh

    umount /mnt
else
    echo "Normal boot mode"
fi

mount "$DEVICE" -o ro /mnt

mount --move /dev /mnt/dev
mount --move /proc /mnt/proc
mount --move /sys /mnt/sys

export SYSTEMD_UNIT_PATH=/lib/systemd/system:/lib/systemd/user:/system/current/etc/systemd/system
exec switch_root /mnt /bin/init
