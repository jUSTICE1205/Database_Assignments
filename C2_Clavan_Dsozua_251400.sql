/*
 *  Name: Clavan Dsouza
 *  Challenge: 2
 *  Date: 2024-01-24
 */

 -- Create DataBase if not existed
CREATE DATABASE Challenge2;

USE Challenge2;

-- 
DROP TABLE IF EXISTS PerformsIn;
DROP TABLE IF EXISTS Movie;
DROP TABLE IF EXISTS Actor;

CREATE TABLE Actor (
    ActorID INT NOT NULL,
    FirstName NVARCHAR(30) NOT NULL,
    LastName NVARCHAR(30) NOT NULL,
    DOB DATE NOT NULL,
	CONSTRAINT ActorPK
		PRIMARY KEY (ActorID)
);

CREATE TABLE Movie (
    MovieID INT NOT NULL,
    Title NVARCHAR(50) NOT NULL,
    Genre NVARCHAR(50) NOT NULL,
    YearReleased DATE NOT NULL,
	CONSTRAINT MoviePK
		PRIMARY KEY (MovieID)
);

CREATE TABLE PerformsIn (
    ActorID INT NOT NULL,
    MovieID INT NOT NULL,
    RoleType NVARCHAR(50) NOT NULL,
    CONSTRAINT PerformsIn_FK_Actor
		FOREIGN KEY (ActorID) 
		REFERENCES Actor(ActorID)
		ON DELETE CASCADE,
    CONSTRAINT PerformsIn_FK_Movie
		FOREIGN KEY (MovieID) 
		REFERENCES Movie(MovieID)
		ON DELETE CASCADE 
);

-- Index for the foreign key of performIn
CREATE NONCLUSTERED INDEX IX_PerformsIn_ActorID ON PerformsIn(ActorID);
CREATE NONCLUSTERED INDEX IX_PerformsIn_MovieID ON PerformsIn(MovieID);