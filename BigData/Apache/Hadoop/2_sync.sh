HADOOP_HOME=$HOME/hadoop-3.3.4
hosts=(node2 node3)
for host in ${hosts[@]};do
	echo $host
	scp 1_conf.sh user@$host:$HADOOP_HOME/etc/hadoop/
	scp conf/* user@$host:$HADOOP_HOME/etc/hadoop/
done
