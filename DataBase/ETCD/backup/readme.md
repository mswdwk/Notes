# https://kubernetes.io/zh-cn/docs/tasks/administer-cluster/configure-upgrade-etcd/

# create snapshot
ETCDCTL_API=3 etcdctl --endpoints $ENDPOINT snapshot save snapshot.db
# check snapshot
ETCDCTL_API=3 etcdctl --write-out=table snapshot status snapshot.db
# restore snapshot
## ETCDCTL_API=3 etcdctl --endpoints 10.2.0.9:2379 snapshot restore snapshot.db

## ETCDCTL_API=3 etcdctl snapshot restore --data-dir <data-dir-location> snapshot.db

#  [k8s-etcd故障恢复](https://www.cnblogs.com/liweifeng888/p/17740486.html)
