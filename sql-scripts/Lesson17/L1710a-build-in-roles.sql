USE [sql-music];
GO

--Create a login
CREATE LOGIN Harry WITH PASSWORD=N'pa$$Word1', 
    DEFAULT_DATABASE=tempdb, DEFAULT_LANGUAGE=us_english, 
    CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;

--Create a user for the login
CREATE USER harryUser FROM LOGIN Harry;

--Add harryUser to an existing role
ALTER ROLE db_datareader ADD MEMBER harryUser;

--Now, log in as Harry in a separate Azure Data Studio Window
--You will have only read access, and cannot do below
/*
UPDATE dbo.Albums
SET Name = 'hello'
WHERE AlbumId = '5e0c0773-4e77-47ca-6573-08db56e0cbf7'
*/


--current database scoped principals
SELECT SUSER_SNAME() AS server_principal_name,
       USER_NAME() AS database_principal_name;

--all users
SELECT * FROM sys.database_principals 
WHERE type_desc = 'SQL_USER'


--Cleanup
DROP USER harryUser;
DROP LOGIN Harry;
