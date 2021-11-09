USE master
GO
IF EXISTS (SELECT * FROM sysdatabases WHERE name='ObligatorioBD2N3A')
		DROP DATABASE ObligatorioBD2N3A
GO

CREATE DATABASE ObligatorioBD2N3A
GO

USE ObligatorioBD2N3A
GO

CREATE TABLE Estaciones (
	codigo INT NOT NULL,
	descripcion VARCHAR(60),
	barrio VARCHAR(25),
	CONSTRAINT PK_Estaciones PRIMARY KEY (codigo)
);


CREATE TABLE Lineas (
	numero INT NOT NULL,
	descripcion VARCHAR(60),
	longitud DECIMAL,
	color VARCHAR(20),
	codigoEstacionOrigen INT,
	codigoEstacionDestino INT
	CONSTRAINT PK_Lineas PRIMARY KEY (numero),
	CONSTRAINT FK_Lineas_Estaciones_Origen FOREIGN KEY (codigoEstacionOrigen) REFERENCES Estaciones (codigo),
	CONSTRAINT FK_Lineas_Estaciones_Destino FOREIGN KEY (codigoEstacionDestino) REFERENCES Estaciones (codigo),
	CONSTRAINT CK_Lineas_Longitud CHECK (longitud >= 1),
	CONSTRAINT CK_Lineas_Color CHECK (color IN ('rojo', 'azul', 'amarillo', 'naranja', 'verde', 'negro'))
);
CREATE INDEX IDX_Lineas_EstacionOrigen ON Lineas(codigoEstacionOrigen)
CREATE INDEX IDX_Lineas_EstacionDestino ON Lineas(codigoEstacionDestino)


CREATE TABLE Trenes (
	numero INT NOT NULL,
	descripcion VARCHAR(60),
	letra CHAR(1),
	cantVagon INT,
	capacVagon INT,
	CONSTRAINT PK_Trenes PRIMARY KEY (numero),
	CONSTRAINT UK_Trenes_Letra UNIQUE (letra),
	CONSTRAINT CK_Trenes_CapacVagon CHECK (capacVagon <= 40)
);


CREATE TABLE Poseen (
	id INT IDENTITY(1,1) NOT NULL, --Creado a modo de facilitar las consultas
	numeroLinea INT NOT NULL,
	codigoEstacion INT NOT NULL,
	CONSTRAINT PK_Poseen PRIMARY KEY (id),
	CONSTRAINT UK_Poseen_NumLinea_Estacion UNIQUE (numeroLinea, codigoEstacion),
	CONSTRAINT FK_Poseen_Lineas_NumLinea FOREIGN KEY (numeroLinea) REFERENCES Lineas (numero),
	CONSTRAINT FK_Poseen_Estaciones_CodEstacion FOREIGN KEY (codigoEstacion) REFERENCES Estaciones (codigo),
);


CREATE TABLE Pasan (
	id INT IDENTITY(1,1) NOT NULL, --Creado a modo de facilitar las consultas
	numeroTren INT NOT NULL,
	numeroLinea INT NOT NULL,
	codigoEstacion INT NOT NULL,
	fechaYHora DATETIME NOT NULL,
	CONSTRAINT PK_Pasan PRIMARY KEY (id),
	CONSTRAINT UK_Pasan_numTren_numLinea_codEstac_fechayH UNIQUE (numeroTren, numeroLinea, codigoEstacion, fechaYHora),
	CONSTRAINT FK_Pasan_Trenes_NumTren FOREIGN KEY (numeroTren) REFERENCES Trenes (numero),
	CONSTRAINT FK_Pasan_Lineas_NumLinea FOREIGN KEY (numeroLinea) REFERENCES Lineas (numero),
	CONSTRAINT FK_Pasan_Estaciones_CodEstacion FOREIGN KEY (codigoEstacion) REFERENCES Estaciones (codigo),
);


INSERT INTO Estaciones VALUES 
(1, 'Acton Town station', 'Ealing'),
(2, 'Archway station', 'Islington'),
(3, 'Baker Street station', 'City of Westminster'),
(4, 'Barons Court station', 'Hammersmith and Fulham'),
(5, 'Bow Road station', 'Tower Hamlets'),
(6, 'Cannon Street station', 'City of London'),
(7, 'East Ham station', 'Newham'),
(8, 'Highgate station', 'Haringey'),
(9, 'Kennington station', 'Southwark'),
(10, 'Leyton station', 'Waltham Forest'),
(11, 'Liverpool Street station', 'City of London'),
(12, 'Mill Hill East station', 'Barnet'),
(13, 'Morden station', 'Merton'),
(14, 'Notting Hill Gate station', 'Kensington and Chelsea'),
(15, 'Oakwood station', 'Enfield'),
(16, 'Oval station', 'Lambeth'),
(17, 'Roding Valley station', 'Epping Forest Redbridge'),
(18, 'Ruislip Gardens station', 'Hillingdon'),
(19, 'South Kenton station', 'Brent'),
(20, 'Woodford station', 'Redbridge')


