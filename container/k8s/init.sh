sudo kubeadm init \
  --kubernetes-version 1.26.0 \
  --apiserver-advertise-address=192.168.79.31\
  --service-cidr=10.96.0.0/16 \
  --pod-network-cidr=10.244.0.0/16 \
  --image-repository registry.aliyuncs.com/google_containers \
  --cri-socket unix:///run/containerd/containerd.sock
  #--container-runtime-endpoint unix:///run/containerd/containerd.sock
