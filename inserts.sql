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
