# On node1
# namenode format
HADOOP_HOME=/home/user/hadoop-3.3.5
JAVA_HOME=/usr/lib/jdk-21
ssh user@node1 "bash -s" <<ENDSSH
pwd
#/usr/sbin/ifconfig
#ifconfig
cd $HADOOP_HOME
sbin/hadoop-daemon.sh start namenode
sbin/hadoop-daemon.sh start datanode
sbin/yarn-daemon.sh  start resourcemanager
sbin/yarn-daemon.sh start nodemanager
$JAVA_HOME/bin/jps
ENDSSH

HOSTS=(node2 node3)
for host in ${HOSTS[@]};
do
echo "run ON $host,starting datanode,nodemanager"
ssh user@$host "bash -s" <<ENDSSH
cd $HADOOP_HOME
pwd
sbin/hadoop-daemon.sh start datanode
sbin/yarn-daemon.sh start nodemanager
$JAVA_HOME/bin/jps
ENDSSH
done

ssh user@node1 "bash -s" <<ENDSSH
cd $HADOOP_HOME
sbin/start-dfs.sh
sbin/start-yarn.sh
sbin/mr-jobhistory-daemon.sh start historyserver
$JAVA_HOME/bin/jps
ENDSSH
