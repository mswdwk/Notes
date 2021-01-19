# mysqld Init flow On Linux System in flie sql/mysqld.cc
sql/main.cc: main{
	mysqld_main{
		my_init
		load_defaults
		system_charset_info= &my_charset_utf8_general_ci;
		local_message_hook= error_log_print;
		init_sql_statement_names();
 		sys_var_init();
		adjust_related_options(&requested_open_files);
		PSI_hook= initialize_performance_schema(&pfs_param);
		init_error_log
		mysql_audit_initialize()
		query_logger.init();
		init_common_variables();
		my_init_signals();
		my_thread_attr_setstacksize(&connection_attrib,my_thread_stack_size + guardize);
		user_info= check_user(mysqld_user)
		set_user(mysqld_user, user_info);
		/* initiate key migration if any one of the migration specific options are provided.*/
		if (opt_keyring_migration_source || opt_keyring_migration_destination || migrate_connect_options)
		{ Migrate_keyring mk; mk.init ; mk.execute(); unireg_abort(MYSQLD_SUCCESS_EXIT);}
		my_setwd(mysql_real_data_home,MYF(MY_WME));
		init_server_components()
		/* Each server should have one UUID. We will create it automatically, if it does not exist. */
  		init_server_auto_options()
		int gtid_ret= gtid_state->init();
		// Initialize executed_gtids from mysql.gtid_executed table.
		if (gtid_state->read_gtid_executed_from_table() == -1) unireg_abort(1);

		Gtid_set purged_gtids_from_binlog(global_sid_map, global_sid_lock);
    	Gtid_set gtids_in_binlog(global_sid_map, global_sid_lock);
    	Gtid_set gtids_in_binlog_not_in_table(global_sid_map, global_sid_lock);
		mysql_bin_log.init_gtid_sets(xxxxx);

		// some init 
		init_ssl();
		network_init();
		my_str_malloc= &my_str_malloc_mysqld;
		my_str_free= &my_str_free_mysqld;
		my_str_realloc= &my_str_realloc_mysqld;
		error_handler_hook= my_message_sql;

		create_pid_file();  

		reload_optimizer_cost_constants()

		// initialize ACL/grant/time zones	
		if( mysql_rm_tmp_tables() || acl_init(opt_noacl) ||
      		my_tz_init((THD *)0, default_tz_name, opt_bootstrap) ||
      		grant_init(opt_noacl){ delete_pid_file;  unireg_abort(MYSQLD_ABORT_EXIT); }
		servers_init(0);
		init_status_vars();

		check_binlog_cache_size(NULL);
		check_binlog_stmt_cache_size(NULL);
		binlog_unsafe_map_init();
		if (!opt_bootstrap){
			set_slave_skip_errors(&opt_slave_skip_errors);	init_slave();
		}
		initialize_performance_schema_acl(opt_bootstrap);		
		check_performance_schema();		

		initialize_information_schema_acl();
  		execute_ddl_log_recovery();
		RUN_HOOK(server_state, after_recovery, (NULL));
	
		if (Events::init(opt_noacl || opt_bootstrap))
    		unireg_abort(MYSQLD_ABORT_EXIT);

		if (opt_bootstrap)	{start_processing_signals();
			int error= bootstrap(mysql_stdin);unireg_abort(error ? MYSQLD_ABORT_EXIT : MYSQLD_SUCCESS_EXIT);}
	  	if (opt_init_file && *opt_init_file){if (read_init_file(opt_init_file))unireg_abort(MYSQLD_ABORT_EXIT);}

	  /*Event must be invoked after error_handler_hook is assigned to
		my_message_sql, otherwise my_message will not cause the event to abort.*/
	  if (mysql_audit_notify(AUDIT_EVENT(MYSQL_AUDIT_SERVER_STARTUP_STARTUP),(const char **) argv, argc))
		unireg_abort(MYSQLD_ABORT_EXIT);

		start_handle_manager();
  		create_compress_gtid_table_thread();
		
		start_processing_signals();
		set_super_read_only_post_init();
		
		DBUG_PRINT("info", ("Block, listening for incoming connections"));
  		(void)MYSQL_SET_STAGE(0 ,__FILE__, __LINE__);
  		server_operational_state= SERVER_OPERATING;
  		(void) RUN_HOOK(server_state, before_handle_connection, (NULL));


		mysql_mutex_lock(&LOCK_socket_listener_active);
  		// Make it possible for the signal handler to kill the listener.
 		socket_listener_active= true;
  		mysql_mutex_unlock(&LOCK_socket_listener_active);
  		if (opt_daemonize)mysqld::runtime::signal_parent(pipe_write_fd,1);
  		mysqld_socket_acceptor->connection_event_loop();


		// mysqld end
		server_operational_state= SERVER_SHUTTING_DOWN;
		DBUG_PRINT("info", ("No longer listening for incoming connections"));
		mysql_audit_notify(MYSQL_AUDIT_SERVER_SHUTDOWN_SHUTDOWN,MYSQL_AUDIT_SERVER_SHUTDOWN_REASON_SHUTDOWN,MYSQLD_SUCCESS_EXIT);
		terminate_compress_gtid_table_thread();
		gtid_state->save_gtids_of_last_binlog_into_table(false)

		mysql_mutex_lock(&LOCK_socket_listener_active);
		// Notify the signal handler that we have stopped listening for connections.
		socket_listener_active= false;
		mysql_cond_broadcast(&COND_socket_listener_active);
		mysql_mutex_unlock(&LOCK_socket_listener_active);

		PSI_THREAD_CALL(delete_current_thread)();
		ret= my_thread_join(&signal_thread_id, NULL);
		clean_up(1);
  		mysqld_exit(MYSQLD_SUCCESS_EXIT);

	}
}           
