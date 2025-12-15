#!/bin/bash

help() {
  echo ""
  echo "Usage: $0 <service>"
  echo -e "Please don't use this script in standalone mode."
  echo -e "This is supposed to cleanup docker container directories"
  echo -e "for fresh containers (without any previous data)."
  exit 1 # exit with status code 1
}

# check the number of arguments
# ensure that exactly 1 argument is supplied
if [ $# -ne 1 ]; then
  # code to be executed if the condition is true
  printf "this script requires exactly one parameter to be supplied, but supplied : $# \n"
  help
fi

# service to cleanup
service=$1
echo "cleaning up $service directories..."

# cleaning up service
echo " --> removing '/srv/$service"
rm -rf /srv/$service

# verify service direcrories cleaned up
if [ -e "/srv/$service" ]; then
  echo "unable to delete '/srv/$service', check permissions"
  # exit with status code 1
  exit 1
fi

# exit with status code 0
exit 0