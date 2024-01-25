sudo echo > /etc/yum.repo.d/kubernets.repo <<EOF
[Kubernetes-https]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
sudo yum makecache
sudo yum install kubelet-1.26.1 kubectl-1.26.1 kubeadm-1.26.1
sudo yum install keepalived haproxy -y

