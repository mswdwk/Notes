#!/bin/bash
HBASE_HOME=$HOME/hbase-2.5.4

if [ $# -eq 0  ]; then
	action=status
else
	action=$1
fi
action=start
hosts=(node1 node2 node3)
for host in ${hosts[@]};do
	echo "execute hbase $action on $host"
	ssh user@$host "bash -s" <<ENDSSH
	$HBASE_HOME/bin/start-hbase.sh 
ENDSSH
done
