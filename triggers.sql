CREATE TRIGGER vacation_trigger
ON Vacation
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @begin_date DATE, @end_date DATE, @employee_id INTEGER
	SELECT @begin_date = inserted.Begin_date,
	@end_date = inserted.End_date,
	@employee_id = inserted.Employee_id FROM inserted
	IF (@begin_date <= @end_date)
		INSERT INTO Vacation VALUES
		(@begin_date, @end_date, @employee_id)
	ELSE
		RAISERROR('Wrong input', 16,1)
END




CREATE TRIGGER licences_trigger
ON Licences
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @company VARCHAR(128), @purchase_date DATE, @expiration_date DATE, @movie_id INTEGER
	SELECT @company = inserted.Company,
	@purchase_date = inserted.Purchase_date,
	@expiration_date = inserted.Expiration_date,
	@movie_id = inserted.Movie_id FROM inserted
	IF (@purchase_date <= @expiration_date)
		INSERT INTO Licences VALUES
		(@company, @purchase_date, @expiration_date, @movie_id)
	ELSE
		RAISERROR('Wrong input', 16,1)
END



CREATE TRIGGER external_employees_trigger
ON External_employees
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @employee_id INTEGER, @name VARCHAR(128), @ssn VARCHAR(9)
	SELECT @employee_id = inserted.Employee_id,
	@name = inserted.Name,
	@ssn = inserted.SSN FROM inserted

	IF EXISTS (SELECT SSN FROM External_employees WHERE SSN = @ssn)
	BEGIN
		RAISERROR('Wrong input', 16,1)
		DELETE FROM Employees WHERE ID = (SELECT MAX(ID) FROM Employees)
	END
	ELSE
	BEGIN
		IF (LEN(@ssn) <> 9)
		BEGIN
			RAISERROR('Wrong input', 16,1)
			DELETE FROM Employees WHERE ID = (SELECT MAX(ID) FROM Employees)
		END
		ELSE
			INSERT INTO External_employees VALUES
			(@employee_id, @name, @ssn)
	END
END



CREATE TRIGGER internal_employees_trigger
ON Internal_employees
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @employee_id INTEGER, @name VARCHAR(128), @surname VARCHAR(128), @sex VARCHAR(1), @phone VARCHAR(9)
	SELECT @employee_id = inserted.Employee_id,
	@name = inserted.Name,
	@surname = inserted.Surname,
	@sex = inserted.Sex,
	@phone = inserted.Phone_number FROM inserted
	IF (LEN(@phone) <> 9)
	BEGIN
		RAISERROR('Wrong input', 16,1)
		DELETE FROM Employees WHERE ID = (SELECT MAX(ID) FROM Employees)
	END
	ELSE
		INSERT INTO Internal_employees VALUES
		(@employee_id, @name, @surname, @sex, @phone)
END


CREATE TRIGGER units_trigger
ON Units
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @unit_address VARCHAR(128), @phone VARCHAR(9), @manager INTEGER
	SELECT @unit_address = inserted.Unit_address,
	@phone = inserted.Phone_number,
	@manager = inserted.Manager_id
	FROM inserted
	IF EXISTS(SELECT Employee_id FROM Internal_employees WHERE Employee_id = @manager)
		INSERT INTO Units VALUES
		(@unit_address, @phone, @manager)
	ELSE
		RAISERROR('Wrong input', 16,1)
END