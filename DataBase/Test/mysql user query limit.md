# test /*create user with query limit */ 
```SQL
 mysql> CREATE USER 'limit'@'%' IDENTIFIED BY 'limit'
 WITH MAX_QUERIES_PER_HOUR 20
 MAX_UPDATES_PER_HOUR 10
 MAX_CONNECTIONS_PER_HOUR 5
 MAX_USER_CONNECTIONS 2;

mysql> show status\G
ERROR 1226 (42000): User 'limit' has exceeded the 'max_questions' resource (current value: 20)
mysql> 



```
# 2 check_mqh code analysis
```C++
check_mqh {
	thd->time_out_user_resource_limits();

  /* Check that we have not done too many questions / hour */
  if (uc->user_resources.questions)
  {
    thd->increment_questions_counter();
    if ((uc->questions - 1) >= uc->user_resources.questions)
    {
      my_error(ER_USER_LIMIT_REACHED, MYF(0), uc->user, "max_questions",
               (long) uc->user_resources.questions);
      error=1;
      goto end;
    }
  }
  if (check_command < (uint) SQLCOM_END)
  {
    /* Check that we have not done too many updates / hour */
    if (uc->user_resources.updates &&
        (sql_command_flags[check_command] & CF_CHANGES_DATA))
    {
      thd->increment_updates_counter();
      if ((uc->updates - 1) >= uc->user_resources.updates)
      {
        my_error(ER_USER_LIMIT_REACHED, MYF(0), uc->user, "max_updates",
                 (long) uc->user_resources.updates);
        error=1;
        goto end;
      }
    }
  }
}
```
# 3 frame check_mqh
```gdb
#0  check_mqh (thd=0x7f41d00125c0, check_command=16) at /home/user/Repos/mysql-server/sql/sql_connect.cc:270
#1  0x0000000001542e1e in mysql_parse (thd=0x7f41d00125c0, parser_state=0x7f4236dfd690)
    at /home/user/Repos/mysql-server/sql/sql_parse.cc:5536
#2  0x0000000001538733 in dispatch_command (thd=0x7f41d00125c0, com_data=0x7f4236dfddf0, command=COM_QUERY)
    at /home/user/Repos/mysql-server/sql/sql_parse.cc:1458
#3  0x000000000153759c in do_command (thd=0x7f41d00125c0) at /home/user/Repos/mysql-server/sql/sql_parse.cc:999
#4  0x0000000001668bbc in handle_connection (arg=0xa9b7300)
    at /home/user/Repos/mysql-server/sql/conn_handler/connection_handler_per_thread.cc:300
#5  0x0000000001ced500 in pfs_spawn_thread (arg=0xa8cc5f0)
    at /home/user/Repos/mysql-server/storage/perfschema/pfs.cc:2190
#6  0x00007f42d24a8dd5 in start_thread () from /lib64/libpthread.so.0

```

# ER_USER_LIMIT_REACHED
* check_for_max_user_connections
* connect_n_handle_errors
* check_mqh

# 查看线程资源占用
进程id是22914
## top
`top -H -p 22914` 
## ps
`ps -H -eo user,pid,ppid,tid,time,%cpu,cmd --sort=%cpu`

# thread cpu 亲和
