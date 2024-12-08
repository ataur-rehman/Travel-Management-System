create database TravelManagementdb;
go

use TravelManagementdb;
go

create table Users (
    userID int primary key identity(1,1), 
    userName nvarchar(50) not null,
    email nvarchar(100) unique not null, 
    passwordHash nvarchar(100) not null,
    created_at datetime default getdate()
);
go

create table Airlines (
    airlineID int primary key identity(1,1),
    airlineName nvarchar(100) not null,
    contactInfo nvarchar(100),
    website nvarchar(1000)
);
go

create table AirTickets (
    ticketID int primary key identity(1,1),
    trip nvarchar(50) not null, 
    departure nvarchar(50) not null,
    arrival nvarchar(50) not null,
    seats int not null check (seats >= 0),
    seatType nvarchar(50),
    userID int,
    airlineID int,
    constraint fk_airT_userID foreign key (userID) references Users(userID)
        on update cascade on delete cascade,
    constraint fk_airT_airlineID foreign key (airlineID) references Airlines(airlineID)
        on update cascade on delete cascade
);
go

create table Movies (
    movieID int primary key identity(1,1),
    title nvarchar(100) not null,
    genre nvarchar(50),
    duration int not null, 
    releaseDate date,
    price int not null check (price >= 0),
    description nvarchar(500)
);
go

create table MovieTickets ( 
    ticketID int primary key identity(1,1),
    movieID int not null,
    userID int,
    seatType nvarchar(50),
    seats int not null check (seats >= 0), 
    price int not null check (price >= 0),
    constraint fk_movieT_movieID foreign key (movieID) references Movies(movieID)
        on update cascade on delete cascade,
    constraint fk_movieT_userID foreign key (userID) references Users(userID)
        on update cascade on delete cascade
);
go

create table Buses (
    busID int primary key identity(1,1),
    busName nvarchar(100) not null,
    departureLocation nvarchar(100) not null,
    arrivalLocation nvarchar(100) not null,
    departureTime datetime not null,
    arrivalTime datetime not null,
    seatsAvailable int not null check (seatsAvailable >= 0),
    price int not null check (price >= 0)
);
go

create table BusTickets (
    ticketID int primary key identity(1,1),
    busID int not null,
    userID int,
    ticketType nvarchar(40),
    travelDate date not null, 
    no_Passengers int not null check (no_Passengers >= 0),
    constraint fk_busT_busID foreign key (busID) references Buses(busID)
        on update cascade on delete cascade,
    constraint fk_busT_userID foreign key (userID) references Users(userID)
        on update cascade on delete cascade
);
go

create table CarsTable (
    cars_id int primary key identity(1,1),
    title nvarchar(100) not null,
    link nvarchar(1000),
    price int not null check (price >= 0),  
    available bit not null default 1  
);
go

create table CarsTickets ( 
    ticketID int primary key identity(1,1), 
    carID int not null,
    userID int,
    dropDate date,
    pickDate date,
    price int not null check (price >= 0), 
    constraint fk_carT_carID foreign key (carID) references CarsTable(cars_id)
        on update cascade on delete cascade,
    constraint fk_carT_userID foreign key (userID) references Users(userID)
        on update cascade on delete cascade
);
go

	
create table [Events] (
    eventID int primary key identity(1,1),
    title nvarchar(100) not null,
    location nvarchar(100),
    eventDate datetime not null,
    description nvarchar(500),
    price int not null check (price >= 0),
    releaseDate date,  
    link nvarchar(1000)  
);
go


---
ALTER TABLE CarsTable
ADD image_link NVARCHAR(1000);
GO



create table EventTickets ( 
    ticketID int primary key identity(1,1),
    eventID int not null,
    userID int,
    no_Tickets int not null check (no_Tickets >= 0), 
    price int not null check (price >= 0), 
    constraint fk_eventT_eventID foreign key (eventID) references [Events](eventID)
        on update cascade on delete cascade,
    constraint fk_eventT_userID foreign key (userID) references Users(userID)
        on update cascade on delete cascade
);
go


create table Tours (
    tourID int primary key identity(1,1),
    title nvarchar(100) not null,
    tourType nvarchar(50),	
    price int not null check (price >= 0), 
    duration int not null, 
    description nvarchar(500)
);
go

create table TourTickets ( 
    ticketID int primary key identity(1,1),
    tourID int not null,
    userID int,
    no_Tickets int not null check (no_Tickets >= 0),
    price int not null check (price >= 0), 
    constraint fk_tourT_tourID foreign key (tourID) references Tours(tourID)
        on update cascade on delete cascade,
    constraint fk_tourT_userID foreign key (userID) references Users(userID)
        on update cascade on delete cascade
);
go


ALTER TABLE Users
ADD resetToken VARCHAR(255);

ALTER TABLE Users
ADD resetTokenExpiry DATETIME;

ALTER TABLE Users
ALTER COLUMN resetToken NVARCHAR(255);

ALTER TABLE Users
ALTER COLUMN resetTokenExpiry DATETIME;


