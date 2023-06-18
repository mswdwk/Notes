hosts=(node2 node3)
for host in ${hosts[@]};do
	echo $host
	scp 1_conf.sh user@$host:~/hadoop-3.3.5/etc/hadoop/
	scp conf/* user@$host:~/hadoop-3.3.5/etc/hadoop/
done
