
IF DB_ID(N'flugbuchung') IS NULL
    CREATE DATABASE flugbuchung;
GO
USE flugbuchung;
GO 

IF OBJECT_ID('Buchung') IS NOT NULL
    DROP TABLE Buchung;
GO


IF OBJECT_ID('Passagier') IS NOT NULL
    DROP TABLE Passagier;
GO

CREATE TABLE Passagier (
  ID INT PRIMARY KEY IDENTITY, 
  Vorname NVARCHAR(100),
  Nachname NVARCHAR(100), 
);




CREATE TABLE Buchung (
  ID INT PRIMARY KEY IDENTITY, 
  Gesamtpreis INT,
  ID_Passagier INT,
  CONSTRAINT fk_fuehrt_durch FOREIGN KEY (ID_Passagier)
	REFERENCES Passagier(ID)
	ON DELETE CASCADE
);

IF OBJECT_ID('Flugstrecke') IS NOT NULL
    DROP TABLE Flugstrecke;
GO
IF OBJECT_ID('Flugzeug') IS NOT NULL
    DROP TABLE Flugzeug;
GO
CREATE TABLE Flugzeug (
  Flugzeugnr INT PRIMARY KEY, 
  Bezeichnung NVARCHAR(100),
  Sitze INT, 
);


IF OBJECT_ID('Flugstrecke') IS NOT NULL
    DROP TABLE Flugstrecke;
GO
CREATE TABLE Flugstrecke (
  Flugnr NVARCHAR(100), 
  Abflugzeit DATETIME,
  Start NVARCHAR(100),
  Ziel NVARCHAR(100),
  Flugzeugnr INT,
  CONSTRAINT pk_flugnr_abflugzeit 
	PRIMARY KEY(Flugnr, Abflugzeit),
  CONSTRAINT fk_fliegt FOREIGN KEY (Flugzeugnr)
	REFERENCES Flugzeug(Flugzeugnr)
	ON DELETE NO ACTION 
);

IF OBJECT_ID('BestehtAus') IS NOT NULL
    DROP TABLE BestehtAus;
GO
CREATE TABLE BestehtAus (
  Flugnr NVARCHAR(100), 
  Abflugzeit DATETIME,
  ID_Buchung INT,
  CONSTRAINT fk_bestehtaus_flugstrecke FOREIGN KEY (Flugnr,Abflugzeit)
	REFERENCES Flugstrecke(Flugnr,Abflugzeit)
	ON DELETE NO ACTION 
);


INSERT INTO Passagier(Vorname,Nachname) 
	VALUES ('Leon', 'Schorn');

INSERT INTO Buchung(Gesamtpreis, ID_Passagier) 
	VALUES (476, 1);

INSERT INTO Flugzeug(Flugzeugnr, Bezeichnung, Sitze)
	VALUES (96273, 'Dash 8-400', 45),
		   (43875, 'Airbus A320', 180);

INSERT INTO Flugstrecke(Flugnr, Abflugzeit, Start, Ziel, Flugzeugnr) 
	VALUES ('AB6485','20181104 10:45','Saarbrücken', 'Berlin', 96273),
		   ('AB8034','20181104 14:05','Berlin', 'Kopenhagen', 43875)

INSERT INTO BestehtAus(Flugnr, Abflugzeit,ID_Buchung)
	VALUES ('AB6485','20181104 10:45',1),
		   ('AB8034','20181104 14:05',1);