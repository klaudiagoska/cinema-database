--tables
CREATE TABLE Production_studios
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1) ,
     Name VARCHAR (128) NOT NULL ,
     Studio_address VARCHAR (128) NOT NULL
    )
GO

CREATE TABLE Sound_systems
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1) ,
     Name VARCHAR (128) NOT NULL
    )
GO

CREATE TABLE Visual_systems
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1) ,
     Name VARCHAR (128) NOT NULL
    )
GO

CREATE TABLE Sponsors
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1),
     Name VARCHAR (128) NOT NULL
    )
GO


CREATE TABLE Suppliers
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1),
     Name VARCHAR (128) NOT NULL ,
     Supplier_address VARCHAR (128) NOT NULL ,
     SSN VARCHAR (9) NOT NULL
    )
GO


CREATE TABLE Tickets
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1) ,
     Ticket_type VARCHAR (128) NOT NULL ,
     Price MONEY NOT NULL
    )
GO

CREATE TABLE Genres
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1) ,
     Name VARCHAR (128) NOT NULL
    )
GO

CREATE TABLE Membership
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1) ,
     Name VARCHAR (128) NOT NULL ,
     Membership_description TEXT NOT NULL ,
     Price MONEY NOT NULL
    )
GO

CREATE TABLE Clients
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1),
     Name VARCHAR (128) NOT NULL ,
     Surname VARCHAR (128) NOT NULL ,
     Sex VARCHAR (1) NOT NULL ,
     Email VARCHAR (128) NOT NULL ,
     Phone_number VARCHAR(9),
     Membership_id INTEGER,
     CONSTRAINT FK_Clients_Membership FOREIGN KEY(Membership_id) REFERENCES Membership(ID) ON DELETE CASCADE
    )
GO

CREATE TABLE Tickets_orders
(
	ID INTEGER PRIMARY KEY IDENTITY(1,1),
	Ticket_id INTEGER NOT NULL,
	Quantity INTEGER NOT NULL,
	Client_id INTEGER,
	CONSTRAINT FK_Tickets_orders_Tickets FOREIGN KEY(Ticket_id) REFERENCES Tickets(ID) ON DELETE CASCADE,
	CONSTRAINT FK_Tickets_orders_Clients FOREIGN KEY(Client_id) REFERENCES Clients(ID) ON DELETE CASCADE
)
GO

CREATE TABLE Events
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1) ,
     Name VARCHAR (128) NOT NULL ,
     Price VARCHAR (128) NOT NULL,
     Client_id INTEGER,
     CONSTRAINT FK_Events_Clients FOREIGN KEY (Client_id) REFERENCES Clients(ID) ON DELETE CASCADE
    )
GO

CREATE TABLE Food_categories
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1) ,
     Name VARCHAR (128) NOT NULL,
     Supplier_id INTEGER,
     CONSTRAINT FK_Food_categories_Suppliers FOREIGN KEY (Supplier_id) REFERENCES Suppliers(ID) ON DELETE CASCADE
    )
GO

CREATE TABLE Food
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1) ,
     Name VARCHAR (128) NOT NULL ,
     Price MONEY NOT NULL ,
     Category_id INTEGER,
     CONSTRAINT FK_Food_Food_categories FOREIGN KEY (Category_id) REFERENCES Food_categories(ID) ON DELETE CASCADE
    )
GO

CREATE TABLE Employees
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1) ,
     Hiring_date DATE NOT NULL ,
     Agreement VARCHAR (128) NOT NULL
    )
GO

CREATE TABLE External_employees
    (
     Employee_id INTEGER PRIMARY KEY ,
     Name VARCHAR (128) NOT NULL ,
     SSN VARCHAR (9) NOT NULL,
	 CONSTRAINT FK_External_employees_Employees FOREIGN KEY(Employee_id) REFERENCES Employees(ID) ON DELETE CASCADE
    )
GO

CREATE TABLE Internal_employees
    (
     Employee_id INTEGER PRIMARY KEY,
	 Name VARCHAR (128) NOT NULL ,
     Surname VARCHAR (128) NOT NULL ,
     Sex VARCHAR (1) NOT NULL ,
     Phone_number VARCHAR (9) NOT NULL,
	 CONSTRAINT FK_Internal_employees_Employees FOREIGN KEY(Employee_id) REFERENCES Employees(ID) ON DELETE CASCADE
    )
GO

