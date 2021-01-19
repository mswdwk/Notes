# mysql create thread
mysql_thread_create
create_thread

pfs_new_thread_v1

PFS_thread_allocator thread_allocator;
PFS_thread_container global_thread_container(& thread_allocator);

class PFS_thread_array 

# mysql thread keys
PSI_thread_key key_thread_bootstrap, key_thread_handle_manager, key_thread_main,
  key_thread_one_connection, key_thread_signal_hand,
  key_thread_compress_gtid_table, key_thread_parser_service;
PSI_thread_key key_thread_timer_notifier;

# all_server_threads
static PSI_thread_info all_server_threads[]=
{
#if defined (_WIN32) && !defined (EMBEDDED_LIBRARY)
  { &key_thread_handle_con_namedpipes, "con_named_pipes", PSI_FLAG_GLOBAL},
  { &key_thread_handle_con_sharedmem, "con_shared_mem", PSI_FLAG_GLOBAL},
  { &key_thread_handle_con_sockets, "con_sockets", PSI_FLAG_GLOBAL},
  { &key_thread_handle_shutdown, "shutdown", PSI_FLAG_GLOBAL},
#endif /* _WIN32 && !EMBEDDED_LIBRARY */
  { &key_thread_timer_notifier, "thread_timer_notifier", PSI_FLAG_GLOBAL},
  { &key_thread_bootstrap, "bootstrap", PSI_FLAG_GLOBAL},
  { &key_thread_handle_manager, "manager", PSI_FLAG_GLOBAL},
  { &key_thread_main, "main", PSI_FLAG_GLOBAL},
  { &key_thread_one_connection, "one_connection", 0},
  { &key_thread_signal_hand, "signal_handler", PSI_FLAG_GLOBAL},
  { &key_thread_compress_gtid_table, "compress_gtid_table", PSI_FLAG_GLOBAL},
  { &key_thread_parser_service, "parser_service", PSI_FLAG_GLOBAL},
};

# some call thread function
start_handle_manager{handle_manager}
create_compress_gtid_table_thread()
