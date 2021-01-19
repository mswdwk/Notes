# call innodb master_thread stack 
os_thread_create->os_thread_create_func->pthread_create->srv_master_thread

------------------------------------------------------------------------------------
os_thread_create(srv_master_thread,NULL, thread_ids + (1 + SRV_MAX_N_IO_THREADS));

#define os_thread_create(f,a,i)	os_thread_create_func(f, a, i)

os_thread_create_func {
	pthread_attr_init(&attr);
	int	ret = pthread_create(&new_thread_id, &attr, func, arg);
	pthread_attr_destroy(&attr);
}

--------------------------------------------------------------------------------------

extern "C"
os_thread_ret_t
DECLARE_THREAD(srv_master_thread)(
/*==============================*/
	void*	arg MY_ATTRIBUTE((unused)))
			/*!< in: a dummy parameter required by
			os_thread_create */
{
	my_thread_init();

srv_main_thread_process_no = os_proc_get_number();
	srv_main_thread_id = os_thread_pf(os_thread_get_curr_id());


	while (srv_shutdown_state == SRV_SHUTDOWN_NONE) {

		srv_master_sleep();

		MONITOR_INC(MONITOR_MASTER_THREAD_SLEEP);

		if (srv_check_activity(old_activity_count)) {
			old_activity_count = srv_get_activity_count();
			srv_master_do_active_tasks();
		} else {
			srv_master_do_idle_tasks();
		}
	}

	while (srv_shutdown_state != SRV_SHUTDOWN_EXIT_THREADS
	       && srv_master_do_shutdown_tasks(&last_print_time)) {

		/* Shouldn't loop here in case of very fast shutdown */
		ut_ad(srv_fast_shutdown < 2);
	}


os_event_wait(slot->event);

	if (srv_shutdown_state != SRV_SHUTDOWN_EXIT_THREADS) {
		goto loop;
	}


}



