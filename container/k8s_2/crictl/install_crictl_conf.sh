sudo cp crictl.yaml /etc/
ls -lh /etc/crictl.yaml
sudo chmod 766 /run/containerd/containerd.sock
sudo ls -lh /run/containerd/containerd.sock

crictl ps 
crictl images 

# you can modify containerd config file /etc/containerd/config.toml . 
```/etc/containerd/config.toml 
[plugins."io.containerd.grpc.v1.cri".registry.mirrors]
        [plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"]
                endpoint = ["https://dockerhub.mirrors.nwafu.edu.cn"]
        [plugins."io.containerd.grpc.v1.cri".registry.mirrors."k8s.gcr.io"]
                endpoint = ["https://registry.aliyuncs.com/k8sxio"]
```
