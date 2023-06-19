# On node1
# namenode format
HADOOP_HOME=/home/user/hadoop-3.3.4
ssh user@node1 "bash -s" <<ENDSSH
pwd
#/usr/sbin/ifconfig
#ifconfig
cd $HADOOP_HOME
ls
echo "start format namenode On node1"
bin/hadoop namenode -format
sbin/hadoop-daemon.sh start namenode
sbin/hadoop-daemon.sh start datanode
sbin/yarn-daemon.sh  start resourcemanager
sbin/yarn-daemon.sh start nodemanager
jps

ENDSSH

HOSTS=(node2 node3)
for host in ${HOSTS[@]};
do
ssh user@$host "bash -s" <<ENDSSH
pwd
#/usr/sbin/ifconfig
#ifconfig
cd $HADOOP_HOME
ls
sbin/hadoop-daemon.sh start datanode
sbin/yarn-daemon.sh start nodemanager
jps
ENDSSH
done

ssh user@node1 "bash -s" <<ENDSSH
sbin/start-dfs.sh
sbin/start-yarn.sh
sbin/mr-jobhistory-daemon.sh start historyserver
jps
ENDSSH
