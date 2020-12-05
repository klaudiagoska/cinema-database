CREATE FUNCTION Repertoire (@unit Integer)
RETURNS @Return_table TABLE
(
	Title VARCHAR(128),
	"Date" DATE,
	"Time" TIME,
	Room Integer		
)
AS
BEGIN
	INSERT INTO @Return_table
		SELECT M.Title, S.Date, S.Time, S.Room_id FROM Screenings S 
		JOIN Movies M ON S.Movie_id = M.ID 
		JOIN Units U ON U.ID = M.Unit_id
		WHERE U.ID = @unit
	RETURN
END
GO

CREATE FUNCTION Get_licences
RETURNS @Return_table TABLE
(
	ID Integer,
	Company VARCHAR(128)
)
AS
BEGIN
	INSERT INTO @Return_table
		SELECT ID, Company FROM Licences
		WHERE Purchase_date <= CAST(CURRENT_TIMESTAMP as DATE)
			AND CAST(CURRENT_TIMESTAMP as DATE) <= Expiration_date
		ORDER BY Expiration_date
	RETURN
END
GO

CREATE FUNCTION Movies_today
RETURNS @Return_table TABLE
(
	Title VARCHAR(128),
	"Length" INT,
	Description TEXT,
	"Time" TIME
)
AS
BEGIN
	INSERT INTO @Return_table
		SELECT M.Title, M.Length, M.Description, S.Time FROM Screenings S
		JOIN Movies M ON S.Movie_id = M.ID
		WHERE S.Date = CAST(CURRENT_TIMESTAMP as DATE)
	RETURN
END
GO

CREATE FUNCTION Movies_for_age (@age Integer)
RETURNS @Return_table TABLE
(
	Title VARCHAR(128),
	Age_limit INTEGER
)
AS
BEGIN
	INSERT INTO @Return_table
		SELECT Title, Age_limit FROM Movies
		WHERE Age_limit <= @age
	RETURN
END
GO

CREATE FUNCTION Movies_genre (@genre VARCHAR(128))
RETURNS @Return_table TABLE
(
	Title VARCHAR(128),
	Premiere_date DATE,
	Length INTEGER,
	Description TEXT
)
AS
BEGIN
	INSERT INTO @Return_table
		SELECT M.Title, M.Premiere_date, M.Length, M.Description FROM Movies M
		JOIN Genres G ON M.Genre_id = G.ID
		WHERE G.Name = @genre
	RETURN
END
GO

CREATE FUNCTION Movies_production_studios (@studio VARCHAR(128))
RETURNS @Return_table TABLE
(
	Title VARCHAR(128)
)
AS
BEGIN
	INSERT INTO @Return_table
		SELECT M.Title FROM Movies M
		JOIN Production_studios P ON M.Studio_id = P.ID
		WHERE P.Name = @studio
	RETURN
END
GO

CREATE FUNCTION Movies_length (@length integer)
RETURNS @Return_table TABLE
(
	Title VARCHAR(128),
	Length INTEGER
)
AS
BEGIN
	INSERT INTO @Return_table
		SELECT Title, Length FROM Movies
		WHERE Length <= @length
	RETURN
END
GO

CREATE FUNCTION Movies_less_length (@movie VARCHAR(128), @length INTEGER)
RETURNS BIT
AS
BEGIN
	DECLARE @len INTEGER
	SET @len = (SELECT Length FROM Movies WHERE Title = @movie)
	IF @len <= @length
		RETURN 1
	ELSE
		RETURN 0
END
GO






