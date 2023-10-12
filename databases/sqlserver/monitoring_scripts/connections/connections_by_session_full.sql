SELECT 
    *
FROM
    sys.dm_exec_sessions s
INNER JOIN
    sys.dm_exec_requests r ON s.session_id = r.session_id
CROSS APPLY
    sys.dm_exec_sql_text(r.sql_handle) t
INNER JOIN
    sys.dm_exec_connections c ON s.session_id = c.session_id


