# On node1
# namenode format
HADOOP_HOME=/home/user/hadoop-3.3.4
ssh user@node1 "bash -s" <<ENDSSH
pwd
cd $HADOOP_HOME
ls
echo "start format namenode On node1"
bin/hadoop namenode -format

ENDSSH
