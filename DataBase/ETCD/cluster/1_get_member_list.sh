#!/bin/bash

echo "[`date`] get member list from etcd1"
etcdctl --endpoints=http://localhost:12379  member list
echo -e "\n[`date`] get member list from etcd2"
etcdctl --endpoints=http://localhost:22379  member list
echo -e "\n[`date`] get member list from etcd3"
etcdctl --endpoints=http://localhost:32379  member list

ENDPOINTS=http://localhost:12379,http://localhost:22379,http://localhost:32379
echo -e "\n endpoint health"
etcdctl --endpoints=$ENDPOINTS endpoint health
etcdctl --endpoints=$ENDPOINTS endpoint status 

echo -e "\n get all keys in path '/'"
etcdctl --endpoints=$ENDPOINTS get --keys-only=true /
