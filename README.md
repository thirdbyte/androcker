# Androcker - A Docker image for Android security testing

## Introduction

Androcker is a silly little script that makes use of [Docker](https://www.docker.com/) and sets up a hand full of useful tools and frameworks that are pretty popular for their use in testing Android applications.

## Technical Details

Androcker pulls a Docker image that uses [Kali Linux](https://www.kali.org/) base image,`kalilinux/kali` and installs `kali-linux-large` metapackage over it. It uses the `kali.download/kali` mirror and `kali-last-snapshot` branch. It also allows you to run GUI applications like `jadx-gui` from within the container by using `--privileged` container capabilities and adding a universal access control to `xhost` on your host Linux distribution. This script creates a `.desktop` file (the Application Launcher) for you that initiates the `docker run` command to run the container. So, the only thing you need to do is, execute `androcker`. You'll have access to a hand full of useful tools and frameworks that are pretty popular for their use in testing Android applications. Also, contrary to virtual machines, that are either networked behind a virtual NAT or bridged along with the host operating system, Androcker utilizes the host network stack as it is (using `--net=host`) which means that the Androcker container will have direct access to all the network interfaces as your host Linux distribution and will also share the same IP address.

## Prerequisites
+ Docker (User must be in the `docker` group)
+ Internet connection

## Installation

`mkdir -p /tmp/androcker && wget https://raw.githubusercontent.com/thirdbyte/androcker/master/install.sh -O /tmp/androcker/install.sh && chmod +x /tmp/androcker/install.sh && sudo /tmp/androcker/./install.sh`

This might take variable time depending upon your Internet speed. It pulls the Docker images from Docker Hub that weighs around 4G.

## Usage

1. Fire up a terminal.
2. Execute `androcker`.
3. Launch any tool by executing them using their respective package names. For an example: `frida`, `apktool`, `jadx-gui`, etc.
4. You can save any file in the `/root` directory inside the container and find it at `/home/androcker` on your host Linux distribution.

## Tools

1. **jadx** : Execute `jadx-gui` 
2. **apktool** : Execute `apktool`
3. **adb** : Execute `adb`
4. **frida** : Execute `frida`
5. **dex2jar** : Execute `objection`
6. **drozer** : Execute `drozer <genymotion-device-ipv4>` (Eg. drozer 192.168.56.105)
7. **mobsf** : Execute `mobsf <genymotion-device-ipv4>` (Eg. mobsf 192.168.56.105)

## Troubleshooting

+ Since the container runs with the root user privileges, the files created in the `/root` directory have the owner set to root. On the host Linux distribution, this directory is `/home/androcker`. All the files and sub directories inside `/home/androcker` will require the root user of the host Linux distribution in case any data needs to be written to or deleted from this directory.

## Limitations

+ Androcker uses Docker's `--privileged` container capabilities and `--net=host` networking. It also adds a universal access control to `xhost` for making GUI applications work, but immidiately closes it once Androcker is exited. This might allow any application to access the X server or GUI of your host Linux distribution in particular for the time Androcker is running which can be a security or a privacy concern for many.
+ Audio ouput does not work as of now.

## Uninstallation

`mkdir -p /tmp/androcker && wget https://raw.githubusercontent.com/thirdbyte/androcker/master/uninstall.sh -O /tmp/androcker/uninstall.sh && chmod +x /tmp/androcker/uninstall.sh && sudo /tmp/androcker/./uninstall.sh`

## And...

This script was created out of curiosity. This might solve a lot of problems. This might create new ones as well. It comes with no commitments whatsoever. You may do anything you wish to do with this script and are solely responsible for it. You can still feel free to file issues in case you experience any of them. Cheers!
