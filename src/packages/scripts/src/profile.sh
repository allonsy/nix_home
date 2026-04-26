#!/bin/sh

set -euo pipefail
cd /home/alecsnyder/nix

if [ "$UID" -ne 0 ]; then
  echo "Not root, please run with sudo"
  exit 1
fi
export SYSTEM_DIR=/system
export NIX_REMOTE=daemon
export SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt

mkdir -p $SYSTEM_DIR

nix build '.'
export NEW_ROOT=$(readlink result)
echo "new root is: $NEW_ROOT"

if [ -e "$SYSTEM_DIR/current" ]; then
    TIMESTAMP=$(date '+%Y_%m_%d_%H_%M_%S')
    cp -d "$SYSTEM_DIR/current" "$SYSTEM_DIR/$TIMESTAMP"
    ln -s "$SYSTEM_DIR/$TIMESTAMP" /nix/var/nix/gcroots/auto/system
fi

ln -sfn "$NEW_ROOT" "$SYSTEM_DIR/current"
