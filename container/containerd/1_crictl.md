# Get Running Containers From Containerd
crictl -r /run/containerd/containerd.sock ps
# Get images
 crictl -r /run/containerd/containerd.sock images 
# resource stats
 crictl -r /run/containerd/containerd.sock stats
# enter container
 crictl -r /run/containerd/containerd.sock exec -it container_id 

# Config mirror for Containerd

// https://desistdaydream.github.io/docs/10.%E4%BA%91%E5%8E%9F%E7%94%9F/2.2.%E5%AE%9E%E7%8E%B0%E5%AE%B9%E5%99%A8%E7%9A%84%E5%B7%A5%E5%85%B7/Containerd/Containerd-%E9%85%8D%E7%BD%AE%E8%AF%A6%E8%A7%A3/Containerd-%E9%85%8D%E7%BD%AE%E8%AF%A6%E8%A7%A3/
```toml
 [plugins."io.containerd.grpc.v1.cri".registry.mirrors]
	[plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"]
   		endpoint = ["https://dockerhub.mirrors.nwafu.edu.cn"]
	[plugins."io.containerd.grpc.v1.cri".registry.mirrors."k8s.gcr.io"]
		endpoint = ["https://registry.aliyuncs.com/k8sxio"]
```
