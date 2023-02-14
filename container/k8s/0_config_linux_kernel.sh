# ban selinux
sudo setenforce 0
sudo sed -i 's/^SELINUX=(.*)/SELINUX=disabled/g' /etc/selinux/config
grep SELINUX /etc/selinux/config
# load modules
## 创建/etc/modules-load.d/containerd.conf配置文件
sudo bash -c 'cat << EOF > /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF'

sudo modprobe overlay
sudo modprobe br_netfilter

# 创建/etc/sysctl.d/99-kubernetes-cri.conf配置文件
sudo bash -c 'cat << EOF > /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
user.max_user_namespaces=28633
vm.swappiness=0
EOF'
## take effect
sudo sysctl -p /etc/sysctl.d/99-kubernetes-cri.conf
# close swap 
sudo swapoff -a


# load modules
## 由于ipvs已经加入到了内核的主干，所以为kube-proxy开启ipvs的前提需要加载以下的内核模块
sudo bash -c 'cat > /etc/sysconfig/modules/ipvs.modules <<EOF
#!/bin/bash
modprobe -- ip_vs
modprobe -- ip_vs_rr
modprobe -- ip_vs_wrr
modprobe -- ip_vs_sh
modprobe -- nf_conntrack_ipv4
EOF'

sudo chmod 755 /etc/sysconfig/modules/ipvs.modules && sudo bash /etc/sysconfig/modules/ipvs.modules && lsmod | grep -e ip_vs -e nf_conntrack_ipv4

sudo yum install -y ipset ipvsadm

