USE [sql-music];
GO

SELECT  class_desc AS PermissionType,
        OBJECT_SCHEMA_NAME(major_id) + '.' + OBJECT_NAME(major_id)
 AS ObjectName,
        permission_name, state_desc, USER_NAME(grantee_principal_id)
AS Grantee 
FROM   sys.database_permissions
WHERE USER_NAME(grantee_principal_id) NOT IN ('public')
