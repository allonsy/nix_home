#!/bin/bash

set -euo pipefail

mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
mount --bind /dev /mnt/dev

mount --bind /dev/pts /mnt/dev/pts

cp /etc/resolv.conf /mnt/etc/resolv.conf

chroot /mnt /sbin/sh

umount /mnt/dev/pts
umount /mnt/dev
umount /mnt/sys
umount /mnt/proc

# export SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt
