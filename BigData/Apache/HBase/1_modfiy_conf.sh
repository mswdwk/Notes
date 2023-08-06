#!/bin/bash
source ./vars.sh
sed -i '/export JAVA_HOME=/d' conf/hbase-env.sh
sed -i '$a\'\
"\nexport JAVA_HOME=$JAVA_HOME"\
"\nexport HBASE_MANAGES_ZK=false"\
 conf/hbase-env.sh
