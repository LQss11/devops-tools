SELECT 
    s.session_id AS SessionID,
    DB_NAME(s.database_id) AS DBName,
    s.login_name AS LoginName,
    s.program_name AS ProgramName,
    c.client_net_address AS ClientIPAddress,
    c.local_net_address AS LocalIPAddress,
    c.local_tcp_port AS LocalTCPPort,
    c.protocol_type AS ProtocolType,
    s.host_name AS HostName,
    t.text AS SQLStatement
FROM
    sys.dm_exec_sessions s
INNER JOIN
    sys.dm_exec_requests r ON s.session_id = r.session_id
CROSS APPLY
    sys.dm_exec_sql_text(r.sql_handle) t
INNER JOIN
    sys.dm_exec_connections c ON s.session_id = c.session_id
WHERE 
    s.database_id > 0
ORDER BY 
    DBName, LoginName;
