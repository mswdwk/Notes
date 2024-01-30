
echo modify CALICO_IPV4POOL_CIDR in file calico.yaml
kubectl apply -f calico.yaml.26

kubectl delete -f calico.yaml.26

kubectl get pods -A
