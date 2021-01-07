#DATADIR=~/MySQL5.7_1/data
#mkdir -p $DATADIR
sh ./mkdir-mysql-data-dir.sh 
mysqld --defaults-file=./my.cnf --initialize-insecure --user=user
