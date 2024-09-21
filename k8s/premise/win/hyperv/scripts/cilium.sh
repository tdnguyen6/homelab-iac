#!/usr/bin/env bash

kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/experimental-install.yaml
cilium-cli install\
  --set ipam.operator.clusterPoolIPv4PodCIDRList='{10.1.0.0/16}'\
  --set kubeProxyReplacement=true\
  --set k8sServiceHost=10.0.0.7\
  --set tunnelProtocol=geneve \
  --set loadBalancer.dsrDispatch=geneve \
  --set ingressController.enabled=false \
  --set ingressController.default=true \
  --set gatewayAPI.enabled=true \
  --set loadBalancer.mode=dsr


  # --set ingressController.loadbalancerMode=shared \
