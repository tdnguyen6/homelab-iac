#!/usr/bin/env bash
# net-tools vim apt-transport-https ca-certificates curl gpg jq wget socat
echo 'tdn  ALL=(ALL:ALL) ALL' > /etc/sudoers.d/tdn

ls /etc/network/interfaces.d
ip addr show
cat <<EOF | tee /etc/network/interfaces.d/eth0
auto eth0
iface eth0 inet dhcp
EOF
cat <<EOF | tee /etc/network/interfaces.d/eth1
auto eth1
allow-hotplug eth1
iface eth1 inet static
  address 10.0.0.9
  netmask 255.255.255.0
  gateway 10.0.0.1
EOF
systemctl restart networking
systemctl enable --now networking

cat <<EOF | tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sysctl --system

apt update

# Shutdown after finishing
shutdown -h now
