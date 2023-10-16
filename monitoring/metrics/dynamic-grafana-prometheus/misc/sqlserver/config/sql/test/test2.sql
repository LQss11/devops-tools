-- Create the 'TEST' Database
CREATE DATABASE TEST;
GO

-- Use the 'TEST' Database
USE TEST;
GO

-- Create the User Table
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50),
    Email VARCHAR(100)
);

-- Insert 5 Records into the User Table
INSERT INTO Users (UserID, Username, Email)
VALUES
    (1, 'user1', 'user1@example.com'),
    (2, 'user2', 'user2@example.com'),
    (3, 'user3', 'user3@example.com'),
    (4, 'user4', 'user4@example.com'),
    (5, 'user5', 'user5@example.com');
GO