INSERT INTO Lineas VALUES 
(100, 'Bakerloo Line', 6, 'naranja', 1, 2),
(110, 'Central line', 3, 'rojo', 2, 3),
(120, 'Circle line', 10, 'amarillo', 3, 4),
(130, 'Hammersmith line', 2, 'azul', 5, 6),
(140, 'Jubilee line', 12, 'negro', 7, 8),
(150, 'Metropolitan line', 25, 'naranja', 9, 10),
(160, 'Northern line', 1, 'negro', 11, 12),
(170, 'Piccadilly line', 30, 'verde', 13, 14),
(180, 'Victoria line', 16, 'azul', 15, 16),
(190, 'Waterloo line', 19, 'azul', 17, 18),
(200, 'Godalming line', 5, 'verde', 19, 20),
(210, 'Royal line', 5, 'negro', 5,1),
(220, 'Ashford line', 22, 'amarillo', 10, 1),
(230, 'Gravesend line', 4, 'azul', 11, 2),
(240, 'Tring line', 12, 'azul', 13, 3),
(250, 'Wimbledon line', 50, 'rojo', 14, 5),
(260, 'Amersham line', 11, 'naranja', 16, 3),
(270, 'London Main line', 67, 'negro', 1, 2),
(280, 'Bromley line', 8, 'naranja', 1, 2),
(290, 'Windsor line', 45, 'verde', 1, 2)


INSERT INTO Trenes VALUES 
(1000, 'The Overland train', 'A', 10, 25),
(1100, 'Travel train', 'B', 6, 12),
(1200, 'Caledonian train', 'C', 4, 10),
(1300, 'Cathedrals Express train', 'D', 25, 40),
(1400, 'Clansman train', 'E', 11, 15),
(1500, 'East Anglian train', 'F', 10, 25),
(1600, 'Enterprise train', 'G', 5, 31),
(1700, 'Fenman train', 'H', 8, 32),
(1800, 'Flying Dutchman train', 'I', 4, 12),
(1900, 'Hull Executive train', 'J', 2, 6),
(2000, 'The Lewisman train', 'K', 4, 31),
(2100, 'Night Ferry train', 'L', 2, 3)


INSERT INTO Poseen VALUES 
(100, 1),
(100, 8),
(100, 14),
(100, 13),
(100, 3),
(110, 1),
(110, 2),
(110, 4),
(110, 6),
(120, 11),
(120, 3),
(120, 19),
(120, 5),
(130, 4),
(130, 10),
(130, 18),
(130, 19),
(140, 20),
(140, 1),
(140, 8),
(140, 14),
(150, 1),
(150, 2),
(150, 3),
(150, 10),
(160, 17),
(160, 16),
(160, 15),
(160, 11),
(170, 1),
(170, 4),
(170, 6),
(170, 14),
(180, 9),
(180, 12),
(180, 13),
(180, 19),
(190, 11),
(190, 15),
(190, 3),
(190, 6),
(200, 11),
(200, 15),
(210, 12),
(210, 4),
(220, 2),
(230, 14),
(240, 15),
(240, 11),
(250, 2),
(250, 13),
(260, 17),
(260, 11),
(270, 18),
(280, 19),
(290, 20)


