#!/bin/bash
#HBASE_HOME=$HOME/hbase-2.5.4
source ./conf.sh
echo "HBASE_HOME=$HBASE_HOME"

start_s=`date +%s`
action=$1
case $action in
	start)
		cmd=$HBASE_HOME/bin/start-hbase.sh 
	;;
	stop)
		cmd=$HBASE_HOME/bin/stop-hbase.sh 
	;;
	cleanlog)
		cmd="rm -rf $HBASE_HOME/logs/*"
	;;
	*)
		echo "unknown cmd, exit"
		exit 0
	;;
esac

hosts=(node1 node2 node3)
for host in ${hosts[@]};do
	echo "On $host, execute $cmd"
	ssh user@$host "$cmd"  &
done

wait
stop_s=`date +%s`
cost_s=`echo "$stop_s - $start_s"|bc `
echo "[`date`] Finish all task. Cost $cost_s seconds."
