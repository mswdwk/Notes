mysql --login-path=root -e "create database if not exists foo"
#sysbench /usr/share/sysbench/oltp_read_only.lua --db-driver=mysql --table_size=100000 --mysql-host=localhost  --mysql-protocol=tcp --mysql-db=foo --mysql-user=root --mysql-password='Roo123.' prepare
sysbench /usr/share/sysbench/oltp_read_only.lua --db-driver=mysql --table_size=100000 --mysql-host=localhost --mysql-socket=/home/user/MySQL5.7_1/bin/mysql1.sock  --mysql-port=3306 --mysql-db=foo --mysql-user=root --mysql-password='Roo123.' prepare
