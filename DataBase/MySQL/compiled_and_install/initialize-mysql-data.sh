BASEDIR=~/MySQL5.7
OLD_USER_NAME=user
NEW_USER_NAME=mysql2
PORT=3310

rm -rf $BASEDIR/data/

#mkdir -p $DATADIR
#sed -i 's/home\/user\/MySQL5.7_1/home\/mysql2\/MySQL5.7/g' ./my.cnf
#sed -i 's/MySQL5.7_1/MySQL5.7/g' ./my.cnf
sed -i "s/^port=.*/port=${PORT}/g" ./my.cnf
#sed -i 's/home\/user\/MySQL5.7_1/home\/mysql2\/MySQL5.7/g' ./mkdir-mysql-data-dir.sh
#sed -i 's/MySQL5.7_1/MySQL5.7/g' ./mkdir-mysql-data-dir.sh
#sed -i 's/MySQL5.7_1/MySQL5.7/g' $BASEDIR/support-files/mysql.server
sed -i "s/${OLD_USER_NAME}\/MySQL5.7/${NEW_USER_NAME}\/MySQL5.7/g" $BASEDIR/support-files/mysql.server
sh ./mkdir-mysql-data-dir.sh 
cp -f my.cnf $BASEDIR/
cp -f $BASEDIR/support-files/mysql.server $BASEDIR/bin/
chmod +x $BASEDIR/bin/mysql.server

$BASEDIR/bin/mysqld --defaults-file=$BASEDIR/my.cnf --initialize-insecure --user=${NEW_USER_NAME}
