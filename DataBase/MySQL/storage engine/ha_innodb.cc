/** The class defining a handle to an InnoDB table */
class ha_innobase: public handler{

    int write_row(uchar * buf);

	int update_row(const uchar * old_data, uchar * new_data);

	int delete_row(const uchar * buf);

	int delete_all_rows();

	bool was_semi_consistent_read();

	void try_semi_consistent_read(bool yes);

	void unlock_row();

	int index_init(uint index, bool sorted);

	int index_end();

    void update_create_info(HA_CREATE_INFO* create_info);

	int create(
		const char*		name,
		TABLE*			form,
		HA_CREATE_INFO*		create_info);

	int truncate();

	int delete_table(const char *name);

	int rename_table(const char* from, const char* to);

	int check(THD* thd, HA_CHECK_OPT* check_opt);

	char* get_foreign_key_create_info();

    void init_table_handle_for_HANDLER();

        virtual void get_auto_increment(
		ulonglong		offset,
		ulonglong		increment,
		ulonglong		nb_desired_values,
		ulonglong*		first_value,
		ulonglong*		nb_reserved_values);

	virtual bool get_error_message(int error, String *buf);

	virtual bool get_foreign_dup_key(char*, uint, char*, uint);

	uint8 table_cache_type();

    bool inplace_alter_table(
		TABLE*			altered_table,
		Alter_inplace_info*	ha_alter_info);

        void update_thd(THD* thd);

	int general_fetch(uchar* buf, uint direction, uint match_mode);

	virtual dict_index_t* innobase_get_index(uint keynr);

}



mysql_declare_plugin(innobase){
    MYSQL_STORAGE_ENGINE_PLUGIN,
    &innobase_storage_engine,
    innobase_hton_name,
    PLUGIN_AUTHOR_ORACLE,
    "Supports transactions, row-level locking, and foreign keys",
    PLUGIN_LICENSE_GPL,
    innodb_init,   /* Plugin Init */
    nullptr,       /* Plugin Check uninstall */
    innodb_deinit, /* Plugin Deinit */
    INNODB_VERSION_SHORT,
    innodb_status_variables_export, /* status variables */
    innobase_system_variables,      /* system variables */
    nullptr,                        /* reserved */
    0,                              /* flags */
},
i_s_innodb_trx,
i_s_innodb_locks,
i_s_innodb_lock_waits,
i_s_innodb_cmp,
i_s_innodb_cmp_reset,
i_s_innodb_cmpmem,
i_s_innodb_cmpmem_reset,
i_s_innodb_cmp_per_index,
i_s_innodb_cmp_per_index_reset,
i_s_innodb_buffer_page,
i_s_innodb_buffer_page_lru,
i_s_innodb_buffer_stats,
i_s_innodb_temp_table_info,
i_s_innodb_metrics,
i_s_innodb_ft_default_stopword,
i_s_innodb_ft_deleted,
i_s_innodb_ft_being_deleted,
i_s_innodb_ft_config,
i_s_innodb_ft_index_cache,
i_s_innodb_ft_index_table,
i_s_innodb_sys_tables,
i_s_innodb_sys_tablestats,
i_s_innodb_sys_indexes,
i_s_innodb_sys_columns,
i_s_innodb_sys_fields,
i_s_innodb_sys_foreign,
i_s_innodb_sys_foreign_cols,
i_s_innodb_sys_tablespaces,
i_s_innodb_sys_datafiles,
i_s_innodb_sys_virtual

mysql_declare_plugin_end;




plugin_register_dynamic_and_init_all