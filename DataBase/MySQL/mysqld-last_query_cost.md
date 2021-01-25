# show status like 'last_query_cost';

 void save_current_query_costs()
  {
    DBUG_ASSERT(!status_var_aggregated);
    status_var.last_query_cost= m_current_query_cost;
    status_var.last_query_partial_plans= m_current_query_partial_plans;
  }

void Optimize_table_order::consider_plan(uint idx,Opt_trace_object *trace_obj){
double sort_cost= join->sort_cost;
sort_cost= join->positions[idx].prefix_rowcount;
}
