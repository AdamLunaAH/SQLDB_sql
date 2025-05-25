USE [sql-music];
GO

--Q4.6
--Test it
SELECT  DATEDIFF (YEAR, MAX(BirthDay), GETDATE()), MAX(BirthDay),
        DATEDIFF (YEAR, MIN(BirthDay), GETDATE()), MIN(BirthDay),
        YEAR(GETDATE())-AVG(YEAR(BirthDay)) FROM dbo.Artists

--Assign Variables
DECLARE @MaxAge INT
DECLARE @MinAge INT
DECLARE @AvgAge INT

SELECT  @MinAge = DATEDIFF (YEAR, MAX(BirthDay), GETDATE()),
        @MaxAge = DATEDIFF (YEAR, MIN(BirthDay), GETDATE()),
        @AvgAge = YEAR(GETDATE())-AVG(YEAR(BirthDay)) FROM dbo.Artists

SELECT @MaxAge as [Max age], @MinAge as [Min age], @AvgAge as [Avg age]