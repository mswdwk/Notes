#!/bin/bash

# clean old versioin data every 30 minutes
etcd -config-file=etcd_conf.yaml --auto-compaction-retention=30m --auto-compaction-mode=periodic  &
#
# clean old versioin data , keep the last 10 revision 
#etcd -config-file=etcd_conf.yaml --auto-compaction-mode=revision --auto-compaction-retention=10 &
