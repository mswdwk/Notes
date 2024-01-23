#!/bin/bash

# https://zhuanlan.zhihu.com/p/639836407


echo kubectl apply -f xx.yml
echo kubectl delete -f xx.yml

kubectl get ns
kubectl get nodes
kubectl get pods -n kube-system
kubectl get pods -A 
kubectl describe  pod -n kube-system  kube-apiserver-node1
kubectl describe  pod -n kube-system  kube-controller-manager-node1
kubectl logs -n kube-system kube-apiserver-node1

echo "enter pod inner"
kubectl exec -it  calico-node-9vn9p -n kube-system -- /bin/bash
