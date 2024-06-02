#!/bin/bash

kubectl get deployments hello-world
kubectl describe deployments hello-world

kubectl get replicasets
kubectl describe replicasets

kubectl get services my-service
kubectl describe services my-service

kubectl get pods --output=wide
