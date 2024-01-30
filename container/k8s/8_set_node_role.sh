#!/bin/bash

# [k8s设置集群角色](https://www.cnblogs.com/effortsing/p/10312515.html)

# # 设置 test1 为 master 角色
kubectl label nodes test1 node-role.kubernetes.io/master=

# 设置 test2 为 node 角色
kubectl label nodes test2 node-role.kubernetes.io/node=
# 删除 test2 的 node角色
kubectl label nodes test2 node-role.kubernetes.io/node-

# 设置 master 一般情况下不接受负载
kubectl taint nodes test1 node-role.kubernetes.io/master=true:NoSchedule
# master不运行pod
kubectl taint nodes test1 node-role.kubernetes.io/master=:NoSchedule

# master运行pod
kubectl taint nodes test1 node-role.kubernetes.io/master-