INSERT INTO Pasan VALUES 
(1700, 190, 9, CONCAT(YEAR(DATEADD(YEAR, -2, GETDATE())), '-03-16 ', '19:25:00')),
(1700, 200, 10, CONCAT(YEAR(DATEADD(YEAR, -2, GETDATE())), '-04-15 ', '12:24:00')),
(1700, 200, 1, CONCAT(YEAR(DATEADD(YEAR, -2, GETDATE())), '-01-12 ', '12:29:00')),
(1800, 130, 4, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-09-14 ', '12:15:00')),
(1100, 130, 4, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-01-30 ', '12:15:00')),
(1300, 130, 4, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-06-21 ', '03:13:00')),
(2100, 130, 4, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-08-22 ', '03:13:00')),
(1600, 140, 4, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-09-14 ', '12:15:00')),
(1100, 160, 7, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-01-30 ', '12:15:00')),
(1400, 170, 7, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-06-21 ', '03:13:00')),
(2100, 170, 7, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-08-22 ', '03:13:00')),
(1100, 180, 8, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-01-30 ', '12:15:00')),
(1300, 170, 7, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-06-21 ', '03:13:00')),
(2100, 180, 8, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-08-22 ', '03:13:00')),
(1700, 110, 3, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-04-25 ', '12:15:00')),
(1700, 120, 5, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-04-27 ', '12:15:00')),
(1700, 120, 2, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-07-15 ', '15:35:00')),
(1800, 130, 3, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-03-29 ', '15:30:00')),
(1700, 140, 4, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-12-31 ', '05:45:00')),
(1700, 150, 4, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-04-08 ', '03:00:00')),
(1200, 160, 7, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-01-03 ', '12:25:00')),
(1700, 160, 6, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-03-12 ', '12:15:00')),
(1700, 170, 7, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-10-17 ', '17:25:00')),
(1100, 170, 8, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-12-31 ', '15:45:00')),
(1700, 210, 11, CONCAT(CONVERT(char(10), DATEADD(DAY, -180, GETDATE()),126), ' 09:45:00')),
(1700, 220, 12, CONCAT(CONVERT(char(10), DATEADD(DAY, -125, GETDATE()),126), ' 04:56:00')),
(1700, 230, 13, CONCAT(CONVERT(char(10), DATEADD(DAY, -100, GETDATE()),126), ' 04:45:00')),
(1700, 240, 14, CONCAT(CONVERT(char(10), DATEADD(DAY, -90, GETDATE()),126), ' 13:13:00')),
(1700, 250, 15, CONCAT(CONVERT(char(10), DATEADD(DAY, -89, GETDATE()),126), ' 12:21:00')),
(1700, 260, 16, CONCAT(CONVERT(char(10), DATEADD(DAY, -88, GETDATE()),126), ' 16:21:00')),
(1700, 200, 8, CONCAT(CONVERT(char(10), DATEADD(DAY, -86, GETDATE()),126), ' 16:21:00')),
(1700, 270, 17, CONCAT(CONVERT(char(10), DATEADD(DAY, -79, GETDATE()),126), ' 23:45:00')),
(1700, 280, 18, CONCAT(CONVERT(char(10), DATEADD(DAY, -66, GETDATE()),126), ' 22:00:00')),
(1700, 290, 19, CONCAT(CONVERT(char(10), DATEADD(DAY, -56, GETDATE()),126), ' 21:00:00')),
(1700, 150, 20, CONCAT(CONVERT(char(10), DATEADD(DAY, -50, GETDATE()),126), ' 20:05:00')),
(1000, 150, 3, CONCAT(CONVERT(char(10), DATEADD(DAY, -45, GETDATE()),126), ' 20:07:00')),
(1100, 150, 3, CONCAT(CONVERT(char(10), DATEADD(DAY, -45, GETDATE()),126), ' 20:12:00')),
(1200, 140, 3, CONCAT(CONVERT(char(10), DATEADD(DAY, -44, GETDATE()),126), ' 22:13:00')),
(1300, 130, 3, CONCAT(CONVERT(char(10), DATEADD(DAY, -43, GETDATE()),126), ' 21:14:00')),
(1400, 210, 4, CONCAT(CONVERT(char(10), DATEADD(DAY, -33, GETDATE()),126), ' 22:15:00')),
(1100, 270, 4, CONCAT(CONVERT(char(10), DATEADD(DAY, -30, GETDATE()),126), ' 21:12:00')),
(1200, 250, 6, CONCAT(CONVERT(char(10), DATEADD(DAY, -26, GETDATE()),126), ' 10:45:00')),
(1300, 150, 8, CONCAT(CONVERT(char(10), DATEADD(DAY, -22, GETDATE()),126), ' 10:12:00')),
(1400, 150, 4, CONCAT(CONVERT(char(10), DATEADD(DAY, -22, GETDATE()),126), ' 09:12:00')),
(1500, 140, 3, CONCAT(CONVERT(char(10), DATEADD(DAY, -20, GETDATE()),126), ' 05:32:00')),
(1600, 190, 2, CONCAT(CONVERT(char(10), DATEADD(DAY, -15, GETDATE()),126), ' 08:33:00')),
(1800, 130, 13, CONCAT(CONVERT(char(10), DATEADD(DAY, -12, GETDATE()),126), ' 09:45:00')),
(1900, 290, 14, CONCAT(CONVERT(char(10), DATEADD(DAY, -6, GETDATE()),126), ' 12:00:00')),
(2000, 180, 15, CONCAT(CONVERT(char(10), DATEADD(DAY, -4, GETDATE()),126), ' 12:01:00')),
(1900, 170, 19, CONCAT(CONVERT(char(10), DATEADD(DAY, -4, GETDATE()),126), ' 12:59:00')),
(1900, 120, 17, CONCAT(CONVERT(char(10), DATEADD(DAY, -2, GETDATE()),126), ' 01:10:00')),
(1300, 290, 5, CONCAT(CONVERT(char(10), DATEADD(DAY, -1, GETDATE()),126), ' 03:05:00')),
(1200, 290, 5, CONCAT(CONVERT(char(10), DATEADD(DAY, -1, GETDATE()),126), ' 03:13:00'))