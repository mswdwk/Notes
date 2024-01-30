echo "operate etcd by tls"
#ETCDCTL_API=3 etcdctl --cert /etc/kubernetes/pki/etcd/server.crt --key /etc/kubernetes/pki/etcd/server.key --cacert /etc/kubernetes/pki/etcd/ca.crt --endpoints https://192.168.79.132:2380 member list
ETCDCTL_API=3 etcdctl --cert /etc/kubernetes/pki/etcd/server.crt --key /etc/kubernetes/pki/etcd/server.key --cacert /etc/kubernetes/pki/etcd/ca.crt --endpoints https://192.168.79.132:2379 member list
# ETCDCTL_API=3 etcdctl --cert /etc/kubernetes/pki/etcd/server.crt --key /etc/kubernetes/pki/etcd/server.key --cacert /etc/kubernetes/pki/etcd/ca.crt --endpoints https://192.168.79.132:2379 get --prefix --keys-only /
ETCDCTL_API=3 etcdctl --cert /etc/kubernetes/pki/etcd/server.crt --key /etc/kubernetes/pki/etcd/server.key --cacert /etc/kubernetes/pki/etcd/ca.crt --endpoints https://192.168.79.132:2379 get  /registry/apiextensions.k8s.io/customresourcedefinitions/bgppeers.crd.projectcalico.org
