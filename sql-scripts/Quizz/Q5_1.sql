USE [sql-music];
GO

--Q4.1
--Find all Albums released aftar 1980 that contains word Purple
SELECT * FROM dbo.Albums WHERE ReleaseYear > 1980 AND Name LIKE '%Purple%'

--Exchange Purple to Amber - verification
SELECT *, REPLACE (Name, 'Purple', 'Amber') FROM dbo.Albums WHERE ReleaseYear > 1980 AND Name LIKE '%Purple%'

--And make the update
UPDATE dbo.Albums
SET Name = REPLACE (Name, 'Purple', 'Amber')
WHERE ReleaseYear > 1980 AND Name LIKE '%Purple%'

--Verify
SELECT * FROM dbo.Albums WHERE ReleaseYear > 1980 AND Name LIKE '%Purple%'
SELECT * FROM dbo.Albums WHERE ReleaseYear > 1980 AND Name LIKE '%Amber%'