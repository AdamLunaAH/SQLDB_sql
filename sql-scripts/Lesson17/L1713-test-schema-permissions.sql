USE [sql-music];
GO

--Create some users
CREATE USER Hermione WITHOUT LOGIN;
CREATE USER Albus WITHOUT LOGIN;
CREATE USER Gandalf WITHOUT LOGIN;

ALTER ROLE musicUsers ADD MEMBER Hermione;
ALTER ROLE musicUsers ADD MEMBER Albus;
ALTER ROLE musicUsers ADD MEMBER Gandalf;

--Impersonate the users
EXECUTE AS USER = 'Hermione';  -- try all different, Albus, Gandalf, Hermoine

--This works
SELECT * FROM usr.vwArtists;

--But not this
SELECT * FROM dbo.Artists;

--Go back to being myslef
REVERT;

--Cleanup
REVERT;
ALTER ROLE musicUsers DROP MEMBER Hermione;
ALTER ROLE musicUsers DROP MEMBER Albus;
ALTER ROLE musicUsers DROP MEMBER Gandalf;
ALTER ROLE musicUsers DROP MEMBER HarryUser;
ALTER ROLE musicUsers DROP MEMBER Peregrin;
DROP ROLE musicUsers;

DROP USER Hermione;
DROP USER Albus;
DROP USER Gandalf;
DROP USER HarryUser;
DROP USER Peregrin;
DROP VIEW usr.vwAlbums;
DROP VIEW usr.vwArtists;
DROP VIEW usr.vwMusicGroups;
DROP SCHEMA usr;



SELECT DP1.name AS DatabaseRoleName,  ISNULL (DP2.name, 'No members') AS DatabaseUserName   
FROM sys.database_role_members AS DRM  
    RIGHT OUTER JOIN sys.database_principals AS DP1 ON DRM.role_principal_id = DP1.principal_id  
    LEFT OUTER JOIN sys.database_principals AS DP2 ON DRM.member_principal_id = DP2.principal_id  
WHERE DP1.type = 'R'
ORDER BY DP1.name; 