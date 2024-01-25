# kubeadm config print init-defaults >kubeadm-init-def.yaml
sudo yum list --showduplicates kubeadm|tail

kubeadm config print init-defaults --component-configs KubeletConfiguration > kubeadm-init-def.yaml
