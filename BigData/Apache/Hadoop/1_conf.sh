# reference : https://zhuanlan.zhihu.com/p/524144786

# edit etc/hadoop-env.sh ,set JAVA_HOME path


HADOOP_HOME=/home/user/hadoop-3.3.5
HADOOP_DATA_ROOT=/data1/hadoop_data
echo "export JAVA_HOME=/usr/lib/jvm/jdk-19.0.1" >> $HADOOP_HOME/etc/hadoop-env.sh
echo "export HADOOP_HOME=$HADOOP_HOME" >> $HADOOP_HOME/etc/hadoop-env.sh
echo "export HADOOP_OPTS=\" --add-opens java.base/java.lang=ALL-UNNAMED \" >>$HADOOP_HOME/etc/hadoop-env.sh

echo "export JAVA_HOME=/usr/lib/jvm/jdk-19.0.1" >> $HADOOP_HOME/etc/mapred-env.sh

# java version > 8

#echo "HDFS_NAMENODE_OPTS=\"\""

# pay attention to dir 'limits of authority'

mkdir -p $HADOOP_DATA_ROOT/tmpDatas
mkdir -p $HADOOP_DATA_ROOT/nameNodeDatas
mkdir -p $HADOOP_DATA_ROOT/dataNodeDatas
mkdir -p $HADOOP_DATA_ROOT/nn/edits
mkdir -p $HADOOP_DATA_ROOT/snn/name
mkdir -p $HADOOP_DATA_ROOT/dfs/snn/edits
