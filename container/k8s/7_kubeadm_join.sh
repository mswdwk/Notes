
# 1. Use the token and ca hash value by kubeadm init return.
## token will expire in 24 hours as default.
sudo kubeadm join 192.168.79.132:6443 --token abcdef.0123456789abcdef \
        --discovery-token-ca-cert-hash sha256:05397b9cf88da453ddc55246d124d9fb076b17f7c707c9429963d2043e378756 
# 2.  Create a token when  token expired
kubeadm token create
# 2.1 show the token
kubeadm token list 
# 2.2 get ca file hash value
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'
# 2.3 join to the k8s cluster
kubeadm join --token xxxxxxx master_ip:6443 --discovery-token-ca-cert-hash sha256:yyyyyyyy

# 3 delete node 'node2' from k8s cluster 
kubectl cordon node2
kubectl delete node node2
kubectl get nodes

# 4 let node 'node2' join k8s cluster again
on node2 , execute 'kubeadm reset -f',then execute 'kubeadm join xxx' .
