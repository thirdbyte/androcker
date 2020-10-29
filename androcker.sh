#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

if ! docker --version 2>/dev/null | grep -q 'build'; then
   echo "This script requires Docker to be installed"
   exit 1
fi

if ! ping 1.1.1.1 2>/dev/null | grep -q "ttl="; then
   echo "This script must be run with an active Internet connection"
   exit 1
fi

mkdir -p /tmp/androcker && \
cd /tmp/androcker && \
docker pull scarfaced/androcker:androcker && \
docker pull scarfaced/androcker:mobsf && \
docker pull scarfaced/androcker:drozer

docker image rm $(docker images -q --filter "dangling=true") &>/dev/null

wget https://raw.githubusercontent.com/thirdbyte/androcker/master/.bashrc && \
mkdir -p /home/androcker && \
cp .bashrc /home/androcker/.bashrc && \
mkdir -p /usr/local/bin && \
echo "xhost +local:root && docker run -it --rm --shm-size=4g --workdir=/root --hostname=androcker --net=host --privileged -e DISPLAY -v /var/run/docker.sock:/var/run/docker.sock -v /home/androcker:/root scarfaced/androcker:androcker /bin/bash && xhost -local:root" > /usr/local/bin/androcker && \
chmod +x /usr/local/bin/androcker && \
cd /tmp && \
rm -rf /tmp/androcker && \
rm -rf /tmp/androcker.sh
