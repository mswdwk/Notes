ZK_HOME=$HOME/apache-zookeeper-3.8.1-bin
sed -i '/dataDir=/d' $ZK_HOME/conf/zoo.cfg 
sed -i '$a\'"\ndataDir=$ZK_HOME/zook_data" $ZK_HOME/conf/zoo.cfg 
