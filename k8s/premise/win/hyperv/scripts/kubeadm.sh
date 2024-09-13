#!/usr/bin/env bash

kubeadm config images pull
kubeadm init --pod-network-cidr=10.10.0.0/16
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
