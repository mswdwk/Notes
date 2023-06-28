ZK_DEFAULT_HOME=$HOME/apache-zookeeper-3.8.1-bin
ZK_NEW_HOME=$HOME/apache-zookeeper-3.8.0-bin

ZK_DEFAULT_DATADIR=$HOME/apache-zookeeper-3.8.1-bin/zook_data
ZK_NEW_DATADIR=/data1/zookeeper_data

mkdir -p $ZK_NEW_DATADIR

#echo 1 > $ZK_NEW_DATADIR/myid

sed -i '/dataDir=/d' $ZK_NEW_HOME/conf/zoo.cfg 
sed -i '$a\'"\ndataDir=$ZK_NEW_DATADIR" $ZK_NEW_HOME/conf/zoo.cfg 

sed -i "s?$ZK_DEFAULT_DATADIR?$ZK_NEW_DATADIR?" ./zookeeper.service

sed -i "s?$ZK_DEFAULT_HOME?$ZK_NEW_HOME?" ./zookeeper.service

