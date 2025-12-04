#!/bin/bash

echo "cleaning up proxmox backup server directories..."

echo " --> removing '/media/pbs"
rm -rf /media/pbs

if [ -e "/media/pbs" ]; then
  echo "unable to delete '/media/pbs', check permissions"
  exit 1
fi