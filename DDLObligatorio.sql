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
	numeroLinea INT NOT NULL,
	codigoEstacion INT NOT NULL,
	CONSTRAINT PK_Poseen PRIMARY KEY (numeroLinea, codigoEstacion),
	CONSTRAINT FK_Poseen_Lineas_NumLinea FOREIGN KEY (numeroLinea) REFERENCES Lineas (numero),
	CONSTRAINT FK_Poseen_Estaciones_CodEstacion FOREIGN KEY (codigoEstacion) REFERENCES Estaciones (codigo),
);
CREATE INDEX IDX_Poseen_NumLinea ON Poseen(numeroLinea)
CREATE INDEX IDX_Poseens_CodEstacion ON Poseen(codigoEstacion)



CREATE TABLE PASAN (
	numeroTren INT NOT NULL,
	numeroLinea INT NOT NULL,
	codigoEstacion INT NOT NULL,
	fechaYHora DATETIME NOT NULL,
	CONSTRAINT PK_Pasan PRIMARY KEY (numeroTren, numeroLinea, codigoEstacion, fechaYHora),
	CONSTRAINT FK_Pasan_Trenes_NumTren FOREIGN KEY (numeroTren) REFERENCES Trenes (numero),
	CONSTRAINT FK_Pasan_Lineas_NumLinea FOREIGN KEY (numeroLinea) REFERENCES Lineas (numero),
	CONSTRAINT FK_Pasan_Estaciones_CodEstacion FOREIGN KEY (codigoEstacion) REFERENCES Estaciones (codigo),
);
CREATE INDEX IDX_Pasan_NumTren ON Pasan(numeroTren)
CREATE INDEX IDX_Pasan_NumLinea ON Pasan(numeroLinea)
CREATE INDEX IDX_Pasan_CodEstacion ON Pasan(codigoEstacion)




INSERT INTO Estaciones VALUES (1, 'Acton Town station', 'Ealing');
INSERT INTO Estaciones VALUES (2, 'Archway station', 'Islington');
INSERT INTO Estaciones VALUES (3, 'Baker Street station', 'City of Westminster');
INSERT INTO Estaciones VALUES (4, 'Barons Court station', 'Hammersmith and Fulham');
INSERT INTO Estaciones VALUES (5, 'Bow Road station', 'Tower Hamlets');
INSERT INTO Estaciones VALUES (6, 'Cannon Street station', 'City of London');
INSERT INTO Estaciones VALUES (7, 'East Ham station', 'Newham');
INSERT INTO Estaciones VALUES (8, 'Highgate station', 'Haringey');
INSERT INTO Estaciones VALUES (9, 'Kennington station', 'Southwark');
INSERT INTO Estaciones VALUES (10, 'Leyton station', 'Waltham Forest');
INSERT INTO Estaciones VALUES (11, 'Liverpool Street station', 'City of London');
INSERT INTO Estaciones VALUES (12, 'Mill Hill East station', 'Barnet');
INSERT INTO Estaciones VALUES (13, 'Morden station', 'Merton');
INSERT INTO Estaciones VALUES (14, 'Notting Hill Gate station', 'Kensington and Chelsea');
INSERT INTO Estaciones VALUES (15, 'Oakwood station', 'Enfield');
INSERT INTO Estaciones VALUES (16, 'Oval station', 'Lambeth');
INSERT INTO Estaciones VALUES (17, 'Roding Valley station', 'Epping Forest Redbridge');
INSERT INTO Estaciones VALUES (18, 'Ruislip Gardens station', 'Hillingdon');
INSERT INTO Estaciones VALUES (19, 'South Kenton station', 'Brent');
INSERT INTO Estaciones VALUES (20, 'Woodford station', 'Redbridge');


