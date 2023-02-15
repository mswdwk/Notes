#  deploy a Pod network to the cluster
curl https://docs.projectcalico.org/archive/v3.21/manifests/calico.yaml -O

kubectl apply -f calico.yaml

kubectl get pods --all-namespaces 

kubectl get pod -n kube-system
