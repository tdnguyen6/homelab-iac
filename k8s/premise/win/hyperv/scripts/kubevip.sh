#!/usr/bin/env bash
mkdir -p /etc/kubernetes/manifests/

export VIP=10.0.0.7
export INTERFACE=eth1
export KVVERSION=$(curl -sL https://api.github.com/repos/kube-vip/kube-vip/releases | jq -r ".[0].name")

ctr image pull ghcr.io/kube-vip/kube-vip:$KVVERSION;
kube-vip() {
    ctr run --rm --net-host ghcr.io/kube-vip/kube-vip:$KVVERSION vip /kube-vip "$@"
}

kube-vip manifest pod \
    --interface $INTERFACE \
    --address $VIP \
    --controlplane \
    --services \
    --arp \
    --leaderElection | tee /etc/kubernetes/manifests/kube-vip.yaml

kubectl apply -f https://kube-vip.io/manifests/rbac.yaml
kubectl create configmap -n kube-system kubevip --from-literal range-global=10.1.0.100-10.1.0.199
kubectl apply -f https://raw.githubusercontent.com/kube-vip/kube-vip-cloud-provider/main/manifest/kube-vip-cloud-controller.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/tigera-operator.yaml
kubectl apply -f kube-vip-ds.yaml
kubectl apply -f calico.yaml
kubectl apply -f http-bin.yaml
