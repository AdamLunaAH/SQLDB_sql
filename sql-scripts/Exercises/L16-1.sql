   USE goodfriendsefc;
   GO

   CREATE OR ALTER PROCEDURE dbo.usp_InsertAdress
      @Street  NVARCHAR(200),
      @Zip     INT,
      @City  NVARCHAR(200),
      @Country  NVARCHAR(200),
      @AdressId UNIQUEIDENTIFIER OUTPUT AS

      SET  @AdressId =  NEWID();

      INSERT INTO Adress (AdressId, StreetAdress, ZipCode, City, Country, Seeded)
      VALUES (@AdressId, @Street, @Zip, @City, @Country, 0);

      GO

      DECLARE @AdressId UNIQUEIDENTIFIER;
      EXEC dbo.usp_InsertAdress 'Backvagen 1', '11111', 'Gavle', 'Sweden', @AdressId OUTPUT;

      PRINT @AdressId;

         SELECT * FROM Adress WHERE AdressId = 'EEF521C1-E8E1-4C2C-8CAE-092735E813E5'