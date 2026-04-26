#!/bin/sh

set -euo pipefail

export PATH=/usr/bin:/bin:/sbin
export SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt

mkdir /sys || echo "sys exists"
mkdir /proc || echo "proc exists"
mkdir /dev || echo "dev exists"


mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t devtmpfs devtmpfs /dev

mkdir /mnt

UUID='91676ab0-5980-4b25-916f-647c54d24ff2'
DEVICE=$(findfs UUID="$UUID")

mount "$DEVICE" -o ro /mnt

mount --move /dev /mnt/dev
mount --move /proc /mnt/proc
mount --move /sys /mnt/sys

export SYSTEMD_UNIT_PATH=/lib/systemd/system:/lib/systemd/user:/system/current/etc/systemd/system
exec switch_root /mnt /bin/init
