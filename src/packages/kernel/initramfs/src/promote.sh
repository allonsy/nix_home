#!/bin/sh

set -euo pipefail

cd /mnt/system

NEW_LINK=$(readlink "$1")

rm current

ln -s "$NEW_LINK" current
