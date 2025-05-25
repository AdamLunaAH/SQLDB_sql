USE [sql-music]
GO

--Let's first create an application log table
DROP TABLE IF EXISTS dbo.ErrorLog; --Housecleaning for the example     
CREATE TABLE dbo.ErrorLog(
    err_nr INT,
    err_msg NVARCHAR(400),
    err_line INT,
    err_sev INT);
GO


CREATE OR ALTER PROC usp_InsertMusicGroup

@Name NVARCHAR(200),
@EstablishedYear INT,

@mgID uniqueidentifier OUTPUT AS

SET @mgID = NEWID();

INSERT INTO dbo.MusicGroups (MusicGroupId, Name, EstablishedYear, Seeded)
VALUES (@mgID, @Name, @EstablishedYear, 0)
GO

CREATE OR ALTER PROC usp_InsertArtist 
    @FirstName NVARCHAR(200),
    @LastName NVARCHAR(200),
    @ArtistId UNIQUEIDENTIFIER OUTPUT AS

    SET @ArtistId = NEWID();
    INSERT INTO dbo.Artists (ArtistId, FirstName, LastName, Seeded)
    VALUES (@ArtistId, @FirstName, @LastName, 0);

GO
CREATE OR ALTER PROC usp_CreateMusicGroupWithArtist
    @MGName NVARCHAR(200),
    @MGEstablishedYear INT,
    @ArtistFirstName NVARCHAR(200),
    @ArtistLastName NVARCHAR(200),
    @newMG UNIQUEIDENTIFIER OUTPUT,
    @ArtistId UNIQUEIDENTIFIER OUTPUT AS

    BEGIN TRANSACTION
    BEGIN TRY
        EXEC usp_InsertMusicGroup @MGName, @MGEstablishedYear, @newMG OUTPUT;
        EXEC usp_InsertArtist @ArtistFirstName, @ArtistLastName, @ArtistId OUTPUT

        --;THROW 999999, 'This is a test error.', 1;
        
        INSERT INTO dbo.ArtistMusicGroup (MembersArtistId, MusicGroupsMusicGroupId)
        VALUES (@ArtistId, @newMG)
        
        COMMIT
    END TRY

    BEGIN CATCH
        ROLLBACK

        --You can put some corrective in place, such as your application logging   
        INSERT INTO dbo.ErrorLog (err_nr, err_msg, err_line, err_sev)
        VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_SEVERITY())

        --And then THROW the same error again to a client
        ;THROW
    END CATCH

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

--DELETE FROM dbo.Artists WHERE FirstName = 'Barry'
--DELETE FROM dbo.MusicGroups WHERE Name = 'LoveBirds'
