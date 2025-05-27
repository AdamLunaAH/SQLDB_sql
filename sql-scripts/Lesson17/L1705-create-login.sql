USE master;
GO
--House cleaning
--DROP LOGIN Frodo;
--DROP SERVER ROLE ServerViewOnly;

--Create the login
/*
CREATE LOGIN Frodo WITH PASSWORD=N'pa$$Word1' MUST_CHANGE, 
    DEFAULT_DATABASE=tempdb, DEFAULT_LANGUAGE=us_english, 
    CHECK_EXPIRATION=ON, CHECK_POLICY=ON;
*/
CREATE LOGIN Frodo WITH PASSWORD=N'pa$$Word1', 
    DEFAULT_DATABASE=tempdb, DEFAULT_LANGUAGE=us_english, 
    CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;

--See all logins (need admin rights)
SELECT * FROM sys.sql_logins;

--Assign Server permissions
CREATE SERVER ROLE ServerViewOnly;

GRANT CONNECT ANY DATABASE to ServerViewOnly; -- connect to any database
GRANT VIEW ANY DATABASE to ServerViewOnly; --see any database
GRANT SELECT ALL USER SECURABLES to ServerViewOnly; -- only select

ALTER SERVER ROLE ServerViewOnly ADD MEMBER Frodo;

--Now, log in as Frodo in a separate Azure Data Studio Window
--Run below script in Frodo Window
/*
USE[sql-music]
GO

UPDATE dbo.Albums
SET Name = 'hello'
*/

--House keeping
-- ALTER ROLE ServerViewOnly DROP MEMBER Frodo;
-- DROP SERVER ROLE ServerViewOnly;
