-- Use the 'TEST' Database
USE TEST;
GO

-- Session 2: Transaction 2
BEGIN TRANSACTION;
UPDATE Users SET Email = 'newemail@example.com' WHERE UserID = 2;
-- Now, don't commit the transaction yet

-- Back to Session 1: Attempt to access the record locked by Transaction 2
UPDATE Users SET Email = 'anotheremail@example.com' WHERE UserID = 2;
-- This will be blocked by Transaction 2

-- Back to Session 2: Attempt to access the record locked by Transaction 1
UPDATE Users SET Username = 'AnotherUsername' WHERE UserID = 1;
-- This will be blocked by Transaction 1

-- To release the deadlock, you can issue a ROLLBACK in one of the sessions
-- Example, in one of the sessions:
-- ROLLBACK;
GO