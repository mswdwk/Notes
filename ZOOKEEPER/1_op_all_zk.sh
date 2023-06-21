#!/bin/bash
ZOOKEEPER_HOME=$HOME/apache-zookeeper-3.8.1-bin

if [ $# -eq 0  ]; then
	action=status
else
	action=$1
fi

hosts=(node1 node2 node3)
for host in ${hosts[@]};do
	echo "execute zk $action on $host"
	ssh user@$host "bash -s" <<ENDSSH
	$ZOOKEEPER_HOME/bin/zkServer.sh $action 
ENDSSH
done
