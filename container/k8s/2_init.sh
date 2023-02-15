sudo kubeadm --v=5 init --config kubeadm-init.yaml
#sudo kubeadm --v=5 init  --image-repository registry.aliyuncs.com/google_containers

#sudo kubeadm init \
#  --kubernetes-version 1.26.1 \
#  --apiserver-advertise-address=0.0.0.0 \
#  --service-cidr=10.96.0.0/16 \
#  --pod-network-cidr=192.168.0.0/16 \
#  --image-repository registry.aliyuncs.com/google_containers
