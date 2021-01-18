static MYSQL_METHODS client_methods = {
    cli_read_query_result,      /* read_query_result */
    cli_advanced_command,       /* advanced_command */
    cli_read_rows,              /* read_rows */
    cli_use_result,             /* use_result */
    cli_fetch_lengths,          /* fetch_lengths */
    cli_flush_use_result,       /* flush_use_result */
    cli_read_change_user_result /* read_change_user_result */
#ifndef MYSQL_SERVER
    ,
    cli_list_fields,         /* list_fields */
    cli_read_prepare_result, /* read_prepare_result */
    cli_stmt_execute,        /* stmt_execute */
    cli_read_binary_rows,    /* read_binary_rows */
    cli_unbuffered_fetch,    /* unbuffered_fetch */
    NULL,                    /* free_embedded_thd */
    cli_read_statistics,     /* read_statistics */
    cli_read_query_result,   /* next_result */
    cli_read_binary_rows,    /* read_rows_from_cursor */
    free_rows
#endif
};
