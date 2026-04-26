#!/bin/sh

set -euo pipefail
export PATH=/bin:/usr/bin:/sbin

mkdir -pv /run/wrappers/bin

cp /system/current/setuid/* /run/wrappers/bin

chmod +xs /run/wrappers/bin/*
