#!/bin/bash
source ./conf.sh 
#HBASE_HOME=$HOME/hbase-2.5.4
#JAVA_HOME=/usr/lib/jdk-21

sed -i '$a\'\
export JAVA_HOME=$JAVA_HOME
export HBASE_MANAGES_ZK=false
conf/hbase-env.sh

if [ $# -eq 0  ]; then
	action=status
else
	action=$1
fi
action=start
hosts=(node1 node2 node3)
for host in ${hosts[@]};do
	echo "sync hbase conf on $host"
	scp conf/* user@$host:$HBASE_HOME/conf/ 
done
