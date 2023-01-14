#!/bin/bash

source ./install.conf.sh
# first time , the password is empty, then you shold create a password
$BASEDIR/bin/mysql_config_editor set --user=root --port=$PORT --socket=$BASEDIR/bin/mysql1.sock --password
