USE [sql-music];
GO

--Q4.10
--Find all the groups which has a member of the same age as the oldest_fart
;WITH oldest_fart AS (
    SELECT TOP 1 ArtistId, FirstName, LastName, 
           DATEDIFF (YEAR, BirthDay, GETDATE()) [age], DATEDIFF (DAY, BirthDay, GETDATE()) [agedays]
    FROM dbo.Artists WHERE BirthDay IS NOT NULL
    ORDER BY 5 DESC
)

SELECT * FROM dbo.MusicGroups g
INNER JOIN dbo.ArtistMusicGroup amg ON amg.MusicGroupsMusicGroupId = g.MusicGroupId
INNER JOIN dbo.Artists a ON a.ArtistId = amg.MembersArtistId
WHERE DATEDIFF (YEAR, a.BirthDay, GETDATE()) = (SELECT age FROM oldest_fart);