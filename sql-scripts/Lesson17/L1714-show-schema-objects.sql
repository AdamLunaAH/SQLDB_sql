USE [sql-music];
GO

--Show existing schemas and number of objects
SELECT  SCHEMA_NAME(schema_id) AS schema_name, type_desc, COUNT(*)
FROM    sys.objects
WHERE   type_desc IN (
    'SQL_STORED_PROCEDURE','CLR_STORED_PROCEDURE',
    'SQL_SCALAR_FUNCTION','CLR_SCALAR_FUNCTION',
    'CLR_TABLE_VALUED_FUNCTION','SYNONYM',
    'SQL_INLINE_TABLE_VALUED_FUNCTION',
    'SQL_TABLE_VALUED_FUNCTION','USER_TABLE','VIEW')
GROUP BY  SCHEMA_NAME(schema_id), type_desc
ORDER BY schema_name;
