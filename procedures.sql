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