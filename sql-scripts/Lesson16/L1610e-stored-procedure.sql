CREATE OR ALTER PROC usp_InsertMusicGroup

@Name NVARCHAR(200),
@EstablishedYear INT,

@mgID uniqueidentifier OUTPUT AS

SET @mgID = NEWID();

INSERT INTO dbo.MusicGroups (MusicGroupId, Name, EstablishedYear, Seeded)
VALUES (@mgID, @Name, @EstablishedYear, 0)


GO


DECLARE @newMG UNIQUEIDENTIFIER;
EXEC usp_InsertMusicGroup 'Martin rocks along', 2025, @newMG OUTPUT;


--DELETE FROM dbo.MusicGroups WHERE MusicGroupId = @newMG
SELECT * FROM dbo.MusicGroups WHERE Name = 'Martin rocks along'

GO

CREATE OR ALTER PROC usp_InsertArtist 
    @FirstName NVARCHAR(200),
    @LastName NVARCHAR(200),
    @ArtistId UNIQUEIDENTIFIER OUTPUT AS

    SET @ArtistId = NEWID();
    INSERT INTO dbo.Artists (ArtistId, FirstName, LastName, Seeded)
    VALUES (@ArtistId, @FirstName, @LastName, 0);

GO

DECLARE @ArtistId UNIQUEIDENTIFIER;
EXEC usp_InsertArtist 'Santa', 'Claus', @ArtistId OUTPUT

--DELETE FROM dbo.Artists WHERE FirstName = 'Santa';
SELECT * FROM dbo.Artists WHERE FirstName = 'Santa';



GO
CREATE OR ALTER PROC usp_CreateMusicGroupWithArtist
    @MGName NVARCHAR(200),
    @MGEstablishedYear INT,
    @ArtistFirstName NVARCHAR(200),
    @ArtistLastName NVARCHAR(200),
    @newMG UNIQUEIDENTIFIER OUTPUT,
    @ArtistId UNIQUEIDENTIFIER OUTPUT AS

    EXEC usp_InsertMusicGroup @MGName, @MGEstablishedYear, @newMG OUTPUT;
    EXEC usp_InsertArtist @ArtistFirstName, @ArtistLastName, @ArtistId OUTPUT

    INSERT INTO dbo.ArtistMusicGroup (MembersArtistId, MusicGroupsMusicGroupId)
    VALUES (@ArtistId, @newMG)

GO

DECLARE @newMG UNIQUEIDENTIFIER;
DECLARE @ArtistId UNIQUEIDENTIFIER;
EXEC usp_CreateMusicGroupWithArtist 'LoveBirds', '2020', 'Barry', 'White', @newMG OUTPUT, @ArtistId


SELECT * FROM dbo.MusicGroups WHERE Name = 'LoveBirds'
SELECT * FROM dbo.Artists WHERE FirstName = 'Barry'

SELECT * FROM dbo.MusicGroups mg
INNER JOIN dbo.ArtistMusicGroup artmg ON mg.MusicGroupId = artmg.MusicGroupsMusicGroupId
INNER JOIN dbo.Artists art ON artmg.MembersArtistId = art.ArtistId
WHERE Name = 'LoveBirds'