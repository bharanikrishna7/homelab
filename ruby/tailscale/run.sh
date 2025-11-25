#!/bin/bash

help() {
  echo ""
  echo "Usage: $0 <interface> <authkey>"
  echo -e "  interface : Interface can be found by running 'ip a'"
  echo -e "  authkey   : Authkey can be generated using tailscale website and navigating to settings->keys"
  exit 1 # Exit script after printing help
}

# check the number of arguments
# ensure that exactly 1 argument is supplied
if [ $# -ne 2 ]; then
  # code to be executed if the condition is true
  printf "this script requires exactly one parameter to be supplied, but supplied : $# \n"
  help
fi

# interface is captured from agruments
interface=$1

# CIDR associated with supplied interface
cidr=$(eval bash ../scripts/cidr.sh $interface)
cidr_size=${#cidr} # should be <= 18 for valid CIDR value

# check the number of arguments
# ensure that exactly 1 argument is supplied
if [ $cidr_size -gt 18 ]; then
  # code to be executed if the condition is true
  echo $cidr
  exit 1 # Exit script after printing help
fi

echo "Will Add Subnet : $cidr to tailscale to enable accessing devices connected to host's network"

# authkey also captured from arguments
authkey=$2

echo "Starting Tailscale..."
# bring up the tailscale docker compose
# with CIDR of supplied interface in SubNet routes
# this will enable accessing devices connected to host OS
TS_ROUTES="$cidr" AUTHKEY=$authkey HOSTNAME=$HOSTNAME docker compose up --detach