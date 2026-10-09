#!/bin/sh

cd /

if [ $UID -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

@python@ @linker_file@
