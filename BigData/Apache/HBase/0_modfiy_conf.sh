#!/bin/bash
HBASE_HOME=$HOME/hbase-2.5.4
JAVA_HOME=/usr/lib/jdk-21

sed -i '$a\'\
"\nexport JAVA_HOME=$JAVA_HOME"\
"\nexport HBASE_MANAGES_ZK=false"\
 conf/hbase-env.sh
