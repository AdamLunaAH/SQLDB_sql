USE [sql-music];
GO

--cleanup
DROP USER Hermione;
DROP USER Albus;
DROP USER Gandalf;
DROP ROLE musicUsers;

--Let's create a musicefc database user and login from the C# entity framework core program
--Create a role for common users
DROP ROLE IF EXISTS musicUsers;
CREATE ROLE musicUsers;

--SELECT only rights to Role musicUsers to everything in SCHEMA usr
GRANT SELECT, EXECUTE ON SCHEMA::usr to musicUsers;

--Create a Login
CREATE LOGIN Frodo WITH PASSWORD=N'pa$$Word1', 
    DEFAULT_DATABASE=tempdb, DEFAULT_LANGUAGE=us_english, 
    CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;

--And a user
CREATE USER FrodoUser FROM LOGIN Frodo;
ALTER ROLE musicUsers ADD MEMBER FrodoUser;