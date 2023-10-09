SELECT
    TL.request_session_id AS SessionID,
    TL.resource_type AS ResourceType,
    DB_NAME(TL.resource_database_id) AS DatabaseName,
    TL.request_mode AS LockMode,
    TL.request_status AS LockStatus,
    -- Enable this if you want more extended and detailed information about the query causing deadlocks (XML)
    -- EQP.query_plan AS QueryPlan,
    ER.command AS Command,
    ES.host_name AS HostName,
    ES.program_name AS ProgramName,
    EQT.text AS QueryText
FROM
    sys.dm_tran_locks TL
    INNER JOIN sys.dm_exec_requests ER ON TL.request_session_id = ER.session_id
    INNER JOIN sys.dm_exec_sessions ES ON TL.request_session_id = ES.session_id
    CROSS APPLY sys.dm_exec_query_plan(ER.plan_handle) AS EQP
    CROSS APPLY sys.dm_exec_sql_text(ER.sql_handle) AS EQT
WHERE
    TL.request_status = 'WAIT';