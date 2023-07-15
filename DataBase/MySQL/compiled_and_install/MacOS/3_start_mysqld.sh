# config
echo "`date` start config"
source ./0_vars.sh

echo "`date` start mysqld"
#$BASEDIR/support-files/mysql.server --defaults-file=$BASEDIR/etc/my.cnf 

$BASEDIR/support-files/mysql.server start
echo "`date` finish start mysqld, return $?"
