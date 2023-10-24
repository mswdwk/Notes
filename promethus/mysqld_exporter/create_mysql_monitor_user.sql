create user monitor@'%' identified by '1qaz2wsx..';
grant select,process,replication client on *.* to monitor@'%';
flush privileges;
