#!/bin/bash

if ! docker --version 2>/dev/null | grep -q 'build'; then
   echo "Docker is not installed. Terminating..."
   exit 1
fi

if ! groups | grep -q "docker"; then
   echo "The user '$USER' is not present in the 'docker' group. Terminating..."
   exit 1
fi

if ! ping 1.1.1.1 2>/dev/null | grep -q "ttl="; then
   echo "Could not connect to the Internet. Terminating..."
   exit 1
fi

mkdir -p /tmp/androcker && \
cd /tmp/androcker && \
docker pull scarfaced/androcker:androcker && \
docker pull scarfaced/androcker:mobsf && \
docker pull scarfaced/androcker:drozer && \
wget https://raw.githubusercontent.com/thirdbyte/androcker/master/.bashrc && \
mkdir -p $HOME/.androcker && \
cp .bashrc $HOME/.androcker/.bashrc && \
mkdir -p $HOME/.local/bin && \
echo 'xhost +local:root && docker run -it --rm --shm-size=4g --workdir=/root --hostname=androcker --net=host --privileged -e DISPLAY -e GENY=$1 -v /var/run/docker.sock:/var/run/docker.sock -v $HOME/.androcker:/root scarfaced/androcker:androcker /bin/bash && xhost -local:root' > $HOME/.local/bin/androcker && \
chmod +x $HOME/.local/bin/androcker && \
echo "export PATH=$HOME/.local/bin:$PATH" >> $HOME/.bashrc && \
cd /tmp && \
rm -rf /tmp/androcker
docker image rm $(docker images -q --filter "dangling=true") &>/dev/null
