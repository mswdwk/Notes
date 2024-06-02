#!/bin/bash

kubectl apply -f load-balancer-example.yaml

kubectl expose deployment hello-world --type=LoadBalancer --name=my-service


kubectl get deployments hello-world
kubectl describe deployments hello-world

kubectl get replicasets
kubectl describe replicasets

kubectl get services my-service
kubectl describe services my-service

kubectl get pods --output=wide
