#!/bin/bash

# [](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)
# kubeadm config print init-defaults >kubeadm-init-def.yaml
#kubeadm  --v=5 config print init-defaults --image-repository registry.aliyuncs.com/google_containers --component-configs KubeletConfiguration > kubeadm-init-def.yaml
kubeadm  config print init-defaults --component-configs KubeletConfiguration > kubeadm-init.yaml

echo "In file kubeadm-init.yaml, modify item advertiseAddress/healthzBindAddress to  your control-plane host ip"
echo "In file kubeadm-init.yaml, modify item imageRepository to registry.aliyuncs.com/google_containers "
echo "In file kubeadm-init.yaml, modify item criSocket/name under item nodeRegistration to Containerd' socket , the host name  "
echo "Config dns in /etc/hosts , add domain 'cluster.local' ip for item 'clusterDomain: cluster.local' in file kubeadm-init.yaml"

echo " "
