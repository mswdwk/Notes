kubectl create configmap nginx-conf --from-file nginx.conf
kubectl get configmap

kubectl create -f nginx-svc.yaml

kubectl get pods -o wide
kubectl get svc -o wide
