PHOENIX_ROOTDIR=~/trinodb/phoenix-hbase-2.5-5.1.3-bin 
HBASE_ROOTDIR=~/hbase-2.5.3
ZK_SERVER=node3:12181

#cp $PHOENIX_ROOTDIR/phoenix-*-server.jar $PHOENIX_ROOTDIR/phoenix-core*.jar $HBASE_ROOTDIR/lib
cp  $PHOENIX_ROOTDIR/phoenix-server-hbase*.jar $HBASE_ROOTDIR/lib
cp  $HBASE_ROOTDIR/conf/hbase-site.xml $PHOENIX_ROOTDIR/bin/

echo `date` restart hbase
$HBASE_ROOTDIR/bin/stop-hbase.sh
$HBASE_ROOTDIR/bin/start-hbase.sh


echo `date` start hbase sql client
$PHOENIX_ROOTDIR/bin/sqlline.py $ZK_SERVER