CREATE TABLE Units
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1) ,
     Unit_address VARCHAR (128) NOT NULL ,
     Phone_number VARCHAR (9) NOT NULL,
     Manager_id INTEGER,
     CONSTRAINT FK_Units_Employees FOREIGN KEY (Manager_id) REFERENCES Employees(ID) ON DELETE CASCADE
    )
GO

CREATE TABLE Movies
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1) ,
     Title VARCHAR (128) NOT NULL ,
     Director VARCHAR (128) NOT NULL ,
     Premiere_date DATE NOT NULL ,
     Movie_length INTEGER NOT NULL ,
     Age_limit INTEGER ,
     Movie_description TEXT ,
     "3D" BIT NOT NULL,
     Studio_id INTEGER,
     Genre_id INTEGER NOT NULL,
     Unit_id INTEGER NOT NULL,
     CONSTRAINT FK_Movies_Production_studios FOREIGN KEY (Studio_id) REFERENCES Production_studios(ID) ON DELETE CASCADE,
     CONSTRAINT FK_Movies_Genres FOREIGN KEY (Genre_id) REFERENCES Genres(ID) ON DELETE CASCADE,
     CONSTRAINT FK_Movies_Units FOREIGN KEY (Unit_id) REFERENCES Units(ID) ON DELETE CASCADE
    )
GO


CREATE TABLE Licences
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1) ,
     Company VARCHAR(128) NOT NULL ,
     Purchase_date DATE NOT NULL ,
     Expiration_date DATE NOT NULL,
     Movie_id INTEGER,
     CONSTRAINT FK_Licences_Movies FOREIGN KEY (Movie_id) REFERENCES Movies(ID) ON DELETE CASCADE
    )
GO

CREATE TABLE Gadgets
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1) ,
     Category VARCHAR (128) NOT NULL ,
     Name VARCHAR (128) NOT NULL ,
     Price MONEY,
     Movie_id INTEGER,
     CONSTRAINT FK_Gadgets_Movies FOREIGN KEY (Movie_id) REFERENCES Movies(ID) ON DELETE CASCADE
    )
GO


CREATE TABLE Posters
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1) ,
     Quantity INTEGER ,
     Area INTEGER NOT NULL,
     Movie_id INTEGER,
     CONSTRAINT FK_Posters_Movies FOREIGN KEY (Movie_id) REFERENCES Movies(ID) ON DELETE CASCADE
    )
GO

CREATE TABLE Rooms
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1),
     Number_of_seats INTEGER NOT NULL ,
     Premium BIT NOT NULL ,
     Facilities_for_the_disabled BIT NOT NULL,
     Sound_system_id INTEGER,
     Visual_system_id INTEGER,
     Sponsor_id INTEGER,
     CONSTRAINT FK_Rooms_Sound_systems FOREIGN KEY (Sound_system_id) REFERENCES Sound_systems(ID) ON DELETE CASCADE,
     CONSTRAINT FK_Rooms_Visual_systems FOREIGN KEY (Visual_system_id) REFERENCES Visual_systems(ID) ON DELETE CASCADE,
     CONSTRAINT FK_Rooms_Sponsors FOREIGN KEY (Sponsor_id) REFERENCES Sponsors(ID) ON DELETE CASCADE
    )
GO


CREATE TABLE Screenings
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1),
     Movie_date DATE NOT NULL ,
     Movie_time TIME NOT NULL,
     Movie_id INTEGER,
     Room_id INTEGER,
     CONSTRAINT FK_Screenings_Movies FOREIGN KEY (Movie_id) REFERENCES Movies(ID) ON DELETE CASCADE,
     CONSTRAINT FK_Screenings_Rooms FOREIGN KEY (Room_id) REFERENCES Rooms(ID) ON DELETE CASCADE
    )
GO


CREATE TABLE Vacation
    (
     ID INTEGER PRIMARY KEY IDENTITY(1,1) ,
     Begin_date DATE NOT NULL ,
     End_date DATE NOT NULL,
     Employee_id INTEGER,
     CONSTRAINT FK_Vacation_Employees FOREIGN KEY (Employee_id) REFERENCES Employees(ID) ON DELETE CASCADE
    )
GO


--triggers

CREATE TRIGGER vacation_trigger
ON Vacation
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO Vacation
	SELECT i.Begin_date, i.End_date, i.Employee_id FROM inserted i
	WHERE (i.Begin_date <= i.End_date)
END
GO

CREATE TRIGGER licences_trigger
ON Licences
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO Licences
	SELECT i.Company, i.Purchase_date, i.Expiration_date, i.Movie_id FROM inserted i
	WHERE (i.Purchase_date <= i.Expiration_date)
END
GO

