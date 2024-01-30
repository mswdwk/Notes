#!/bin/bash

# https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/

kubeadm token list
kubeadm token create 
# join control plane
kubeadm join 
# remove node from k8s cluster
kubeadm reset
kubectl drain <节点名称> --delete-emptydir-data --force --ignore-daemonsets
kubectl delete node <节点名称>
# get --discovery-token-ca-cert-hash
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | \
   openssl dgst -sha256 -hex | sed 's/^.* //'
