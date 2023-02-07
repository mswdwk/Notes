SELECT sql_text, timer_wait/1000000000.0 "Time (ms)" FROM performance_schema.events_statements_history order by timer_start;    
