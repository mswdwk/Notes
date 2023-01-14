source ./install.conf.sh
$BASEDIR/bin/mysql -uroot -p -A -e "alter user root@localhost indentified with 'mysql_native_password' by \"${NEW_MYSQL_PASSWORD}\""
#$BASEDIR/bin/mysql -uroot -p -A -e "alter user root@localhost indentified by \"${NEW_MYSQL_PASSWORD}\""
