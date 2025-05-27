USE master;
GO

--House cleaning
--DROP USER FrodoUser;  - done from master

--Create a User with no rights, not bothering to create a login
CREATE USER FrodoUser WITHOUT LOGIN;

--Up to this point I am system Admin (logged in a sa)
SELECT USER AS UserName, SYSTEM_USER AS SystemUserName,
       ORIGINAL_LOGIN() AS OriginalLoginName;

--Now, impersonate FrodoUser, done in master
EXECUTE AS USER = 'FrodoUser';

--Here I am FrodoUser
SELECT USER AS UserName, SYSTEM_USER AS SystemUserName,
       ORIGINAL_LOGIN() AS OriginalLoginName;

--I cannot switch to any database
USE [sql-music];
GO

--Here I comeback to being a sa system user, done in master
USE master;
REVERT;

SELECT USER AS UserName, SYSTEM_USER AS SystemUserName,
       ORIGINAL_LOGIN() AS OriginalLoginName;
