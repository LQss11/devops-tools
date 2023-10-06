SELECT
    COUNT(*) AS NumberOfDeadlocks
FROM
    sys.dm_tran_locks
WHERE
    request_status = 'WAIT'