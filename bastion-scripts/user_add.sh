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

pecho () {
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

# Meat and Potatoes

pecho "${yellow}Username:${reset} $1"
pecho "${yellow}Name and Email:${reset} $2"
pecho "${yellow}SSH PublicKey file:${reset} $3"

pecho "${green}Created user.${reset}"
useradd -m "$1" -c "$2"
pecho "${green}Creating user's SSH directory.${reset}"
mkdir -p "/home/$1/.ssh"
pecho "${yellow}Appending key to authorized_keys${reset}"
  cat "$3" >> "/home/$1/.ssh/authorized_keys"
pecho "${yellow}Setting permissions.${reset}"
chmod 700 "/home/$1/.ssh"
chmod 600 "/home/$1/.ssh/authorized_keys"
chown -R "$1":"$1" "/home/$1/.ssh"
pecho "${yellow}Setting Group privileges.${reset}"
# usermod -aG docker "$1"

if [ "$4" = "--admin" ]; then
  pecho "${yellow}Setting Admin privileges.${reset}"
  usermod -aG wheel "$1"
fi

echo "${green}Created user (${yellow}$1${green}) for $2.${reset}"
