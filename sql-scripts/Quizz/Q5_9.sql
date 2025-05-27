USE [sql-music];
GO

--Q4.9


--Q4.8 as CTE example
--Find the music group with most albums sold
;WITH mg_mostalbums AS (
    SELECT TOP 1 g.MusicGroupId [MusicGroupId], g.Name, SUM (a.CopiesSold) [copies sold] FROM dbo.MusicGroups g 
    INNER JOIN dbo.Albums a ON a.MusicGroupsMusicGroupId = g.MusicGroupId
    GROUP BY g.MusicGroupId, g.Name
    ORDER BY 3 DESC )

--use mg_mostalbums with an INNER JOIN in CTE main query
SELECT * FROM dbo.Artists a 
INNER JOIN dbo.ArtistMusicGroup amg ON amg.MembersArtistId = a.ArtistId
INNER JOIN mg_mostalbums mgm ON mgm.MusicGroupId = amg.MusicGroupsMusicGroupId
