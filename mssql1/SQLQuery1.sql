SELECT TOP 10 
    total_worker_time / execution_count AS AvgCPU,
    execution_count,
    total_elapsed_time / execution_count AS AvgTime,
    (SELECT SUBSTRING(text, statement_start_offset/2 + 1,
                      (CASE WHEN statement_end_offset = -1 THEN LEN(CONVERT(NVARCHAR(MAX), text)) * 2 
                            ELSE statement_end_offset END - statement_start_offset)/2)
     FROM sys.dm_exec_sql_text(sql_handle)) AS Query_Text
FROM sys.dm_exec_query_stats
ORDER BY AvgCPU DESC;