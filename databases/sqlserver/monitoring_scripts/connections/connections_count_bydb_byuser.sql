SELECT a.*
FROM
(SELECT
DB_NAME(dbid) as DBName,
COUNT(dbid) as NumberOfConnections,
loginame as LoginName
FROM
sys.sysprocesses
WHERE
dbid > 0
GROUP BY
dbid, loginame) a
ORDER BY a.DBName, a.LoginName
