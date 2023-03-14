# config
echo "`date` start config"
. ./install.conf.sh

sed -i 's"$bindir/mysqld_safe --datadir"$bindir/mysqld_safe --defaults-file=$basedir/my.cnf --datadir"' $BASEDIR/support-files/mysql.server
sed -i 's/extra_args="-e/extra_args="-c/' $BASEDIR/support-files/mysql.server
echo "`date` start mysqld"
#$BASEDIR/support-files/mysql.server --defaults-file=$BASEDIR/etc/my.cnf 

$BASEDIR/support-files/mysql.server start
echo "`date` finish start mysqld"