CREATE TRIGGER external_employees_trigger
ON External_employees
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO External_employees
	SELECT * FROM inserted
	WHERE (Len(inserted.SSN) = 9) AND NOT EXISTS(SELECT SSN FROM External_employees WHERE SSN = inserted.SSN)
END
GO

CREATE TRIGGER internal_employees_trigger
ON Internal_employees
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO Internal_employees 
	SELECT * FROM inserted WHERE (Len(inserted.Phone_number) = 9)
END
GO

CREATE TRIGGER units_trigger
ON Units
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO Units
	SELECT i.Unit_address, i.Phone_number, i.Manager_id FROM inserted i
	WHERE EXISTS(SELECT Employee_id FROM Internal_employees WHERE Employee_id = i.Manager_id)
END
GO

--functions
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
		SELECT M.Title, S.Movie_date, S.Movie_time, S.Room_id FROM Screenings S 
		JOIN Movies M ON S.Movie_id = M.ID 
		JOIN Units U ON U.ID = M.Unit_id
		WHERE U.ID = @unit
	RETURN
END
GO

CREATE FUNCTION Get_licences ()
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

CREATE FUNCTION Movies_today ()
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
		SELECT M.Title, M.Movie_length, M.Movie_description, S.Movie_time FROM Screenings S
		JOIN Movies M ON S.Movie_id = M.ID
		WHERE S.Movie_date = CAST(CURRENT_TIMESTAMP as DATE)
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
		SELECT M.Title, M.Premiere_date, M.Movie_length, M.Movie_description FROM Movies M
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
		SELECT Title, Movie_length FROM Movies
		WHERE Movie_length <= @length
	RETURN
END
GO

CREATE FUNCTION Movies_less_length (@movie VARCHAR(128), @length INTEGER)
RETURNS BIT
AS
BEGIN
	DECLARE @len INTEGER
	SET @len = (SELECT Movie_length FROM Movies WHERE Title = @movie)
	IF @len <= @length
		RETURN 1
	ELSE
		RETURN 0
	RETURN 0
END
GO

--procedures
CREATE PROCEDURE add_client
(@name VARCHAR(128), @surname VARCHAR(128), @sex VARCHAR(1), @email VARCHAR(128), @phone VARCHAR(9), @membership INTEGER)
AS
INSERT INTO Clients VALUES
(@name, @surname, @sex, @email, @phone, @membership)
GO

CREATE PROCEDURE add_internal
(@hiring DATE, @agreement VARCHAR(128), @name VARCHAR(128), @surname VARCHAR(128), @sex VARCHAR(1), @phone VARCHAR(9))
AS
INSERT INTO Employees VALUES
(@hiring, @agreement)
DECLARE @current_id INTEGER
SET @current_id = (SELECT MAX(ID) FROM Employees)
INSERT INTO Internal_employees VALUES
(@current_id, @name, @surname, @sex, @phone)
GO

CREATE PROCEDURE add_external
(@hiring DATE, @agreement VARCHAR(128), @name VARCHAR(128), @ssn VARCHAR(9))
AS
INSERT INTO Employees VALUES
(@hiring, @agreement)
DECLARE @current_id INTEGER
SET @current_id = (SELECT MAX(ID) FROM Employees)
INSERT INTO External_employees VALUES
(@current_id, @name, @ssn)
GO

CREATE PROCEDURE delete_client
(@id INTEGER)
AS
DELETE FROM Clients WHERE ID = @id
GO

CREATE PROCEDURE delete_employee
(@id INTEGER)
AS
DELETE FROM Employees WHERE ID = @id
GO

--views
CREATE VIEW Clients_events
AS
SELECT C.ID, C.Name , C.Surname, E.Name as 'Event_name' , E.Price FROM Clients C JOIN Events E
ON C.ID = E.Client_id
GO

CREATE VIEW Movies_gadgets
AS
SELECT M.Title, G.Category, G.Name, G.Price FROM Movies M JOIN Gadgets G
ON M.ID = G.Movie_id
GO

CREATE VIEW Employees_vacations
AS
SELECT I.Name, I.Surname, V.Begin_date, V.End_date FROM Internal_employees I JOIN Vacation V
ON I.Employee_id = V.Employee_id
GO

--inserts
INSERT INTO Genres VALUES
('Action'), ('Adventure'), ('Animation'), 
('Comedy'), ('Crime'), ('Drama'),
('Fantasy'), ('Historical'), ('Horror'),
('Science Fiction'), ('Thriller')