INSERT INTO Lineas VALUES (100, 'Bakerloo Line', 6, 'naranja', 1, 2);
INSERT INTO Lineas VALUES (110, 'Central line', 3, 'rojo', 2, 3);
INSERT INTO Lineas VALUES (120, 'Circle line', 10, 'amarillo', 3, 4);
INSERT INTO Lineas VALUES (130, 'Hammersmith line', 2, 'azul', 5, 6);
INSERT INTO Lineas VALUES (140, 'Jubilee line', 12, 'negro', 7, 8);
INSERT INTO Lineas VALUES (150, 'Metropolitan line', 25, 'naranja', 9, 10);
INSERT INTO Lineas VALUES (160, 'Northern line', 1, 'negro', 11, 12);
INSERT INTO Lineas VALUES (170, 'Piccadilly line', 30, 'verde', 13, 14);
INSERT INTO Lineas VALUES (180, 'Victoria line', 16, 'azul', 15, 16);
INSERT INTO Lineas VALUES (190, 'Waterloo line', 19, 'azul', 17, 18);
INSERT INTO Lineas VALUES (200, 'Godalming line', 5, 'verde', 19, 20);
INSERT INTO Lineas VALUES (210, 'Royal line', 5, 'negro', 5,1);
INSERT INTO Lineas VALUES (220, 'Ashford line', 22, 'amarillo', 10, 1);
INSERT INTO Lineas VALUES (230, 'Gravesend line', 4, 'azul', 11, 2);
INSERT INTO Lineas VALUES (240, 'Tring line', 12, 'azul', 13, 3);
INSERT INTO Lineas VALUES (250, 'Wimbledon line', 50, 'rojo', 14, 5);
INSERT INTO Lineas VALUES (260, 'Amersham line', 11, 'naranja', 16, 3);
INSERT INTO Lineas VALUES (270, 'London Main line', 67, 'negro', 1, 2);
INSERT INTO Lineas VALUES (280, 'Bromley line', 8, 'naranja', 1, 2);
INSERT INTO Lineas VALUES (290, 'Windsor line', 45, 'verde', 1, 2);


INSERT INTO Trenes VALUES (1000, 'The Overland train', 'A', 10, 25);
INSERT INTO Trenes VALUES (1100, 'Travel train', 'B', 6, 12);
INSERT INTO Trenes VALUES (1200, 'Caledonian train', 'C', 4, 10);
INSERT INTO Trenes VALUES (1300, 'Cathedrals Express train', 'D', 25, 40);
INSERT INTO Trenes VALUES (1400, 'Clansman train', 'E', 11, 15);
INSERT INTO Trenes VALUES (1500, 'East Anglian train', 'F', 10, 25);
INSERT INTO Trenes VALUES (1600, 'Enterprise train', 'G', 5, 31);
INSERT INTO Trenes VALUES (1700, 'Fenman train', 'H', 8, 32);
INSERT INTO Trenes VALUES (1800, 'Flying Dutchman train', 'I', 4, 12);
INSERT INTO Trenes VALUES (1900, 'Hull Executive train', 'J', 2, 6);
INSERT INTO Trenes VALUES (2000, 'The Lewisman train', 'K', 4, 31);
INSERT INTO Trenes VALUES (2100, 'Night Ferry train', 'L', 2, 3);


INSERT INTO Poseen VALUES (100, 1);
INSERT INTO Poseen VALUES (110, 2);
INSERT INTO Poseen VALUES (120, 3);
INSERT INTO Poseen VALUES (130, 4);
INSERT INTO Poseen VALUES (140, 5);
INSERT INTO Poseen VALUES (150, 6);
INSERT INTO Poseen VALUES (160, 7);
INSERT INTO Poseen VALUES (170, 8);
INSERT INTO Poseen VALUES (180, 9);
INSERT INTO Poseen VALUES (190, 10);
INSERT INTO Poseen VALUES (200, 11);
INSERT INTO Poseen VALUES (210, 12);
INSERT INTO Poseen VALUES (220, 2);
INSERT INTO Poseen VALUES (230, 14);
INSERT INTO Poseen VALUES (240, 15);
INSERT INTO Poseen VALUES (250, 2);
INSERT INTO Poseen VALUES (260, 17);
INSERT INTO Poseen VALUES (270, 18);
INSERT INTO Poseen VALUES (280, 19);
INSERT INTO Poseen VALUES (290, 20);
INSERT INTO Poseen VALUES (200, 15);
INSERT INTO Poseen VALUES (100, 14);
INSERT INTO Poseen VALUES (130, 10);
INSERT INTO Poseen VALUES (100, 8);
INSERT INTO Poseen VALUES (120, 19);
INSERT INTO Poseen VALUES (250, 6);
INSERT INTO Poseen VALUES (250, 13);


