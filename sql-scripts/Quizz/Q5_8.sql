USE [sql-music];
GO

--Q4.8
--Find the music group with most albums sold
SELECT TOP 1 g.MusicGroupId, g.Name, SUM (a.CopiesSold) [copies sold] FROM dbo.MusicGroups g 
INNER JOIN dbo.Albums a ON a.MusicGroupsMusicGroupId = g.MusicGroupId
GROUP BY g.MusicGroupId, g.Name
ORDER BY 3 DESC 

--Isolate the MusicGroupId as scalar
SELECT s.MusicGroupId FROM (
    SELECT TOP 1 g.MusicGroupId, g.Name, SUM (a.CopiesSold) [copies sold] FROM dbo.MusicGroups g 
    INNER JOIN dbo.Albums a ON a.MusicGroupsMusicGroupId = g.MusicGroupId
    GROUP BY g.MusicGroupId, g.Name
    ORDER BY 3 DESC 
    ) s

--use the scalar as a sub query to list all artists in the music group with most
--albums sold
SELECT * FROM dbo.Artists a 
INNER JOIN dbo.ArtistMusicGroup amg ON amg.MembersArtistId = a.ArtistId
WHERE amg.MusicGroupsMusicGroupId IN (
    SELECT s.MusicGroupId FROM (
        SELECT TOP 5 g.MusicGroupId, g.Name, SUM (a.CopiesSold) [copies sold] FROM dbo.MusicGroups g 
        INNER JOIN dbo.Albums a ON a.MusicGroupsMusicGroupId = g.MusicGroupId
        GROUP BY g.MusicGroupId, g.Name
        ORDER BY 3 DESC 
    ) s
)
