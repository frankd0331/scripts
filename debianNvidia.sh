#!/bin/bash
# a script for setting up nvidia drivers
# on debian based on instructions from
# https://wiki.debian.org/NvidiaGraphicsDrivers#Installation

# Debian 7 "Wheezy"
# i wonder if I need sudo here?
# on the safe side i'm gonna add sudo everywhere
sudo deb http://http.debian.net/debian/ wheezy main contrib non-free

sudo aptitude update
sudo aptitude -r install linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,') nvidia-kernel-dkms

sudo mkdir /etc/X11/xorg.conf.d
sudo echo -e 'Section "Device"\n\tIdentifier "My GPU"\n\tDriver "nvidia"\nEndSection' > /etc/X11/xorg.conf.d/20-nvidia.conf

# restart the machine
echo "go ahead and restart"
