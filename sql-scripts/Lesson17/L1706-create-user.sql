USE master;
GO

--House cleaning
--DROP USER SamUser;
--DROP LOGIN Sam;


CREATE LOGIN Sam WITH PASSWORD=N'pa$$Word1', 
    DEFAULT_DATABASE=tempdb, DEFAULT_LANGUAGE=us_english, 
    CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;


USE [sql-music];
GO

CREATE USER SamUser FROM LOGIN Sam;
GRANT CONNECT to SamUser;
--GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE to SamUser;

--Now, log in as Sam in a separate Azure Data Studio Window
--Run below script in Sam Window
--See that you cannot connect to any other database than musicefc
--And even there you cannot not see any schema objects
USE [sql-music];
GO

--database scoped principals
SELECT SUSER_SNAME() AS server_principal_name,
       USER_NAME() AS database_principal_name;

--Database based users
SELECT * FROM sys.database_principals
WHERE type_desc = 'SQL_USER'


/* Excerise
1. create a login with your name (e.g. martin)
2. in database sql-goodfriends create a user with your name (e.g. martinUser)
3. grant full right to yourself to database sql-goodfriends