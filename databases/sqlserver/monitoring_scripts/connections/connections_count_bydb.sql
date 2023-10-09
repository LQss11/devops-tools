SELECT 
    DB_NAME(database_id) as DBName, 
    COUNT(*) as NumberOfConnections
FROM
    sys.dm_exec_sessions
WHERE 
    database_id > 0
GROUP BY 
    database_id, DB_NAME(database_id);
