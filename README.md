# Androcker - A Docker image for Android security testing

## Introduction

Androcker is a silly little script that makes use of [Docker](https://www.docker.com/) and sets up a hand full of useful tools and frameworks that are pretty popular for their use in testing Android applications.

## Prerequisites
+ Internet.
+ `curl`, `wget` & `iputils-ping` must be installed.
+ Docker must be installed and the user must be present in the `docker` group.
+ Genymotion must be installed.

## Installation

+ `curl -sL https://raw.githubusercontent.com/thirdbyte/androcker/master/install.sh | bash`

(This takes variable time depending upon your Internet speed. It pulls the Docker images from Docker Hub that weighs around 3.5G.)

+ Reboot.

## Usage

1. Start your Genymotion device and note down the IPv4 address from the title bar. Make sure that drozer agent and frida server are installed and running.
2. Fire up a terminal.
3. Execute `androcker <genymotion-ipv4-address>`.
4. Launch tools listed below by executing them using their respective package names. For an example: `frida`, `apktool`, `jadx-gui`, `mobsf`, `drozer`, etc.
5. You can save any file in the `/root` directory inside the container and find it at `$HOME/.androcker` on your host Linux distribution.

## Tools

1. jadx/jadx-gui
2. apktool
3. adb
4. dex2jar
5. frida
6. objection
7. drozer
8. mobsf

## Troubleshooting

+ Since the container runs with the root user privileges, the files created in the `/root` directory have the owner set to root. On the host Linux distribution, this directory is `$HOME/.androcker`. All the files and sub directories inside `$HOME/.androcker` will require the root user of the host Linux distribution in case any data needs to be written to or deleted from this directory.

## Limitations

+ Androcker uses Docker's `--privileged` container capabilities and `--net=host` networking. It also adds a universal access control to `xhost` for making GUI applications work, but immidiately closes it once Androcker is exited. This might allow any application to access the X server or GUI of your host Linux distribution in particular for the time Androcker is running which can be a security or a privacy concern for many.
+ Audio ouput does not work as of now.

## Uninstallation

1. `curl -sL https://raw.githubusercontent.com/thirdbyte/androcker/master/uninstall.sh | bash`
2. `sudo rm -rf $HOME/.androcker`

## And...

This script was created out of curiosity. This might solve a lot of problems. This might create new ones as well. It comes with no commitments whatsoever. You may do anything you wish to do with this script and are solely responsible for it. You can still feel free to file issues in case you experience any of them. Cheers!
