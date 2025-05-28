USE [sql-music];
GO

--Q4.2
SELECT 'Antal grupper' as [Rubrik], COUNT(*) as [Antal] FROM dbo.MusicGroups
UNION
SELECT 'Antal album', COUNT(*) FROM dbo.Albums
UNION
SELECT 'Antal artister', COUNT(*) FROM dbo.Artists

--Q4.3a
GO
CREATE OR ALTER VIEW vwDbContent AS
    SELECT 'Antal grupper' as [Rubrik], COUNT(*) as [Antal] FROM dbo.MusicGroups
    UNION
    SELECT 'Antal album', COUNT(*) FROM dbo.Albums
    UNION
    SELECT 'Antal artister', COUNT(*) FROM dbo.Artists
GO

--Q4.3b
SELECT * FROM vwDbContent FOR JSON AUTO
SELECT * FROM vwDbContent FOR JSON PATH