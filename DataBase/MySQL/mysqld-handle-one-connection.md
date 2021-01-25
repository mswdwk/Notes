mysqld_socket_acceptor->connection_event_loop(){
	One_thread_connection_handler::add_connection{
		THD* thd= channel_info->create_thd();
		thd_set_thread_stack(thd, (char*) &thd);

		mysql_thread_set_psi_id(thd->thread_id());
	  mysql_socket_set_thread_owner(thd->get_protocol_classic()->get_vio()->mysql_socket);

	  Global_THD_manager *thd_manager= Global_THD_manager::get_instance();
	  thd_manager->add_thd(thd);

	  bool error= false;
	  if (thd_prepare_connection(thd))
		error= true; // Returning true causes inc_aborted_connects() to be called.
	  else
	  {
		delete channel_info;
		while (thd_connection_alive(thd))
		{
		  if (do_command(thd))break;
		}
		end_connection(thd);
	  }
	  close_connection(thd, 0, false, false);
	  thd->release_resources();
	  thd_manager->remove_thd(thd);
	  Connection_handler_manager::dec_connection_count();
		delete thd;
	  	return error;
	}
}

void Connection_handler_manager::process_new_connection(Channel_info* channel_info)
{
  if (abort_loop || !check_and_incr_conn_count())
  {
    channel_info->send_error_and_close_channel(ER_CON_COUNT_ERROR, 0, true);
    delete channel_info;
    return;
  }

  if (m_connection_handler->add_connection(channel_info))
  {
    inc_aborted_connects();
    delete channel_info;
  }
}

void connection_event_loop()
  {
    Connection_handler_manager *mgr= Connection_handler_manager::get_instance();
    while (!abort_loop)
    {
      Channel_info *channel_info= m_listener->listen_for_connection_event();
      if (channel_info != NULL)
        mgr->process_new_connection(channel_info);
    }
  }
