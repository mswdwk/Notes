kubeners_version=`kubelet --version|grep -oE "[0-9]*\.[0-9]*\.[0-9]*"`
echo kubeners_version=$kubeners_version
sudo kubeadm init \
  --kubernetes-version $kubeners_version \
  --apiserver-advertise-address=192.168.79.31\
  --service-cidr=10.96.0.0/16 \
  --pod-network-cidr=10.244.0.0/16 \
  --image-repository registry.aliyuncs.com/google_containers \
  --cri-socket unix:///run/containerd/containerd.sock
  #--container-runtime-endpoint unix:///run/containerd/containerd.sock
