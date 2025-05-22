USE [sql-goodfriends];
GO

--Create a stored procedure that gets all the friends in a specific city
--Using parameters with default vaues
CREATE OR ALTER PROCEDURE dbo.usp_GetFriends 
    @Country NVARCHAR(200) = NULL,
    @City NVARCHAR(200) = NULL AS

    SELECT f.*, a.City, a.Country FROM dbo.Friends f 
    INNER JOIN dbo.Addresses a ON f.AddressId = a.AddressId

    --Note I have to make special check on default value null
    WHERE (@Country IS NULL OR a.Country = @Country) AND (@City IS NULL OR a.City = @City)

GO

--Executing with various default parameters
EXEC dbo.usp_GetFriends;
EXEC dbo.usp_GetFriends 'Sweden';
EXEC dbo.usp_GetFriends NULL, 'Stockholm';
EXEC dbo.usp_GetFriends 'Sweden', 'Stockholm';

EXEC dbo.usp_GetFriends @City='Stockholm';

--House cleaning only for the example
DROP PROCEDURE IF EXISTS dbo.usp_GetFriends;