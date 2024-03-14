/*
 * Name :Clavan Dsouza
 * Course : DataBase 2
 * Date : 03/03/2024
 */

USE TRAIN_BOOKING_SYSTEM;

DROP TABLE IF EXISTS ticket;
DROP TABLE IF EXISTS trip;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS station;
DROP TABLE IF EXISTS train;
DROP TABLE IF EXISTS class;


CREATE TABLE class (
    class_id INT NOT NULL,
    class_name NVARCHAR(20) NOT NULL,
    CONSTRAINT classPK 
		PRIMARY KEY (class_id)
);

CREATE TABLE train (
    train_id INT NOT NULL,
    train_name NVARCHAR(20) NOT NULL,
    CONSTRAINT trainPK 
		PRIMARY KEY (train_id)
);

CREATE TABLE station (
    station_name NVARCHAR(30) NOT NULL,
    CONSTRAINT stationPK 
		PRIMARY KEY (station_name)
);

CREATE TABLE customer (
    cust_id INT NOT NULL,
    first_name NVARCHAR(30) NOT NULL,
	last_name NVARCHAR(30) NOT NULL,
	phone NVARCHAR(16) NOT NULL,
    gender NVARCHAR(10) NOT NULL,
    addresses NVARCHAR(30) NOT NULL,
	city_name NVARCHAR(30) NOT NULL,
	state_name NVARCHAR(30) NOT NULL,
    CONSTRAINT customerPK
		PRIMARY KEY (cust_id),
);

CREATE TABLE trip (
    trip_id INT NOT NULL,
	trip_no NVARCHAR(20) NOT NULL,
    station_name_depart NVARCHAR(30) NOT NULL,
    station_name_arrival NVARCHAR(30) NOT NULL,
    class_id INT NOT NULL,
	train_id INT NOT NULL,
	depart_datetime DATETIME NOT NULL,
	arrival_datetime DATETIME NOT NULL,
    CONSTRAINT tripPK
		PRIMARY KEY (trip_id),
    CONSTRAINT departsFK
		FOREIGN KEY (station_name_depart)
		REFERENCES station(station_name),
    CONSTRAINT arrivalsFK 
		FOREIGN KEY (station_name_arrival) 
		REFERENCES station(station_name),
    CONSTRAINT chosenFk
		FOREIGN KEY (class_id) 
		REFERENCES class(class_id),
	CONSTRAINT usesFk
		FOREIGN KEY (train_id)
		REFERENCES train(train_id),
);

CREATE TABLE ticket (
	ticket_id INT NOT NULL,
    ticket_no NVARCHAR(20) NOT NULL,
    cust_id INT NOT NULL,
    trip_id INT NOT NULL,
	ticket_price DECIMAL(6,2) NOT NULL,
    CONSTRAINT ticketPK
		PRIMARY KEY (ticket_id),
    CONSTRAINT purchasesFK 
		FOREIGN KEY (cust_id) 
		REFERENCES customer(cust_id),
    CONSTRAINT forFK 
		FOREIGN KEY (trip_id) 
		REFERENCES trip(trip_id)
);