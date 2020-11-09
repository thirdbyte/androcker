##!/bin/bash

if ! docker --version 2>/dev/null | grep -q 'build'; then
   echo "Docker is not installed. Terminating..."
   exit 1
fi

if ! groups | grep -q "docker"; then
   echo "The user '$USER' is not present in the 'docker' group. Terminating..."
   exit 1
fi

docker image rm scarfaced/androcker:androcker &>/dev/null
docker image rm scarfaced/androcker:mobsf &>/dev/null
docker image rm scarfaced/androcker:drozer &>/dev/null
docker image rm $(docker images -q --filter "dangling=true") &>/dev/null
rm -rf $HOME/.androcker &>/dev/null
rm -rf $HOME/.local/bin/androcker &>/dev/null
rm -rf /tmp/androcker &>/dev/null
