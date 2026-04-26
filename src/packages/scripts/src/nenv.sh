#!/usr/bin/env bash

if [ "$1" = "-s" ]; then
  if [ -z "$NENV_STATUS" ] || [ ! -f "$NENV_STATUS" ]; then
    echo "Not in an nenv env"
    exit 1
  fi
  cat "$NENV_STATUS"
  exit 0
fi

if [ "$#" -eq 0 ]; then
  echo "Usage: nenv <pkg1> <pkg2> ..."
  echo "       nenv -s"
  exit 1
fi

NENV_STATUS_FILE=$(mktemp)
export NENV_STATUS="$NENV_STATUS_FILE"

pkgs=()
for pkg in "$@"; do
  echo "$pkg" >> "$NENV_STATUS_FILE"
  pkgs+=("nixpkgs#$pkg")
done

exec nix shell "${pkgs[@]}"
