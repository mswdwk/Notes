```
#0  row_ins_clust_index_entry (index=0x49a44e0, entry=0x7f3940006fc0, thr=0x7f39400044f8, n_ext=0, 
    dup_chk_only=false) at /home/user/Repos/mysql-server/storage/innobase/row/row0ins.cc:3284
#1  0x00000000019f9743 in row_ins_index_entry (index=0x49a44e0, entry=0x7f3940006fc0, 
    thr=0x7f39400044f8) at /home/user/Repos/mysql-server/storage/innobase/row/row0ins.cc:3458
#2  0x00000000019f9c83 in row_ins_index_entry_step (node=0x7f3940004230, thr=0x7f39400044f8)
    at /home/user/Repos/mysql-server/storage/innobase/row/row0ins.cc:3608
#3  0x00000000019fa00d in row_ins (node=0x7f3940004230, thr=0x7f39400044f8)
    at /home/user/Repos/mysql-server/storage/innobase/row/row0ins.cc:3750
#4  0x00000000019fa631 in row_ins_step (thr=0x7f39400044f8)
    at /home/user/Repos/mysql-server/storage/innobase/row/row0ins.cc:3935
#5  0x00000000019c496f in que_thr_step (thr=0x7f39400044f8)
    at /home/user/Repos/mysql-server/storage/innobase/que/que0que.cc:1033
#6  0x00000000019c4c67 in que_run_threads_low (thr=0x7f39400044f8)
    at /home/user/Repos/mysql-server/storage/innobase/que/que0que.cc:1115
#7  0x00000000019c4e1d in que_run_threads (thr=0x7f39400044f8)
    at /home/user/Repos/mysql-server/storage/innobase/que/que0que.cc:1155
#8  0x00000000019c50d3 in que_eval_sql (info=0x7f3940002430, 
    sql=0x21b6940 "PROCEDURE TABLE_STATS_SAVE () IS\nBEGIN\nDELETE FROM \"mysql/innodb_table_stats\"\nWHERE\ndatabase_name = :database_name AND\ntable_name = :table_name;\nINSERT INTO \"mysql/innodb_table_stats\"\nVALUES\n(\n:databa"..., reserve_dict_mutex=0, trx=0x7f399f574d08)
    at /home/user/Repos/mysql-server/storage/innobase/que/que0que.cc:1232
#9  0x0000000001bc44bd in dict_stats_exec_sql (pinfo=0x7f3940002430, 
    sql=0x21b6940 "PROCEDURE TABLE_STATS_SAVE () IS\nBEGIN\nDELETE FROM \"mysql/innodb_table_stats\"\nWHERE\ndatabase_name = :database_name AND\ntable_name = :table_name;\nINSERT INTO \"mysql/innodb_table_stats\"\nVALUES\n(\n:databa"..., trx=0x7f399f574d08)
    at /home/user/Repos/mysql-server/storage/innobase/dict/dict0stats.cc:311
#10 0x0000000001bc7ffc in dict_stats_save (table_orig=0x7f3924023bc0, only_for_index=0x0)
    at /home/user/Repos/mysql-server/storage/innobase/dict/dict0stats.cc:2415
#11 0x0000000001bc98a8 in dict_stats_update (table=0x7f3924023bc0, 
    stats_upd_option=DICT_STATS_RECALC_PERSISTENT)
    at /home/user/Repos/mysql-server/storage/innobase/dict/dict0stats.cc:3112
#12 0x0000000001bce34e in dict_stats_process_entry_from_recalc_pool ()
    at /home/user/Repos/mysql-server/storage/innobase/dict/dict0stats_bg.cc:356
#13 0x0000000001bce58c in dict_stats_thread (arg=0x0)
    at /home/user/Repos/mysql-server/storage/innobase/dict/dict0stats_bg.cc:445
#14 0x00007f39adb5cdd5 in start_thread () from /lib64/libpthread.so.0

```
