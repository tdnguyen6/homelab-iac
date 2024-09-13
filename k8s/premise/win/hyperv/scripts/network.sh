#!/usr/bin/env bash

ls /etc/network/interfaces.d
ip addr show
# cat <<EOF | tee /etc/network/interfaces.d/eth0
# auto eth0
# iface eth0 inet dhcp
# EOF
# cat <<EOF | tee /etc/network/interfaces.d/eth1
# auto eth1
# iface eth1 inet static
#   address 172.31.0.2
#   netmask 255.255.255.0
#   gateway 172.31.0.1
#   dns-nameservers 89.207.128.252 89.207.130.252
# EOF
systemctl restart networking
systemctl enable --now networking


cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
