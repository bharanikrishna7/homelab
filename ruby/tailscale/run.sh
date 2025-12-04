#!/bin/bash

help() {
  echo ""
  echo "Usage: $0 [help]"
  echo -e "  help   : prints script usage"
  exit 1 # Exit script after printing help
}

# check the number of arguments
# ensure that <= 1 argument is supplied
if [ $# -gt 1 ]; then
  # code to be executed if the condition is true
  printf "this script requires <= 1 parameter to be supplied, but supplied : $# \n"
  help
fi

# if exactly 1 argument is supplied
if [ $# -eq 1 ]; then
  help
  # check if param is help
  if [ $1 == "help" ]; then
    exit 0
  # illegal param supplied
  else
    exit 1
  fi
fi

# Tailscale state directory needs to be cleaned up before 
# manually bringing up new tailscale container
echo "cleaning up tailscale directories..."
echo "  -> if it's desired to preserve state directory, to not regenerate single use key"
echo "     everytime. Please use 'docker compose command'  shown below. It will preserve state."
echo "              docker compose up --detach"
rm -rf /var/lib/tailscale

if [ -e "/var/lib/tailscale" ]; then
  echo "unable to delete file, check permissions"
  exit 1
fi

# bring up the tailscale docker compose
echo "Please ensure parameters have been setup in .env file..."
echo "Starting Tailscale..."
docker compose pull
docker compose up --detach
echo "Tailscale is up..."