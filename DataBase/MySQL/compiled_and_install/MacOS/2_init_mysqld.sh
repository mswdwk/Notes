# config
echo "`date` start config"
source ./0_vars.sh
echo "INSTALL_DIR_NAME=$INSTALL_DIR_NAME"

#init my.cnf
echo "`date` start init my.cnf"
sh create_mycnf.sh

sed -i 's"$bindir/mysqld_safe --datadir"$bindir/mysqld_safe --defaults-file=$basedir/my.cnf --datadir"' $BASEDIR/support-files/mysql.server
sed -i 's/extra_args="-e/extra_args="-c/' $BASEDIR/support-files/mysql.server

#init db data/data dir
echo "`date` start init database"
$BASEDIR/bin/mysqld --defaults-file=$BASEDIR/my.cnf --initialize-insecure
if [ $? -eq 0 ]; then
	echo "`date` finish init database, SUCCESS!" 
else
	echo "`date` finish init database, FAILED !"
	echo "please read log in $BASEDIR/log/mysqld1.log"
	grep -ni error $BASEDIR/log/mysqld1.log -C 2
fi
