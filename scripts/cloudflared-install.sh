#!/bin/bash

help() {
  echo ""
  echo "Usage: $0 <token>"
}

# check the number of arguments
# ensure that exactly 1 argument is supplied
if [ $# -ne 1 ]; then
  # code to be executed if the condition is true
  printf "this script requires exactly one parameter to be supplied, but supplied : $# \n"
  help
  exit 1; # exit with status code 1
fi

# service to cleanup
token=$1

# print help message and quit
if [ $1 == 'help' ]; then
  help
  exit 0;
fi

# Add cloudflare gpg key
mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-public-v2.gpg | tee /usr/share/keyrings/cloudflare-public-v2.gpg >/dev/null

# Add cloudflare public repo to your apt repositories
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-public-v2.gpg] https://pkg.cloudflare.com/cloudflared any main' | tee /etc/apt/sources.list.d/cloudflared.list

# install cloudflared
apt-get update && apt-get install cloudflared

# login to cloudflare tunnel
cloudflared tunnel login

# enable tunnel with supplied token
cloudflared service install $token