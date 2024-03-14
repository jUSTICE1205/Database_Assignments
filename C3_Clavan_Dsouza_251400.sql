/*
 * Name : Clavan Dsouza
 * Date : 07-02-2024
 * Course : DataBase Management 2
 */

USE JRMOVIE;
GO

-- Exercise 1 --

-- Stored Procedure
CREATE OR ALTER PROCEDURE usp_AddOne (
    @InputParameter INT,
    @OutputParameter INT OUTPUT
)
AS
BEGIN
    SET @OutputParameter = @InputParameter + 1;
END;
GO

-- Anonymous block calls procedure
DECLARE @Result INT, @TestInput INT = 9;
BEGIN
	EXEC usp_AddOne @TestInput, @Result OUTPUT;
	PRINT @Result; -- It is display 10 (9 + 1)
END 
GO

-- Exercise 2 --
CREATE OR ALTER FUNCTION ufn_ConcatenateTwoString(
	@FirstString NCHAR(25), 
	@SecondString NCHAR(25)
)
RETURNS NVARCHAR(50)
AS
BEGIN
    RETURN RTRIM(@FirstString) + ' ' + RTRIM(@SecondString);
END;
GO

-- Anonymous block calls procedure
DECLARE @FirstName NCHAR(25) = 'Clavan'
      , @LastName NCHAR(25) = 'Dsouza'
	  , @Result NVARCHAR(51);
BEGIN
	SET @Result = dbo.ufn_ConcatenateTwoString(@FirstName, @LastName);
	PRINT @Result; -- It is displays "Clavan Dsouza"
END
GO


-- Exercise 3 --
CREATE OR ALTER FUNCTION ufn_GetMovieRating_Clavan_Dsouza(
	@MovieName NCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT Name, r.RatingId, Description
    FROM Movie m
	     JOIN Rating r ON m.RatingId = r.RatingId
    WHERE LOWER(Name) = LOWER(@MovieName)
);
GO

SELECT * FROM ufn_GetMovieRating_Clavan_Dsouza('hOME');
