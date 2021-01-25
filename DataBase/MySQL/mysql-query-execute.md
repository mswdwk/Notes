case SQLCOM_SELECT:
mysql_execute_command -> { 
 case SQLCOM_SELECT: res= select_precheck(thd, lex, all_tables, first_table); execute_sqlcom_select -> { 
		open_tables_for_query(thd, all_tables, 0)
		MYSQL_SELECT_START(const_cast<char*>(thd->query().str));
		if (lex->is_explain()){
			Query_result *const result= new Query_result_send;
			handle_query(thd, lex, result, 0, 0);
		} else {
		  Query_result *result= lex->result;
		  if (!result && !(result= new Query_result_send()))
			return true;                            /* purecov: inspected */
		  Query_result *save_result= result;
		  Query_result *analyse_result= NULL;
		  if (lex->proc_analyse)
		  {
			if ((result= analyse_result=
				   new Query_result_analyse(result, lex->proc_analyse)) == NULL)
			  return true;
		  }
		  res= handle_query(thd, lex, result, 0, 0);
		  delete analyse_result;
		  if (save_result != lex->result)
			delete save_result;
		}
		MYSQL_SELECT_DONE((int) res, (ulong) thd->current_found_rows);	
	} 
}

bool handle_query(THD *thd, LEX *lex, Query_result *result,ulonglong added_options, ulonglong removed_options){
	select->prepare(thd);
	lock_tables(thd, lex->query_tables, lex->table_count, 0);
	query_cache.store_query(thd, lex->query_tables);

	 if (single_query)
	  {
		if (select->optimize(thd))
		  goto err;

		unit->set_optimized();
	  }
	  else
	  {
		if (unit->optimize(thd))
		  goto err;
	  }

	  if (lex->is_explain())
	  {
		if (explain_query(thd, unit))
		  goto err;     /* purecov: inspected */
	  }
	  else
	  {
		if (single_query)
		{
		  select->join->exec();
		  unit->set_executed();
		  if (thd->is_error())
			goto err;
		}
		else
		{
		  if (unit->execute(thd))
			goto err;
		}
	  }

	  	// Do partial cleanup (preserve plans for EXPLAIN).
		res= unit->cleanup(false);
		DBUG_RETURN(res);
}
