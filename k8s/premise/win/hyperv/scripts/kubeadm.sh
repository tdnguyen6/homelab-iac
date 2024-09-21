#!/usr/bin/env bash

VIP=10.0.0.7
VERSION="v1.28.0"
# ip address add ${VIP}/24 dev eth1
kubeadm init \
  --kubernetes-version $VERSION \
  --control-plane-endpoint "$VIP:6443"\
  --pod-network-cidr "10.1.0.0/16"\
  --service-cidr "10.2.0.0/16"\
  --skip-phases=addon/kube-proxy\
  --service-dns-domain com\
  --upload-certs 
# kubeadm init phase upload-certs --upload-certs
# --ignore-preflight-errors all
# mkdir -p $HOME/.kube
# cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# chown $(id -u):$(id -g) $HOME/.kube/config
