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