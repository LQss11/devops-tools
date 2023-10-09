SELECT 
    login_name as LoginName,
    COUNT(*) as NumberOfConnections
FROM
    sys.dm_exec_sessions
WHERE 
    database_id > 0
GROUP BY 
    login_name;
