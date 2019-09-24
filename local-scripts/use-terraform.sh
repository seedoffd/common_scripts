#!/bin/bash

# Author <sadykovfarkhod@gmail.com>
# Script to download terraform and set up for the user.
# source ${PWD}/use-terraform.sh

# if [ "$0" = "$BASH_SOURCE" ]
# then
#     echo "$0: Please source this file."
#     echo "# source ${PWD}/use-terraform.sh"
#     exit 1
# fi

# Change this if you would like to move your terraform home folder
TERRAFORM_HOME='/usr/local/bin'
if $(curl --version >/dev/null ); then

  # Getting all available versions from hashicorp.
  release=$(curl -s -X GET "https://releases.hashicorp.com/terraform/")
  foundTerraformVersions=$(echo $release |awk -F '/' '{print $3}' |  sed  '/^$/d;' | sed '1d;$d' | grep -v 'alpha\|beta\|rc\|oci' | head -n 30 )

  # If releases founded script will continue
  if [[ $foundTerraformVersions ]]; then
    if $(wget --version > /dev/null ); then
      if [[ "$OSTYPE" == "darwin"* ]]; then

        # If OS type is Apple then script will provide available versions
        echo "$foundTerraformVersions\\nPlease sellect one version: "  && read SELLECTEDVERSION
        echo "$(tput setaf 2)#--- Downloading the terraform for this MAC. ---#"
        wget  -q --show-progress --progress=bar:force  "https://releases.hashicorp.com/terraform/${SELLECTEDVERSION}/terraform_${SELLECTEDVERSION}_darwin_amd64.zip" 2>&1

        # after user select existing terraform version
        # script will extract the zip file and move terraform to executable place </usr/local/bin>
        echo                 "#---    Moving terraform to bin folder.      ---#"
        unzip "terraform_${SELLECTEDVERSION}_darwin_amd64.zip" && /bin/mv "./terraform" "$TERRAFORM_HOME/terraform"
      fi
    else
      echo "command not found: wget"
      exit 1
    fi
  else
    echo "Versions not found."
    exit 1
  fi

else
  echo "command not found: curl"
  exit 1
fi
/bin/rm -rf "terraform_${SELLECTEDVERSION}_darwin_amd64.zip"
