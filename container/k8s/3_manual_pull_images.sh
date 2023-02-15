str='docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver:v1.26.0
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager:v1.26.0
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler:v1.26.0
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy:v1.26.0
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.8
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.5.4-0
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/coredns:v1.9.3'

images=`sudo kubeadm config images list`
let i=0
for image in ${images[@]}
do
	let i=i+1
	mirror_image=${image/registry.k8s.io/registry.aliyuncs.com\/google_containers}
	mirror_image=${mirror_image/coredns\/coredns/coredns}
	echo -e "orginal: $image,\t\tmirror_image: $mirror_image"
	#docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/coredns:v1.9.3
	docker pull $mirror_image
	#docker tag $mirror_image $image 
done

