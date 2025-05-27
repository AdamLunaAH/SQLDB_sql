USE [sql-music];
GO

SELECT 
    (SELECT COUNT(*) FROM dbo.MusicGroups WHERE Seeded = 1) as nrSeededMusicGroups, 
    (SELECT COUNT(*) FROM dbo.MusicGroups WHERE Seeded = 0) as nrUnseededMusicGroups,
    (SELECT COUNT(*) FROM dbo.Albums WHERE Seeded = 1) as nrSeededAlbums, 
    (SELECT COUNT(*) FROM dbo.Albums WHERE Seeded = 0) as nrUnseededAlbums,
    (SELECT COUNT(*) FROM dbo.Artists WHERE Seeded = 1) as nrSeededArtists, 
    (SELECT COUNT(*) FROM dbo.Artists WHERE Seeded = 0) as nrUnseededArtists;


/* Exercises
1. Create above Select as a View in a schema called gst
2. Create a Role gstRole that GRANTS SELECT permissions in schema gst
3. Create a gstUser without Login
4. Add gstUser to Role gstRole
5. Impersonate and verify that gstUser can only Select the View created. No tables should have access


6. Create a LOGIN gstLogin
7. Assign the gstUser to the gstLogin using below
   ALTER USER [gstUser] WITH LOGIN = [gstLogin];

8 login to the database as a gstLogin and verify that you can only Select the View created. No tables should have access
