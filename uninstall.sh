#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

if ! docker --version 2>/dev/null | grep -q 'build'; then
   echo "This script requires Docker to be installed"
   exit 1
fi

docker image rm scarfaced/androcker:androcker &>/dev/null
docker image rm scarfaced/androcker:mobsf &>/dev/null
docker image rm scarfaced/androcker:drozer &>/dev/null
docker image rm $(docker images -q --filter "dangling=true") &>/dev/null
rm -rf /home/androcker &>/dev/null
rm -rf /usr/local/bin/androcker &>/dev/null
rm -rf /tmp/androcker &>/dev/null
