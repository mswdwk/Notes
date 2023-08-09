#cd /home/user/hadoop-3.3.4
source ./0_vars.sh
cd $HADOOP_HOME
 bin/hadoop jar  share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.4.jar pi 2 10

cd -
