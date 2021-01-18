do_command->dispatch_command->{case COM_QUERY: mysql_parse(thd, &parser_state)}

mysql_parse->{parse_sql,mysql_execute_command }

mysql_execute_command -> {case SQLCOM_SELECT: execute_sqlcom_select,
SQLCOM_INSERT: res= lex->m_sql_cmd->execute(thd);
if (thd->is_error() || (thd->variables.option_bits & OPTION_MASTER_SQL_ERROR))
	trans_rollback_stmt(thd);
else
	trans_commit_stmt(thd);
}

lex->m_sql_cmd->execute  -> Sql_cmd_insert::execute(THD *thd) ->Sql_cmd_insert:: mysql_insert
->{
	open_tables_for_query,
	run_before_dml_hook,mysql_prepare_insert, 
	Modification_plan plan(thd,(lex->sql_command == SQLCOM_INSERT) ?
                         MT_INSERT : MT_REPLACE, insert_table,NULL, false, 0);
	if (lex->describe)
	{
		err= explain_single_table_modification(thd, &plan, select_lex);
		goto exit_without_my_ok;
	}
	prepare_triggers_for_insert_stmt(insert_table);
	error= write_record(thd, insert_table, &info, &update);
}

write_record->{ table->file->ha_write_row 
table->triggers->process_triggers(thd, TRG_EVENT_INSERT,TRG_ACTION_AFTER, TRUE));
mysql_prepare_blob_values
}

ha_write_row -> {
mark_trx_read_write();
 MYSQL_TABLE_IO_WAIT(PSI_TABLE_WRITE_ROW, MAX_KEY, error,{ error= write_row(buf); })
 binlog_log_row(table, 0, buf, log_func)
}

ha_innobase::write_row{
if (high_level_read_only) {
		ib_senderrf(ha_thd(), IB_LOG_LEVEL_WARN, ER_READ_ONLY_MODE);
		DBUG_RETURN(HA_ERR_TABLE_READONLY);
	}
ha_statistic_increment(&SSV::ha_write_count);
/* Step-3: Handling of Auto-Increment Columns. */
error_result = update_auto_increment()
/* Step-4: Prepare INSERT graph that will be executed for actual INSERT
build_template(true);
innobase_srv_conc_enter_innodb
/* Step-5: Execute insert graph that will result in actual insert. */
error = row_insert_for_mysql((byte*) record, m_prebuilt);
/* Step-6: Handling of errors related to auto-increment. */

innobase_srv_conc_exit_innodb(m_prebuilt);


report_error:
	/* Step-7: Cleanup and exit. */
	if (error == DB_TABLESPACE_DELETED) {
		ib_senderrf(
			trx->mysql_thd, IB_LOG_LEVEL_ERROR,
			ER_TABLESPACE_DISCARDED,
			table->s->table_name.str);
	}

	error_result = convert_error_code_to_mysql(
		error, m_prebuilt->table->flags, m_user_thd);

	if (error_result == HA_FTS_INVALID_DOCID) {
		my_error(HA_FTS_INVALID_DOCID, MYF(0));
	}

func_exit:
	innobase_active_small();

	DBUG_RETURN(error_result);
}


row_insert_for_mysql_using_ins_graph{
row_mysql_delay_if_needed();

	trx_start_if_not_started_xa(trx, true);

	row_get_prebuilt_insert_row(prebuilt);
	node = prebuilt->ins_node;

	row_mysql_convert_row_to_innobase(node->row, prebuilt, mysql_rec,
					  &blob_heap);

	savept = trx_savept_take(trx);

	thr = que_fork_get_first_thr(prebuilt->ins_graph);
	que_thr_move_to_run_state_for_mysql(thr, trx);
	row_ins_step(thr);
}

row_ins_step{
err = row_ins(node, thr);
}

row_ins{
	row_ins_index_entry_step{
		err = row_ins_index_entry_set_vals(node->index, node->entry, node->row);
		err = row_ins_index_entry(node->index, node->entry, thr);
	}
}


------------------------------------------------------------------------------------
Sql_cmd *PT_insert::make_cmd(THD *thd)
class Sql_cmd_insert : public Sql_cmd_insert_base
class Sql_cmd_insert_base : public Sql_cmd_dml;
class Sql_cmd_dml : public Sql_cmd;
class Sql_cmd : public Sql_alloc{
	virtual bool execute(THD *thd) = 0;
}

class Sql_cmd_insert : public Sql_cmd_insert_base
{
public:
  explicit
  Sql_cmd_insert(bool is_replace_arg, enum_duplicates duplicates_arg)
  : Sql_cmd_insert_base(is_replace_arg, duplicates_arg)
  {}

  virtual enum_sql_command sql_command_code() const
  {
    return is_replace ?  SQLCOM_REPLACE : SQLCOM_INSERT;
  }

  virtual bool execute(THD *thd);
  virtual bool prepared_statement_test(THD *thd);
  virtual bool prepare(THD *thd) { return false; }

private:
  bool mysql_insert(THD *thd,TABLE_LIST *table);

  bool mysql_test_insert(THD *thd, TABLE_LIST *table_list);
};


Sql_cmd *PT_insert::make_cmd(THD *thd) {
	sql_cmd= new (thd->mem_root) Sql_cmd_insert(is_replace, thd->lex->duplicates);

}
-------------------------------------------------------------------------------------
sql_insert.cc
```cpp 
bool Sql_cmd_insert::execute(THD *thd)
{
  DBUG_ASSERT(thd->lex->sql_command == SQLCOM_REPLACE ||
              thd->lex->sql_command == SQLCOM_INSERT);

  bool res= false;
  LEX *const lex= thd->lex;
  SELECT_LEX *const select_lex= lex->select_lex;
  TABLE_LIST *const first_table= select_lex->get_table_list();
  TABLE_LIST *const all_tables= first_table;

  if (open_temporary_tables(thd, all_tables))
    return true;

  if (insert_precheck(thd, all_tables))
    return true;

  /* Push ignore / strict error handler */
  Ignore_error_handler ignore_handler;
  Strict_error_handler strict_handler;
  if (thd->lex->is_ignore())
    thd->push_internal_handler(&ignore_handler);
  else if (thd->is_strict_mode())
    thd->push_internal_handler(&strict_handler);

  MYSQL_INSERT_START(const_cast<char*>(thd->query().str));
  res= mysql_insert(thd, all_tables);
  MYSQL_INSERT_DONE(res, (ulong) thd->get_row_count_func());

  /* Pop ignore / strict error handler */
  if (thd->lex->is_ignore() || thd->is_strict_mode())
    thd->pop_internal_handler();

  /*
    If we have inserted into a VIEW, and the base table has
    AUTO_INCREMENT column, but this column is not accessible through
    a view, then we should restore LAST_INSERT_ID to the value it
    had before the statement.
  */
  if (first_table->is_view() && !first_table->contain_auto_increment)
    thd->first_successful_insert_id_in_cur_stmt=
      thd->first_successful_insert_id_in_prev_stmt;

  DBUG_EXECUTE_IF("after_mysql_insert",
                  {
                    const char act[]=
                      "now "
                      "wait_for signal.continue";
                    DBUG_ASSERT(opt_debug_sync_timeout > 0);
                    DBUG_ASSERT(!debug_sync_set_action(current_thd,
                                                       STRING_WITH_LEN(act)));
                  };);

  thd->lex->clear_values_map();
  return res;
}
```
