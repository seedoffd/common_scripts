#!/usr/bin/env bash

sudo yum install python-pip git -y

sudo mkdir /set-user && cd /set-user

git clone -b master https://github.com/fuchicorp/common_scripts.git
cd bastion-scripts && python sync-users.py
