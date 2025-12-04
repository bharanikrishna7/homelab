#!/bin/bash


help() {
  echo ""
  echo "Usage: $0 <mode>"
  echo -e "  mode   : can be help / create"
  echo -e "    -> help : prints how to use the program"
  echo -e "    -> create : creates .env file to configure variables for authentik docker-compose"
}

# check the number of arguments
# ensure that exactly 1 argument is supplied
if [ $# -ne 1 ]; then
  # code to be executed if the condition is true
  printf "this script requires exactly one parameter to be supplied, but supplied : $# \n"
  help
  exit 1 # Exit script with error code
fi

if [ $1 == "help" ]; then
  # help mode
  help
  exit 0
elif [ $1 == "create" ]; then
  # create mode
  echo "creating or replacing './.env' file"
  rm -rf ./.env # remove .env file from cwd
  echo "setting up credentials for authentik"
  # set PG pass
  echo "PG_PASS=$(openssl rand -base64 36 | tr -d '\n')" >> .env
  # set Authentik secret key
  echo "AUTHENTIK_SECRET_KEY=$(openssl rand -base64 60 | tr -d '\n')" >> .env
  # enable error reporting
  echo "AUTHENTIK_ERROR_REPORTING__ENABLED=true" >> .env
  # SMTP Host Emails are sent to
  # echo "AUTHENTIK_EMAIL__HOST=localhost" >> .env
  # echo "AUTHENTIK_EMAIL__PORT=25" >> .env
  # Optionally authenticate (don't add quotation marks to your password)
  # echo "AUTHENTIK_EMAIL__USERNAME=" >> .env
  # echo "AUTHENTIK_EMAIL__PASSWORD=" >> .env
  # Use StartTLS
  # echo "AUTHENTIK_EMAIL__USE_TLS=false" >> .env
  # Use SSL
  # echo "AUTHENTIK_EMAIL__USE_SSL=false" >> .env
  # echo "AUTHENTIK_EMAIL__TIMEOUT=10" >> .env
  # Email address authentik will send from, should have a correct @domain
  # echo "AUTHENTIK_EMAIL__FROM=authentik@chekuri.org" >> .env
  echo "setup complete..."
  exit 0
else
  # illegal argument
  printf "mode can only be help / create, but supplied : $1 \n"
  help
  exit 1 # Exit script with error code
fi