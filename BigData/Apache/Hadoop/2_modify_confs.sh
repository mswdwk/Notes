# reference : https://zhuanlan.zhihu.com/p/524144786

# edit etc/hadoop-env.sh ,set JAVA_HOME path

#export HADOOP_HOME=/home/user/hadoop-3.3.5
source ./0_vars.sh
#HADOOP_DATA_ROOT=/data1/hadoop_data

sed -i '$a\'\
"\nexport JAVA_HOME=$JAVA_HOME"\
"\nexport HADOOP_HOME=$HADOOP_HOME"\
"\nexport HADOOP_OPTS=\" --add-opens java.base/java.lang=ALL-UNNAMED \""\
 ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh
echo "?=$?"

sed -i '$a\'\
"\nexport JAVA_HOME=$JAVA_HOME"\
 $HADOOP_HOME/etc/hadoop/mapred-env.sh

echo "?=$?"
#echo "export JAVA_HOME=$JAVA_HOME">>${HADOOP_HOME}/etc/hadoop/hadoop-env.sh
#echo "export JAVA_HOME=$JAVA_HOME">>$HADOOP_HOME/etc/hadoop/mapred-env.sh
#echo "export HADOOP_HOME=$HADOOP_HOME">>$HADOOP_HOME/etc/hadoop/hadoop-env.sh
#echo "export HADOOP_OPTS=\" --add-opens java.base/java.lang=ALL-UNNAMED \"">>$HADOOP_HOME/etc/hadoop/hadoop-env.sh

# java version > 8

# pay attention to dir 'limits of authority'

mkdir -p $HADOOP_DATA_ROOT/tmpDatas
mkdir -p $HADOOP_DATA_ROOT/nameNodeDatas
mkdir -p $HADOOP_DATA_ROOT/dataNodeDatas
mkdir -p $HADOOP_DATA_ROOT/nn/edits
mkdir -p $HADOOP_DATA_ROOT/snn/name
mkdir -p $HADOOP_DATA_ROOT/dfs/snn/edits


sed -i "s?/data1/hadoop_data?$HADOOP_DATA_ROOT?g" $HADOOP_HOME/etc/hadoop/core-site.xml
sed -i "s?/data1/hadoop_data?$HADOOP_DATA_ROOT?g" $HADOOP_HOME/etc/hadoop/hdfs-site.xml
sed -i "s?/home/user/hadoop-3.3.4?$HADOOP_HOME?g" $HADOOP_HOME/etc/hadoop/mapred-site.xml
