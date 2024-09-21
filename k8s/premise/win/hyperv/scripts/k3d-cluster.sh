k3d cluster create halb --subnet 10.1.0.0/16\
  --k3s-arg '--disable=servicelb@server:*'\
  --k3s-arg '--disable-network-policy@server:*'\
  --k3s-arg '--flannel-backend=none@server:*'\
  --servers 3 --agents 2

cilium-cli install --version 1.16.1 --set=ipam.operator.clusterPoolIPv4PodCIDRList="10.42.0.0/24"
