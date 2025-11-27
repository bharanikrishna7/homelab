#!/bin/bash

help() {
  echo ""
  echo "Usage: $0 <mode>"
  echo -e "optional argument mode"
  echo -e "    -> help : prints how to use the program"
  echo -e "    -> fresh : recreates .env file before starting authentik docker container"
}

# if more than 1 argument is supplied
if [ $# -gt 1]; then
  echo "This script expects upto 1 argument, but supplied $#"
  help
  exit 1
fi

if [ ! -f ./.env ]; then
  echo ".env file not found, creating it..."
  ./setup.sh create
  echo ".env file created..."
fi


# if exactly 1 argument is supplied
if [ $# -eq 1 ]; then
  # check if mode is help
  if [ $1 == "help" ]; then
    help
    exit 0
  # check if mode is fresh
  elif [ $1 == "fresh" ]; then
    ./setup.sh create
  # illegal mode supplied
  else
    echo "This script expects only 2 modes (help / fresh), but supplied : $1"
    help
    exit 1
  fi
fi

# bring docker up
docker compose pull
docker compose up -detach