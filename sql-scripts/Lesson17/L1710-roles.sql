USE [sql-music];
GO

--cleanup
--DROP USER Hermione;
--DROP USER Albus;
--DROP USER Gandalf;

--Create some users
CREATE USER Hermione WITHOUT LOGIN;
CREATE USER Albus WITHOUT LOGIN;
CREATE USER Gandalf WITHOUT LOGIN;

--Create a role for common users
CREATE ROLE musicUsers;

--SELECT only rights, nothing can be damaged
GRANT SELECT ON dbo.Albums to musicUsers;
GRANT SELECT ON dbo.Artists to musicUsers;
GRANT SELECT ON dbo.MusicGroups to musicUsers;

ALTER ROLE musicUsers ADD MEMBER Hermione;
ALTER ROLE musicUsers ADD MEMBER Albus;
--ALTER ROLE musicUsers DROP MEMBER Albus;
ALTER ROLE musicUsers ADD MEMBER Gandalf;

--Impersonate the users
EXECUTE AS USER = 'Albus';  -- try all different, Albus, Gandalf, Hermoine
--This works
SELECT * FROM dbo.Artists;

--But not this
INSERT INTO dbo.Artists VALUES
(NEWID(), 'Mary', 'Doe', NULL, 1);

UPDATE dbo.Artists
SET FirstName = 'Mary'
WHERE LastName = 'Doe';

REVERT;

