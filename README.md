# Multi-cinema database
**Team**: Julia Cichosz, Klaudia Goska, Anna Misiewicz

### Description
Database of the multi-cinema in MS SQL Server, created as a term project for the Databases course at Jagiellonian University in 2019/2020.

It provides 24 tables, 3 views, 8 functions, 5 triggers and 5 procedures.

Generating script and backup script was created using SQL Server Management Studio 2012.

### Purpose
The purpose of the database is storage of data relating to: repertoire, ticket offer, employed workers, registered customers, other products offered by the cinema.

### Description of views
* **Clients_events** - displays all purchased events for each client
* **Movies_gadgets** - displays all possible gadgets assigned to each movie
* **Employees_vacations** - displays used/ongoing vacations of all employees

### Description of functions
* **Repertoire** - returns the repertoire of a given facility
* **Get_licences** - returns the cinema's current licenses, sorted by date of purchase
* **Movies_today** - returns the movies playing today
* **Movies_for_age** -returns movies appropriate for a given age
* **Movies_genre** - returns movies of a given genre
* **Movies_production_studios** - returns movies produced by a given studio that the cinema has licensed
* **Movies_length** - returns movies shorter than a given length (in minutes)
* **Movies_less_length** - returns false if movie is longer than given length and true otherwise

### Description of triggers
* **vacation_trigger** - checks if the vacation start date is earlier than the vacation end date
* **licences_trigger** - checks if the date of buying a movie license is earlier than its expiration date
* **external_employees_trigger** - checks the uniqueness of the SSN, then checks if the entered SSN has nine characters
* **internal_employees_trigger** - checks if the phone number entered has nine characters
* **units_trigger** - checks if the facility manager is registered as an internal employee

### Description of procedures
* **add_client** - adds a new client
* **add_internal** - adds an internal employee
* **add_external** - adds an external company (subcontractor)
* **delete_client** - deletes a given client
* **delete_employee** - deletes a given employee or subcontractor

### Database schema

![](https://i.postimg.cc/76MRd4Dg/relation-schema.png)
