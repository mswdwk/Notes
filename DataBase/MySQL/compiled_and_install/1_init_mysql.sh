# config
echo "`date` start config"
export BASEDIR=/home/user/mysql5722

#init dir

echo "`date` start init data dir"
mkdir -p $BASEDIR/data/data
mkdir -p $BASEDIR/data/tmp
mkdir -p $BASEDIR/data/undo
mkdir -p $BASEDIR/data/redo
mkdir -p $BASEDIR/log
mkdir -p $BASEDIR/data/binlog
mkdir -p $BASEDIR/data/relaylog
mkdir -p $BASEDIR/etc
#init my.cnf
echo "`date` start init my.cnf"
sh create_mycnf.sh
exit 0
#init db
echo "`date` start init database"
$BASEDIR/bin/mysqld --defaults-file=$BASEDIR/etc/my.cnf --initialize-insecure
echo "`date` finish init database"
