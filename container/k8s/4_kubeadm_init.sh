#!/bin/bash

joined_nodes_auto_get_ca=0
if [  $joined_nodes_auto_get_ca -eq 0 ];then
	sudo kubeadm --v=5 init --config kubeadm-init.yaml
else
	# if you want the joined nodes get ca file automationlly, add ' --upload-certs '
	sudo kubeadm --v=5 init --config kubeadm-init.yaml --upload-certs
fi
echo 'grant current user $USER has privileges to execute kubectl get nodes'
	mkdir -p $HOME/.kube
  	sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  	sudo chown $(id -u):$(id -g) $HOME/.kube/config


#sudo kubeadm --v=5 init  --image-repository registry.aliyuncs.com/google_containers

#sudo kubeadm init \
#  --kubernetes-version 1.26.1 \
#  --apiserver-advertise-address=0.0.0.0 \
#  --service-cidr=10.96.0.0/16 \
#  --pod-network-cidr=192.168.0.0/16 \
#  --image-repository registry.aliyuncs.com/google_containers
