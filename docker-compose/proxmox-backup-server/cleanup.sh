#!/bin/bash

echo "cleaning up proxmox backup server directories..."

echo " --> removing '/srv/pbs"
rm -rf /srv/pbs

if [ -e "/srv/pbs" ]; then
  echo "unable to delete '/srv/pbs', check permissions"
  exit 1
fi