/*file: sql_select.cc*/
bool SELECT_LEX::optimize(THD *thd){
  DBUG_ENTER("SELECT_LEX::optimize");

  DBUG_ASSERT(join == NULL);
  JOIN *const join_local= new JOIN(thd, this);
  if (!join_local)
    DBUG_RETURN(true);  /* purecov: inspected */

  set_join(join_local);

  if (join->optimize())
    DBUG_RETURN(true);

  for (SELECT_LEX_UNIT *unit= first_inner_unit(); unit; unit= unit->next_unit())
  {
    // Derived tables and const subqueries are already optimized
    if (!unit->is_optimized() && unit->optimize(thd))
      DBUG_RETURN(true);
  }

  DBUG_RETURN(false);
}

bool st_select_lex_unit::optimize(THD *thd){
DBUG_ENTER("st_select_lex_unit::optimize");

  DBUG_ASSERT(is_prepared() && !is_optimized());

  SELECT_LEX *save_select= thd->lex->current_select();

  for (SELECT_LEX *sl= first_select(); sl; sl= sl->next_select())
  {
    thd->lex->set_current_select(sl);

    // LIMIT is required for optimization
    set_limit(sl);

    if (sl->optimize(thd))
      DBUG_RETURN(true);

    /*
      Accumulate estimated number of rows.
      1. Implicitly grouped query has one row (with HAVING it has zero or one
         rows).
      2. If GROUP BY clause is optimized away because it was a constant then
         query produces at most one row.
    */
    if (query_result())
      query_result()->estimated_rowcount+=
        sl->is_implicitly_grouped() || sl->join->group_optimized_away ?
          1 :  sl->join->best_rowcount;

  }
  if (fake_select_lex)
  {
    thd->lex->set_current_select(fake_select_lex);

    set_limit(fake_select_lex);

    /*
      In EXPLAIN command, constant subqueries that do not use any
      tables are executed two times:
       - 1st time is a real evaluation to get the subquery value
       - 2nd time is to produce EXPLAIN output rows.
      1st execution sets certain members (e.g. Query_result) to perform
      subquery execution rather than EXPLAIN line production. In order 
      to reset them back, we re-do all of the actions (yes it is ugly).
    */
    DBUG_ASSERT(fake_select_lex->with_wild == 0 &&
                fake_select_lex->master_unit() == this &&
                !fake_select_lex->group_list.elements &&
                fake_select_lex->get_table_list() == &result_table_list &&
                fake_select_lex->where_cond() == NULL &&
                fake_select_lex->having_cond() == NULL);

    if (fake_select_lex->optimize(thd))
      DBUG_RETURN(true);
  }
  set_optimized();    // All query blocks optimized, update the state
  thd->lex->set_current_select(save_select);

  DBUG_RETURN(false);

}


JOIN::optimize{
	select_lex->apply_local_transforms(thd, false)
	select_lex->get_optimizable_conditions(thd, &where_cond, &having_cond)
	set_optimized();
	optimize_cond(thd, &where_cond, &cond_equal,&select_lex->top_join_list, &select_lex->cond_value)
	select_lex->partitioned_table_count && prune_table_partitions()
	make_join_plan()
	optimize_distinct_group_order())
}
