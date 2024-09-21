You can now join any number of the control-plane node running the following command on each as root:

kubeadm join 10.0.0.7:6443 --token u6sspx.nuzy2685eubbmz03 \
  --discovery-token-ca-cert-hash sha256:18d074fe7029eb382693d98e94dfed069049496391bf572e2f163437ffb564cf \
  --control-plane --certificate-key d57758940d9eb679bc60db67b97678d84b3c7b779f9c5212fbdf1235595b97ac


kubeadm join 10.0.0.7:6443 --token u6sspx.nuzy2685eubbmz03 \
  --discovery-token-ca-cert-hash sha256:18d074fe7029eb382693d98e94dfed069049496391bf572e2f163437ffb564cf 
