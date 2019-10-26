#!/usr/bin/env bash

# Color codes & helper functions
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
reset=$(tput sgr0)

debug=0

debugMode () {
if [ "$debug" -eq 1 ]; then
  echo "$1"
fi
}

# Prechecks

if [ "$#" -lt 3 ]; then
  echo "${red}More arguments required.${reset}"
  echo -e "$0 username \"Person's Name <email@example.com\" \"ssh-key\" [--admin]"
  exit 1
fi

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

echo "${yellow}Username:${reset} $1"
echo "${yellow}Name and Email:${reset} $2"
echo "${yellow}SSH PublicKey file:${reset} $3"

if [ ! -d "/home/$1/" ]; then
  useradd "$1" --comment "$2"
  echo "${green}Created user <$1>.${reset}"
else
  echo "${yellow}User already exist.${reset}"
fi

if [ ! -d "/home/$1/.ssh" ]; then
  mkdir -p "/home/$1/.ssh"
  echo "${green}Creating user's SSH directory.${reset}"
else
  echo "${yellow}User's ssh folder already exist.${reset}"
fi

echo "${yellow}Updating the authorized_keys file${reset}"
cat "$3" > "/home/$1/.ssh/authorized_keys"

echo "${yellow}Setting permissions.${reset}"
chmod 700 "/home/$1/.ssh"
chmod 600 "/home/$1/.ssh/authorized_keys"
chown -R "$1":"$1" "/home/$1/.ssh"

if [ "$4" = "--admin" ]; then
  echo "${yellow}Setting Admin privileges.${reset}"
  usermod -aG wheel "$1"
fi

echo "${green}Created user (${yellow}$1${green}) for $2.${reset}"
