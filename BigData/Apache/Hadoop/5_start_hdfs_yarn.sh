# On node1
#HADOOP_HOME=/home/user/hadoop-3.3.4
source ./0_vars.sh

ssh user@node1 "bash -s" <<ENDSSH
cd $HADOOP_HOME
sbin/start-dfs.sh
sbin/start-yarn.sh
sbin/mr-jobhistory-daemon.sh start historyserver
jps
ENDSSH
