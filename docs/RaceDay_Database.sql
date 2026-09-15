/*
RaceDay - Part 1 SQL Database Script
Target: Microsoft SQL Server / SSMS
The tables below match the ERD in docs/RaceDay_ERD.md.
*/

IF DB_ID('RaceDay') IS NULL
    CREATE DATABASE RaceDay;
GO

USE RaceDay;
GO

DROP TABLE IF EXISTS Results;
DROP TABLE IF EXISTS Enrolments;
DROP TABLE IF EXISTS EventCategories;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS Users;
GO

CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(150) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) NOT NULL
        CONSTRAINT CK_Users_Role CHECK (Role IN ('Organiser','Participant')),
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

CREATE TABLE Events (
    EventId INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserId INT NOT NULL,
    EventName NVARCHAR(150) NOT NULL,
    Description NVARCHAR(1000) NULL,
    EventType NVARCHAR(30) NOT NULL
        CONSTRAINT CK_Events_EventType CHECK (EventType IN ('Running','Walking','Cycling')),
    EventDate DATE NOT NULL,
    StartTime TIME NOT NULL,
    Location NVARCHAR(200) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_Events_Organiser
        FOREIGN KEY (OrganiserId) REFERENCES Users(UserId)
);
GO

CREATE TABLE Categories (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL UNIQUE,
    Description NVARCHAR(500) NULL
);
GO

CREATE TABLE EventCategories (
    EventCategoryId INT IDENTITY(1,1) PRIMARY KEY,
    EventId INT NOT NULL,
    CategoryId INT NOT NULL,
    EntryFee DECIMAL(10,2) NOT NULL DEFAULT 0.00
        CONSTRAINT CK_EventCategories_EntryFee CHECK (EntryFee >= 0),
    MaximumParticipants INT NULL
        CONSTRAINT CK_EventCategories_MaxParticipants CHECK (MaximumParticipants IS NULL OR MaximumParticipants > 0),
    CONSTRAINT UQ_EventCategories_Event_Category UNIQUE (EventId, CategoryId),
    CONSTRAINT FK_EventCategories_Event
        FOREIGN KEY (EventId) REFERENCES Events(EventId),
    CONSTRAINT FK_EventCategories_Category
        FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
);
GO

CREATE TABLE Enrolments (
    EnrolmentId INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantId INT NOT NULL,
    EventCategoryId INT NOT NULL,
    EnrolmentDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    Status NVARCHAR(20) NOT NULL DEFAULT 'Registered'
        CONSTRAINT CK_Enrolments_Status CHECK (Status IN ('Registered','Cancelled','Completed')),
    CONSTRAINT UQ_Enrolments_Participant_EventCategory UNIQUE (ParticipantId, EventCategoryId),
    CONSTRAINT FK_Enrolments_Participant
        FOREIGN KEY (ParticipantId) REFERENCES Users(UserId),
    CONSTRAINT FK_Enrolments_EventCategory
        FOREIGN KEY (EventCategoryId) REFERENCES EventCategories(EventCategoryId)
);
GO

CREATE TABLE Results (
    ResultId INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentId INT NOT NULL UNIQUE,
    FinishTime TIME NULL,
    Position INT NULL
        CONSTRAINT CK_Results_Position CHECK (Position IS NULL OR Position > 0),
    ResultStatus NVARCHAR(20) NOT NULL DEFAULT 'Finished'
        CONSTRAINT CK_Results_Status CHECK (ResultStatus IN ('Finished','DidNotFinish','Disqualified')),
    RecordedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_Results_Enrolment
        FOREIGN KEY (EnrolmentId) REFERENCES Enrolments(EnrolmentId)
);
GO

-- Seed data: 2 organisers, 2 participants, 3 events, categories and enrolments.
INSERT INTO Users (FirstName, LastName, Email, PasswordHash, Role)
VALUES
('Thabo', 'Mokoena', 'thabo.organiser@raceday.co.za', 'DEMO_HASH_1', 'Organiser'),
('Lerato', 'Naidoo', 'lerato.organiser@raceday.co.za', 'DEMO_HASH_2', 'Organiser'),
('Sipho', 'Dlamini', 'sipho.participant@example.com', 'DEMO_HASH_3', 'Participant'),
('Amahle', 'Ndlovu', 'amahle.participant@example.com', 'DEMO_HASH_4', 'Participant');
GO

INSERT INTO Categories (CategoryName, Description)
VALUES
('10 km', 'Ten kilometre event category'),
('21 km Half Marathon', 'Half marathon category'),
('42 km Marathon', 'Full marathon category'),
('20 km Cycle', 'Twenty kilometre cycling category');
GO

INSERT INTO Events
(OrganiserId, EventName, Description, EventType, EventDate, StartTime, Location)
VALUES
(1, 'Soweto Community Run', 'Community running event for local participants.', 'Running', '2026-10-10', '07:00', 'Soweto, Johannesburg'),
(1, 'Cape Town Charity Walk', 'Charity walking event supporting local community projects.', 'Walking', '2026-11-01', '08:00', 'Cape Town, Western Cape'),
(2, 'Johannesburg Cycle Challenge', 'Road cycling event through selected Johannesburg routes.', 'Cycling', '2026-11-15', '06:30', 'Johannesburg, Gauteng');
GO

INSERT INTO EventCategories (EventId, CategoryId, EntryFee, MaximumParticipants)
VALUES
(1, 1, 120.00, 500),
(1, 2, 180.00, 300),
(2, 1, 80.00, 400),
(3, 4, 250.00, 250);
GO

INSERT INTO Enrolments (ParticipantId, EventCategoryId, Status)
VALUES
(3, 1, 'Registered'),
(3, 2, 'Registered'),
(4, 3, 'Registered'),
(4, 4, 'Registered');
GO

INSERT INTO Results (EnrolmentId, FinishTime, Position, ResultStatus)
VALUES
(1, '00:54:32', 14, 'Finished'),
(2, '01:58:11', 22, 'Finished');
GO

-- Quick verification
SELECT * FROM Users;
SELECT * FROM Events;
SELECT * FROM Categories;
SELECT * FROM EventCategories;
SELECT * FROM Enrolments;
SELECT * FROM Results;
GO