--------------
INSERT INTO Users (userName, email, passwordHash)
VALUES 
    ('John Doe', 'john@example.com', 'hashedpassword123'),
    ('Jane Smith', 'jane.smith@example.com', 'hashedpassword456'),
    ('Alice Johnson', 'alice.johnson@example.com', 'hashedpassword789');

	INSERT INTO Airlines (airlineName, contactInfo, website)
VALUES
    ('Air Blue', '123-456-7890', 'www.airblue.com'),
    ('PIA', '987-654-3210', 'www.piac.com'),
    ('Qatar Airways', '555-123-4567', 'www.qatarairways.com');

	INSERT INTO AirTickets (trip, departure, arrival, seats, seatType, userID, airlineID)
VALUES
    ('One-Way', 'Karachi', 'Islamabad', 5, 'Economy', 1, 1),
    ('Round-Trip', 'Lahore', 'Dubai', 2, 'Business', 2, 3),
    ('One-Way', 'Karachi', 'Lahore', 3, 'Economy', 3, 2);

	INSERT INTO Movies (title, genre, duration, releaseDate, price, description)
VALUES
    ('Avengers: Endgame', 'Action', 180, '2019-04-26', 500, 'A Marvel superhero film.'),
    ('The Batman', 'Action', 165, '2022-03-04', 600, 'The DC superhero returns.'),
    ('Frozen II', 'Animation', 103, '2019-11-22', 400, 'A Disney animated adventure.');

	INSERT INTO MovieTickets (movieID, userID, seatType, seats, price)
VALUES
    (1, 1, 'Gold', 2, 1000),
    (2, 2, 'Silver', 1, 600),
    (3, 3, 'Economy', 3, 1200);

	INSERT INTO Buses (busName, departureLocation, arrivalLocation, departureTime, arrivalTime, seatsAvailable, price)
VALUES
    ('Daewoo Express', 'Lahore', 'Islamabad', '2024-01-01 08:00:00', '2024-01-01 12:00:00', 20, 1500),
    ('Faisal Movers', 'Karachi', 'Lahore', '2024-01-01 18:00:00', '2024-01-02 06:00:00', 15, 3000),
    ('Skyways', 'Rawalpindi', 'Peshawar', '2024-01-01 09:00:00', '2024-01-01 11:30:00', 25, 800);

	INSERT INTO BusTickets (busID, userID, ticketType, travelDate, no_Passengers)
VALUES
    (1, 1, 'VIP', '2024-01-01', 2),
    (2, 2, 'Economy', '2024-01-02', 3),
    (3, 3, 'Standard', '2024-01-03', 1);

	INSERT INTO CarsTable (title, link, price, available)
VALUES
    ('Toyota Corolla', 'www.rentacar.com/toyota-corolla', 2000, 1),
    ('Honda Civic', 'www.rentacar.com/honda-civic', 2500, 1),
    ('Suzuki Alto', 'www.rentacar.com/suzuki-alto', 1500, 0);

	INSERT INTO CarsTickets (carID, userID, dropDate, pickDate, price)
VALUES
    (1, 1, '2024-01-02', '2024-01-05', 6000),
    (2, 2, '2024-01-03', '2024-01-07', 10000);
	
	INSERT INTO Events (title, location, eventDate, description, price, releaseDate, link)
VALUES
    ('Wedding Event', 'Pearl Continental', '2024-02-14 18:00:00', 'A grand wedding celebration.', 50000, '2024-01-01', 'www.events.com/wedding'),
    ('Birthday Party', 'Royal Palm', '2024-03-01 16:00:00', 'A surprise birthday party.', 20000, '2024-02-01', 'www.events.com/birthday'),
    ('Corporate Meeting', 'Serena Hotel', '2024-01-15 10:00:00', 'A professional business meeting.', 100000, '2024-01-01', 'www.events.com/corporate');

	INSERT INTO EventTickets (eventID, userID, no_Tickets, price)
VALUES
    (1, 1, 100, 50000),
    (2, 2, 50, 20000),
    (3, 3, 10, 100000);

	INSERT INTO Tours (title, tourType, price, duration, description)
VALUES
    ('Hunza Valley Tour', 'Adventure', 25000, 7, 'A 7-day tour of the scenic Hunza Valley.'),
    ('Swat Valley Tour', 'Family', 20000, 5, 'Explore the beautiful Swat Valley.'),
    ('Neelum Valley Tour', 'Hiking', 30000, 6, 'A hiking trip through the lush Neelum Valley.');

	INSERT INTO TourTickets (tourID, userID, no_Tickets, price)
VALUES
    (1, 1, 5, 125000),
    (2, 2, 3, 60000),
    (3, 3, 2, 60000);
	
SELECT * FROM Users;
SELECT * FROM AirTickets;
SELECT * FROM Movies;
select *From Tours;	
select* from CarsTable
select* from CarsTickets
select* from buses
select* from BusTickets

UPDATE CarsTable
SET image_link = 'assets/images/sedan2.png'
WHERE cars_id = 2;

UPDATE CarsTable
SET image_link = 'assets/images/sedan.png'
WHERE cars_id = 1;

UPDATE CarsTable
SET image_link = 'assets/images/alto.png'
WHERE cars_id = 3;                                                                                                                                                                                                                                                                                                       
GO

UPDATE CarsTable
SET image_link = 'assets/images/mehran.png'
WHERE cars_id = 4;
GO

