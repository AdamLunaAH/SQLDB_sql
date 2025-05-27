USE [sql-music];
GO

SELECT SCHEMA_NAME(schema_id) +'.' + name AS ProcedureName
FROM   sys.procedures;
