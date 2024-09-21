#!/usr/bin/env bash

# the below does not work
swapon --show
swapoff -a
sed -i '/swap/ s/^/# /' /etc/fstab
update-initramfs -u
systemctl disable --now dev-sda3.swap
systemctl mask dev-sda3.swap
reboot