INSERT INTO Pasan VALUES (1700, 110, 1, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-04-25 ', '12:15:00'));
INSERT INTO Pasan VALUES (1700, 120, 2, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-07-15 ', '15:35:00'));
INSERT INTO Pasan VALUES (1700, 130, 3, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-03-29 ', '15:30:00'));
INSERT INTO Pasan VALUES (1700, 140, 4, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-12-31 ', '05:45:00'));
INSERT INTO Pasan VALUES (1700, 150, 5, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-04-08 ', '03:00:00'));
INSERT INTO Pasan VALUES (1700, 160, 6, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-01-03 ', '12:25:00'));
INSERT INTO Pasan VALUES (1700, 170, 7, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-10-17 ', '17:25:00'));
INSERT INTO Pasan VALUES (1700, 180, 8, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-12-31 ', '15:45:00'));
INSERT INTO Pasan VALUES (1700, 190, 9, CONCAT(YEAR(DATEADD(YEAR, -2, GETDATE())), '-03-16 ', '19:25:00'));
INSERT INTO Pasan VALUES (1700, 200, 10, CONCAT(YEAR(DATEADD(YEAR, -2, GETDATE())), '-04-15 ', '12:24:00'));
INSERT INTO Pasan VALUES (1700, 210, 11, CONCAT(CONVERT(char(10), DATEADD(DAY, -180, GETDATE()),126), ' 09:45:00'));
INSERT INTO Pasan VALUES (1700, 220, 12, CONCAT(CONVERT(char(10), DATEADD(DAY, -125, GETDATE()),126), ' 04:56:00'));
INSERT INTO Pasan VALUES (1700, 230, 13, CONCAT(CONVERT(char(10), DATEADD(DAY, -100, GETDATE()),126), ' 04:45:00'));
INSERT INTO Pasan VALUES (1700, 240, 14, CONCAT(CONVERT(char(10), DATEADD(DAY, -90, GETDATE()),126), ' 13:13:00'));
INSERT INTO Pasan VALUES (1700, 250, 15, CONCAT(CONVERT(char(10), DATEADD(DAY, -89, GETDATE()),126), ' 12:21:00'));
INSERT INTO Pasan VALUES (1700, 260, 16, CONCAT(CONVERT(char(10), DATEADD(DAY, -88, GETDATE()),126), ' 16:21:00'));
INSERT INTO Pasan VALUES (1700, 270, 17, CONCAT(CONVERT(char(10), DATEADD(DAY, -79, GETDATE()),126), ' 23:45:00'));
INSERT INTO Pasan VALUES (1700, 280, 18, CONCAT(CONVERT(char(10), DATEADD(DAY, -66, GETDATE()),126), ' 22:00:00'));
INSERT INTO Pasan VALUES (1700, 290, 19, CONCAT(CONVERT(char(10), DATEADD(DAY, -56, GETDATE()),126), ' 21:00:00'));
INSERT INTO Pasan VALUES (1700, 150, 20, CONCAT(CONVERT(char(10), DATEADD(DAY, -50, GETDATE()),126), ' 20:05:00'));
INSERT INTO Pasan VALUES (1000, 150, 3, CONCAT(CONVERT(char(10), DATEADD(DAY, -45, GETDATE()),126), ' 20:07:00'));
INSERT INTO Pasan VALUES (1100, 270, 4, CONCAT(CONVERT(char(10), DATEADD(DAY, -30, GETDATE()),126), ' 21:12:00'));
INSERT INTO Pasan VALUES (1200, 250, 6, CONCAT(CONVERT(char(10), DATEADD(DAY, -26, GETDATE()),126), ' 10:45:00'));
INSERT INTO Pasan VALUES (1300, 150, 8, CONCAT(CONVERT(char(10), DATEADD(DAY, -22, GETDATE()),126), ' 10:12:00'));
INSERT INTO Pasan VALUES (1400, 150, 4, CONCAT(CONVERT(char(10), DATEADD(DAY, -22, GETDATE()),126), ' 09:12:00'));
INSERT INTO Pasan VALUES (1500, 140, 3, CONCAT(CONVERT(char(10), DATEADD(DAY, -20, GETDATE()),126), ' 05:32:00'));
INSERT INTO Pasan VALUES (1600, 190, 2, CONCAT(CONVERT(char(10), DATEADD(DAY, -15, GETDATE()),126), ' 08:33:00'));
INSERT INTO Pasan VALUES (1800, 130, 13, CONCAT(CONVERT(char(10), DATEADD(DAY, -12, GETDATE()),126), ' 09:45:00'));
INSERT INTO Pasan VALUES (1900, 290, 14, CONCAT(CONVERT(char(10), DATEADD(DAY, -6, GETDATE()),126), ' 12:00:00'));
INSERT INTO Pasan VALUES (2000, 180, 15, CONCAT(CONVERT(char(10), DATEADD(DAY, -4, GETDATE()),126), ' 12:01:00'));
INSERT INTO Pasan VALUES (1900, 170, 19, CONCAT(CONVERT(char(10), DATEADD(DAY, -4, GETDATE()),126), ' 12:59:00'));
INSERT INTO Pasan VALUES (1900, 120, 17, CONCAT(CONVERT(char(10), DATEADD(DAY, -2, GETDATE()),126), ' 01:10:00'));
INSERT INTO Pasan VALUES (1200, 250, 5, CONCAT(CONVERT(char(10), DATEADD(DAY, -1, GETDATE()),126), ' 03:13:00'));
INSERT INTO Pasan VALUES (1200, 100, 4, CONCAT(CONVERT(char(10), DATEADD(DAY, 2, GETDATE()),126), ' 03:15:00'));

