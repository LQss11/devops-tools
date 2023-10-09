SELECT
    resource_type,
    DB_NAME(resource_database_id) AS database_name,
    request_owner_type,
    request_status,
    command,
    wait_time AS start_time_ms,
    wait_type,
    s.host_name
FROM
    sys.dm_tran_locks TL
    INNER JOIN sys.dm_exec_requests ER ON TL.request_session_id = ER.session_id
    INNER JOIN sys.dm_exec_sessions s ON ER.session_id = s.session_id
WHERE
    TL.request_status = 'WAIT';