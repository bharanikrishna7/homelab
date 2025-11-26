#!/bin/bash

help() {
  echo ""
  echo "Usage: $0 <authkey>"
  echo -e "  authkey   : Authkey can be generated using tailscale website and navigating to settings->keys"
  exit 1 # Exit script after printing help
}

# check the number of arguments
# ensure that exactly 1 argument is supplied
if [ $# -ne 1 ]; then
  # code to be executed if the condition is true
  printf "this script requires exactly one parameter to be supplied, but supplied : $# \n"
  help
fi

# authkey, captured from arguments
authkey=$1


# bring up the tailscale docker compose
echo "Starting Tailscale..."
AUTHKEY=$authkey HOSTNAME=$HOSTNAME docker compose up --detach
echo "Tailscale is up..."