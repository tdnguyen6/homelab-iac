#!/usr/bin/env bash


sudo apt-get update -y

sudo apt-get install -y software-properties-common curl apt-transport-https ca-certificates net-tools vim curl gpg jq wget socat initramfs-tools

INDEX=2
TYPE=master
hostnamectl set-hostname "${TYPE}${INDEX}"
ls /etc/network/interfaces.d
ip addr show
cat <<EOF | tee /etc/network/interfaces.d/eth1
auto eth1 eth1:1
allow-hotplug eth1 eth1:1
iface eth1 inet dhcp
iface eth1:1 inet static
  address 10.0.0.1${INDEX}/24
  post-up /sbin/route add -net 10.0.0.0 netmask 255.255.255.0 gw 10.0.0.1
  post-down /sbin/route del -net 10.0.0.0 netmask 255.255.255.0

EOF
ip addr flush dev eth1 && systemctl restart networking
ip addr show
