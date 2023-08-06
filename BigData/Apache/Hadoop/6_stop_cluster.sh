#cd /home/user/hadoop-3.3.4
source ./0_vars.sh
cd $HADOOP_HOME
sbin/stop-dfs.sh
sbin/stop-yarn.sh
sbin/mr-jobhistory-daemon.sh stop historyserver
cd -
