source ./0_vars.sh

hosts=(node1 node2 node3)
for host in ${hosts[@]};do
	echo $host
	scp 0_vars.sh 2_modify_confs.sh user@$host:$HADOOP_HOME/etc/hadoop/
	scp conf/* user@$host:$HADOOP_HOME/etc/hadoop/
done
