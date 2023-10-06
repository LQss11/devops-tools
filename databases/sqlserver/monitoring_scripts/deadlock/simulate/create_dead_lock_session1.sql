-- Use the 'TEST' Database
USE TEST;
GO

BEGIN TRANSACTION;
UPDATE Users SET Username = 'NewUsername' WHERE UserID = 1;

-- To release the deadlock, you can issue a ROLLBACK in one of the sessions
-- Example, in one of the sessions:
-- ROLLBACK;
GO