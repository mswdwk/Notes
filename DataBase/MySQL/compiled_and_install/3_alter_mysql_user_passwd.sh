source ./install.conf.sh
$BASEDIR/bin/mysql -uroot -S$BASEDIR/bin/mysql1.sock  -p -A -e "alter user root@localhost identified with \"mysql_native_password\" by \"${NEW_MYSQL_PASSWORD}\""
#$BASEDIR/bin/mysql -uroot -p -A -e "alter user root@localhost identified by \"${NEW_MYSQL_PASSWORD}\""
