# On node1
# namenode format
HADOOP_HOME=/home/user/hadoop-3.3.4
hosts=(node1 node2 node3)
for host in ${hosts[@]};
do
ssh user@$host "bash -s" <<ENDSSH
cd $HADOOP_HOME/etc/hadoop
pwd
#ls
sh 1_conf.sh
ENDSSH
done
