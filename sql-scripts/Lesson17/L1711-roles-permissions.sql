USE [sql-music];
GO

--Programatically determine if a user is a mamber of a role
EXECUTE AS USER = 'Peregrin'; 
--EXECUTE AS USER = 'Albus'; 

IF (SELECT IS_MEMBER('musicUsers')) = 1
       SELECT 'Member of the musicUsers';

--Show all roles and their members
SELECT DP1.name AS DatabaseRoleName,  ISNULL (DP2.name, 'No members') AS DatabaseUserName   
FROM sys.database_role_members AS DRM  
    RIGHT OUTER JOIN sys.database_principals AS DP1 ON DRM.role_principal_id = DP1.principal_id  
    LEFT OUTER JOIN sys.database_principals AS DP2 ON DRM.member_principal_id = DP2.principal_id  
WHERE DP1.type = 'R'
ORDER BY DP1.name;  

--note, this query only returns rows for tables where the user has SOME rights
SELECT  TABLE_SCHEMA + '.' + TABLE_NAME AS tableName,
        HAS_PERMS_BY_NAME(TABLE_SCHEMA + '.' + TABLE_NAME, 'OBJECT', 'SELECT') AS AllowSelect,
        HAS_PERMS_BY_NAME(TABLE_SCHEMA + '.' + TABLE_NAME, 'OBJECT', 'INSERT') AS AllowInsert,
        HAS_PERMS_BY_NAME(TABLE_SCHEMA + '.' + TABLE_NAME, 'OBJECT', 'DELETE') AS AllowDelete,
        HAS_PERMS_BY_NAME(TABLE_SCHEMA + '.' + TABLE_NAME, 'OBJECT', 'UPDATE') AS AllowUpdate
FROM    INFORMATION_SCHEMA.TABLES;

REVERT;



--Cleanup
/*
DROP USER FrodoUser;
DROP USER Hermione;
DROP USER Albus;
DROP USER Gandalf;
DROP USER Peregrin;
DROP ROLE musicUsers;
*/