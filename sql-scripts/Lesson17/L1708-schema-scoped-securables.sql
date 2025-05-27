USE [sql-music];
GO

--house keeping
--DROP USER Peregrin

--I am in musicefc, but as sa - system administrator
CREATE USER Peregrin WITHOUT LOGIN;

--Impersonate Peregring
EXECUTE AS USER = 'Peregrin'; 

--Cannot change db or even select in musicefc
USE friends;
GO
USE [sql-music];
GO
SELECT * FROM dbo.Artists;

--Go back to being a system administrator
REVERT;

--Give Peregring som rigths
GRANT SELECT, INSERT ON dbo.Artists TO Peregrin;

--Impersonate Peregring
EXECUTE AS USER = 'Peregrin'; 

--This works
SELECT * FROM dbo.Artists;
INSERT INTO dbo.Artists VALUES
(NEWID(), 'Mary', 'Doe', NULL, 1);

SELECT * FROM dbo.Artists WHERE LastName IN ('Doe')

--But not this
UPDATE dbo.Artists
SET FirstName = 'Ann'
WHERE LastName IN ('Doe')

REVERT;

/* Excerise
1. in database sql-goodfriends create a user without login usrUser
2. grant guestUser only access to SELECT from dbo.Friends and dbo.Pets
3. impersonate usrUser and verify

4. Revert and create a view that shows NrofFriends, NrofPets, NrofAddresses, NrofQuotes
5. in database sql-goodfriends create a user without login gstUser
6. grant gstUser only access to SELECT from the view 
7. impersonate usrUser and verify
*/
