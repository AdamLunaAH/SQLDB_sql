USE [sql-music];
GO

--Impersonate the users
EXECUTE AS USER = 'Albus';  -- try all different, Albus, Gandalf, Hermoine

--This works
SELECT * FROM usr.vwMusicGroups;

--But not this
INSERT INTO dbo.MusicGroups 
VALUES (NEWID(), 'Blue man group', 1995);

--But this will work at the stored procedure is within usr SCHEMA 
--Permissons include EXECUTE
EXEC usr.usp_InsertMusicGroup NULL, 'Blue man group', 1995

SELECT * FROM usr.vwMusicGroups WHERE [Name] Like 'Blue%'

--Go back to being myslef
REVERT;
