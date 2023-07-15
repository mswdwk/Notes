#!/bin/bash

source ./0_vars.sh
# first time , the password is empty, then you shold create a password
#echo $NEW_MYSQL_PASSWORD|$BASEDIR/bin/mysql_config_editor set --user=root --port=$MYSQL_PORT --socket=$BASEDIR/bin/mysql1.sock --password
$BASEDIR/bin/mysql_config_editor set --user=root --port=$MYSQL_PORT --socket=$BASEDIR/bin/mysql1.sock --password
