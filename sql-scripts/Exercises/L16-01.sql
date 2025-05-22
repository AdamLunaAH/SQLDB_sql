USE [sql-goodfriends]
GO

/*
In sql-goodfriends, write a stored procedure that returns a list of Pets.
Use a parameter @AnimalKindString with default value NULL

If @AnimalKindString is null all animal kinds shall be returned
if not null all Pets of the specific animal kind shall be returned
*/

CREATE OR ALTER PROCEDURE usp_GetPets
    @AnimalKindString NVARCHAR(20) = NULL AS

SELECT * FROM dbo.Pets 
WHERE (@AnimalKindString IS NULL OR AnimalKindString = @AnimalKindString)

GO

EXEC usp_GetPets
EXEC usp_GetPets 'Rabbit'

/*
Add another paramater @Country  with default value NULL
@City should filter Pets based on City
*/
GO
CREATE OR ALTER PROCEDURE usp_GetPets
    @AnimalKindString NVARCHAR(200) = NULL,
    @City NVARCHAR(200) = NULL AS

SELECT * FROM dbo.Pets p
INNER JOIN dbo.Friends f ON p.OwnerFriendId = f.FriendId
INNER JOIN dbo.Addresses a ON f.AddressId = a.AddressId
WHERE (@AnimalKindString IS NULL OR p.AnimalKindString = @AnimalKindString) AND
      (@City IS NULL OR City = @City)


GO

EXEC usp_GetPets
EXEC usp_GetPets 'Rabbit'
EXEC usp_GetPets 'Rabbit', 'Espoo'


/*
Add return code 0 to the stored procedure. Catch the return code when executing the stored procedure
*/
GO
CREATE OR ALTER PROCEDURE usp_GetPets
    @AnimalKindString NVARCHAR(200) = NULL,
    @City NVARCHAR(200) = NULL AS

SELECT * FROM dbo.Pets p
INNER JOIN dbo.Friends f ON p.OwnerFriendId = f.FriendId
INNER JOIN dbo.Addresses a ON f.AddressId = a.AddressId
WHERE (@AnimalKindString IS NULL OR p.AnimalKindString = @AnimalKindString) AND
      (@City IS NULL OR City = @City)

IF @@ROWCOUNT > 0
    RETURN 0
ELSE
    RETURN 1
GO

DECLARE @retCode INT;

-- EXEC @retCode = usp_GetPets
-- PRINT @retCode

EXEC @retCode = usp_GetPets 'Rabbit'
PRINT @retCode

EXEC @retCode = usp_GetPets 'Rabbit', 'Espoo'
PRINT @retCode

/*
Use NEWID(), which returns a GUID (of type uniqueidentifier)
Write a stored procedure that inserts a Friend into the dbo.Friends
FirstName, LastName should be mandatory parameters
The created FriendId should be an OUTPUT parameter
*/

CREATE OR ALTER PROC usp_InsertFriend

@FirstName NVARCHAR(200),
@LastName NVARCHAR(200),

@FriendId uniqueidentifier OUTPUT AS

SET @FriendId = NEWID();

INSERT INTO dbo.Friends (FriendId, FirstName, LastName, Seeded)
VALUES (@FriendId, @FirstName, @LastName, 0)
GO

DECLARE @FriendId UNIQUEIDENTIFIER;
EXEC usp_InsertFriend 'Hola', 'Bandola', @FriendId OUTPUT;

--DELETE FROM dbo.Friends WHERE FirstName = 'Hola'
SELECT * FROM dbo.Friends WHERE FirstName = 'Hola'

/* 
Modify the stored procedure so also an Address can be added when creating a Friend
(Street, ZipCode, Country)
*/
