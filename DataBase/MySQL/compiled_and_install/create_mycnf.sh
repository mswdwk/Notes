USER=user
INSTALL_DIR_NAME=mysql5722
MYSQL_PORT=3310
MAX_UNDO_LOG_SIZE=512M
SERVER_ID=1
#cat < my.cnf.default > my.cnf1
#DOC_CONT=$(cat my.cnf.default)
cat <<EOF > my.cnf
[general]
instance_num = 1
[mysqld]
bind_address=0.0.0.0
port=$MYSQL_PORT
sync_binlog=1
innodb_flush_log_at_trx_commit=1
transaction_isolation=READ-COMMITTED
slow_query_log=on
long_query_time=0.6
basedir=/home/$USER/$INSTALL_DIR_NAME
datadir=/home/$USER/$INSTALL_DIR_NAME/data/data
innodb_data_file_path=ibdata1:300M:autoextend
innodb_data_home_dir=/home/$USER/$INSTALL_DIR_NAME/data/data
innodb_undo_directory=/home/$USER/$INSTALL_DIR_NAME/data/undo
innodb_max_undo_log_size=$MAX_UNDO_LOG_SIZE
innodb_log_group_home_dir=/home/$USER/$INSTALL_DIR_NAME/data/redo
innodb_lock_wait_timeout=10
innodb_print_all_deadlocks=ON
innodb_write_io_threads=8
innodb_read_io_threads=8
innodb-file-per-table
innodb_io_capacity=1000 # for ssd disk, as for hdd disk ,this is 200 by default
innodb_io_capacity_max=2000 # for ssd disk , iops
innodb_open_files=65535
innodb-buffer-pool-instances=2
innodb-buffer-pool-size=1G
innodb_page_cleaners=4
log-bin=../binlog/mysql-bin
binlog_format=ROW
max_binlog_size=104857600
relay-log=../relaylog/relay-bin
log-error=/home/$USER/$INSTALL_DIR_NAME/log/mysqld1.log
pid-file=/home/$USER/$INSTALL_DIR_NAME/mysqld1.pid
tmpdir=/home/$USER/$INSTALL_DIR_NAME/data/tmp
socket=/home/$USER/$INSTALL_DIR_NAME/bin/mysql1.sock
server_id=$SERVER_ID
gtid_mode=on
enforce_gtid_consistency=on
#defaults_file=/home/$USER/$INSTALL_DIR_NAME/etc/my.cnf

binlog_ignore_db=sys, mysql,performance_schema,information_schema ;日志记录忽略那些数据库的
#binlog_do_db = testdb
expire_logs_days=3

[client]
socket=/home/$USER/$INSTALL_DIR_NAME/bin/mysql1.sock
port=$MYSQL_PORT
EOF

