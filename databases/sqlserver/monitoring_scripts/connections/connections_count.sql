SELECT 
    COUNT(dbid) as TotalConnections
FROM
    sys.sysprocesses
WHERE 
    dbid > 0