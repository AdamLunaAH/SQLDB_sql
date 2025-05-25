USE [sql-goodfriends]
GO

CREATE OR ALTER PROC usp_InsertFriend

@FirstName NVARCHAR(200),
@LastName NVARCHAR(200),
@AddressId uniqueidentifier = NULL,

@FriendId uniqueidentifier OUTPUT AS

SET @FriendId = NEWID();

INSERT INTO dbo.Friends (FriendId, FirstName, LastName, AddressId, Seeded)
VALUES (@FriendId, @FirstName, @LastName, @AddressId, 0)
GO

CREATE OR ALTER PROC usp_InsertAddress

@Street NVARCHAR(200),
@ZipCode INT,
@City NVARCHAR(200),
@Country NVARCHAR(200),

@AddressId uniqueidentifier OUTPUT AS

SET @AddressId = NEWID();

INSERT INTO dbo.Addresses (AddressId, Street, ZipCode, City, Country, Seeded)
VALUES (@AddressId, @Street, @ZipCode, @City, @Country, 0)
GO


/* Test Code */
DECLARE @AddressId uniqueidentifier;
DECLARE @FriendId uniqueidentifier;

EXEC usp_InsertAddress 'Ringvagen', 12312, 'Gnarp', 'Sweden', @AddressId OUTPUT
EXEC usp_InsertFriend 'Hola', 'Bandola', @AddressId, @FriendId OUTPUT

SELECT * FROM dbo.Friends f
INNER JOIN dbo.Addresses a ON f.AddressId = a.AddressId
WHERE FirstName = 'Hola'

