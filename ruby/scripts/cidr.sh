#!/bin/bash

help() {
  echo ""
  echo "Usage: $0 <interface>"
  echo -e "Interface can be found by running 'ip a'"
  echo -e "Pick the desired interface to fetch it's CIDR"
  exit 1 # Exit script after printing help
}

# check the number of arguments
# ensure that exactly 1 argument is supplied
if (($# != 2)); then
  printf 'this script requires exactly one parameter to be supplied' "$#"
  help()
fi

# interface
iface=$1
printf "supplied interface : $iface"

# fetch the CIDR of supplied interface,
# using ip command
ip -4 addr show ${iface} | grep inet | awk '{print $2}'