# Get Running Containers From Containerd
crictl -r /run/containerd/containerd.sock ps
# Get images
 crictl -r /run/containerd/containerd.sock images 
# resource stats
 crictl -r /run/containerd/containerd.sock stats
# enter container
 crictl -r /run/containerd/containerd.sock exec -it container_id 
