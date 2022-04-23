
```
/*
  Plugin interface.
*/
struct st_mysql_group_replication group_replication_descriptor=
{
  MYSQL_GROUP_REPLICATION_INTERFACE_VERSION,
  plugin_group_replication_start,
  plugin_group_replication_stop,
  plugin_is_group_replication_running,
  plugin_group_replication_set_retrieved_certification_info,
  plugin_get_connection_status,
  plugin_get_group_members,
  plugin_get_group_member_stats,
  plugin_get_group_members_number,
};


mysql_declare_plugin(group_replication_plugin)
{
  MYSQL_GROUP_REPLICATION_PLUGIN,
  &group_replication_descriptor,
  group_replication_plugin_name,
  "ORACLE",
  "Group Replication (1.0.0)",      /* Plugin name with full version*/
  PLUGIN_LICENSE_GPL,
  plugin_group_replication_init,    /* Plugin Init */
  plugin_group_replication_deinit,  /* Plugin Deinit */
  0x0100,                           /* Plugin Version: major.minor */
  group_replication_status_vars,    /* status variables */
  group_replication_system_vars,    /* system variables */
  NULL,                             /* config options */
  0,                                /* flags */
}
mysql_declare_plugin_end;
```
plugin_group_replication_start{
	
	server_engine_initialized()
	init_group_sidno()
	/*
	Instantiate certification latch.
	*/
	certification_latch= new Wait_ticket<my_thread_id>();
	// GR delayed initialization.
	server_engine_initialized()
	initialize_plugin_and_join{
		gcs_module->initialize()
		// Setup GCS.
		configure_group_communication(&server_ssl_variables)
		// Setup Group Member Manager.
		configure_group_member_manager(hostname, uuid, port,server_version)
		check_async_channel_running_on_secondary()
		configure_compatibility_manager()
		
		// need to be initialized before applier, is called on kill_pending_transactions
		blocked_transaction_handler= new Blocked_transaction_handler();
  
		error= initialize_recovery_module()

		// we can only start the applier if the log has been initialized
		configure_and_start_applier_module(){
			applier_module= new Applier_module();
			recovery_module->set_applier_module(applier_module);
			//For now, only defined pipelines are accepted.
			error = applier_module->setup_applier_module(STANDARD_GROUP_REPLICATION_PIPELINE,
                                         known_server_reset,
                                         components_stop_timeout_var,
                                         group_sidno,
                                         gtid_assignment_block_size_var,
                                         shared_plugin_stop_lock);
			applier_module->initialize_applier_thread()
			known_server_reset= false;
			log_message(MY_INFORMATION_LEVEL,"Group Replication applier module successfully initialized!");
		}
		initialize_asynchronous_channels_observer();
		initialize_group_partition_handler();
		
		error= start_group_communication()
		
		view_change_notifier->wait_for_view_modification()
		
		group_replication_running= true;
		log_primary_member_details();
		
		if(error){}
		delete sql_command_interface;
		plugin_is_auto_starting= false;
	}
}