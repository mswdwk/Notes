sudo cp crictl.yaml /etc/
ls -lh /etc/crictl.yaml
sudo chmod 766 /run/containerd/containerd.sock
sudo ls -lh /run/containerd/containerd.sock

crictl ps 
crictl images 
