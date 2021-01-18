case SQLCOM_SELECT:
mysql_execute_command -> { 
 case SQLCOM_SELECT: res= select_precheck(thd, lex, all_tables, first_table); execute_sqlcom_select -> { handle_query} 

}