INSERT INTO Production_studios VALUES 
('Warner Bros Studios','14 Washington St'),
('Walt Disney Studios','12 Berger Ave'),
('20th Century Fox Studios','57 Lombard St'),
('Marvel Studios','3 Carrollton St'),
('Universal Studios','5 Main St')

INSERT INTO Sound_systems VALUES
('12-Track Digital Sound'),
('2-Track Digital Sound'),
('Dolby Atmos'),
('Dolby Digital')

INSERT INTO Visual_systems VALUES
('Holovizio C83D'),
('Pioneer MCS-434'),
('Pioneer BCS-222'),
('Skyevisual')

INSERT INTO Sponsors VALUES
('HSBC Technology'),
('Sony'),
('Google'),
('SFII'),
('Skype')

INSERT INTO Suppliers VALUES
('Cooper-Booth Whole Sale SO','14 Washington St','123456789'),
('Reinheart Food Service','12 Berger Ave','132564987'),
('Shamrock Foods','57 Lombard St','987654321'),
('Sysco','3 Carrollton St','234567891')

INSERT INTO Tickets VALUES
('Regular',20),
('Half-price',10),
('Junior/Senior',15),
('Family',26)

INSERT INTO Membership VALUES
('Coneser Pack','Independant movies',100),
('VIP','Comfortable seats and free snacks',200),
('Children Pack','5-10 age, free gadgets and popcorn',70),
('Lady Pack','Chocolate and wine',150)

INSERT INTO Clients VALUES
('Anne','Rose','F','annerose@gmail.com','111222333',1),
('Julie','Ross','F','julieross@gmail.com','111222333',2),
('Claudia','Smith','F','claudiasmith@gmail.com',NULL,1),
('Mark','Brown','M','mark@gmail.com',NULL,NULL)

INSERT INTO Tickets_orders VALUES
(1, 3, 2),
(2, 4, NULL),
(1, 2, 1)

INSERT INTO Events VALUES
('Birthday',250,1),
('Job Meetings',400,2)

INSERT INTO Food_categories VALUES
('Drinks',1),
('Sweets',2),
('Salty snacks',3)

INSERT INTO Food VALUES
('Popcorn',10,3),
('Nachos',12,3),
('Coca-Cola',5,1),
('Water',3,1),
('KitKat',4,2)

INSERT INTO Employees VALUES
('2019-10-15','General employment contract'),
('2019-02-12','General employment contract'),
('2014-12-05','General employment contract'),
('2018-05-03','Independent contractor agreement'),
('2017-04-11','Independent contractor agreement')

INSERT INTO Internal_employees VALUES
(1,'Kate','Smith','F','152436789'),
(2,'Frank','Hill','M','987604321'),
(3,'Paul','Miller','M','098765432')

INSERT INTO External_employees VALUES
(4,'Clinex','123456789'),
(5,'Securex','981237654')

INSERT INTO Units VALUES
('Washington','111111111',1),
('New York','222222222',1)

INSERT INTO Movies VALUES
('Bad Boys For Life','Adil El Arbi, Bilall Fallah', '2020-01-17',125,16,
'The Bad Boys Mike Lowrey and Marcus Burnett are back together for one last ride in the highly anticipated Bad Boys for Life. ',
0,1,1,1),
('Dolittle','Stephen Gaghan','2020-01-17',106,NULL,
'After losing his wife seven years earlier, the eccentric Dr. John Dolittle (Robert Downey Jr.), 
famed doctor and veterinarian of Queen Victorias England, hermits himself away behind the high walls of 
Dolittle Manor with only his menagerie of exotic animals for company.',1,2,2,2)

INSERT INTO Licences VALUES
('Warner Bros Studios','2019-11-10','2021-12-12',1),
('Marvel Studios','2019-10-10','2020-12-12',2)

INSERT INTO Gadgets VALUES
('Clothes','T-shirt',30,1),
('Toys','Figure',40,1),
('Clothes','Cap',25,2),
('Toys','Figure',50,2)

INSERT INTO Posters VALUES
(3000,3500,1),
(4000,4000,2)

INSERT INTO Rooms VALUES
(200,0,0,1,1,1),
(50,1,1,2,2,2),
(200,0,1,2,2,2)

INSERT INTO Screenings VALUES
('2020-01-30','05:00:00',1,1),
('2020-01-29','03:00:00',1,2),
('2020-02-02','02:00:00',2,3),
('2020-02-03','01:00:00',2,2)

INSERT INTO Vacation VALUES
('2020-03-15','2020-04-15',1),
('2020-04-15','2020-05-15',2),
('2020-05-15','2020-06-15',3)


