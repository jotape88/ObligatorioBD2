CREATE DATABASE ObligatorioBD2N3A
GO

USE ObligatorioBD2N3A
GO


CREATE TABLE ESTACIONES (
	codigo INT NOT NULL,
	descripcion VARCHAR(60),
	barrio VARCHAR(25),
	CONSTRAINT PK_ESTACIONES PRIMARY KEY (codigo)
);

CREATE TABLE LINEAS (
	numero INT NOT NULL,
	descripcion VARCHAR(60),
	longitud VARCHAR(10),
	color VARCHAR(20),
	codigoEstacionOrigen INT,
	codigoEstacionDestino INT
	CONSTRAINT PK_LINEAS PRIMARY KEY (numero),
	CONSTRAINT FK_LINEAS_ESTACIONES_ORIGEN FOREIGN KEY (codigoEstacionOrigen) REFERENCES ESTACIONES (codigo),
	CONSTRAINT FK_LINEAS_ESTACIONES_DESTINO FOREIGN KEY (codigoEstacionDestino) REFERENCES ESTACIONES (codigo),
	CONSTRAINT CK_LINEAS_LONGITUD CHECK (longitud >= 1),
	CONSTRAINT CK_LINEAS_COLOR CHECK (color IN ('rojo', 'azul', 'amarillo', 'naranja', 'verde', 'negro'))
);

CREATE TABLE TRENES (
	numero INT NOT NULL,
	descripcion VARCHAR(60),
	letra CHAR(1),
	cantVagon INT,
	capacVagon INT,
	CONSTRAINT PK_TRENES PRIMARY KEY (numero),
	CONSTRAINT UK_TRENES_LETRA UNIQUE (letra),
	CONSTRAINT CK_TRENES_CAPACVAGON CHECK (capacVagon <= 40)
);


CREATE TABLE POSEEN(
	numeroLinea INT NOT NULL,
	codigoEstacion INT NOT NULL,
	CONSTRAINT PK_POSEEN PRIMARY KEY (numeroLinea, codigoEstacion),
	CONSTRAINT FK_POSEEN_LINEAS_NUMLINEA FOREIGN KEY (numeroLinea) REFERENCES LINEAS (numero),
	CONSTRAINT FK_POSEEN_ESTACIONES_CODESTACION FOREIGN KEY (codigoEstacion) REFERENCES ESTACIONES (codigo),
);


CREATE TABLE PASAN (
	numeroTren INT NOT NULL,
	numeroLinea INT NOT NULL,
	codigoEstacion INT NOT NULL,
	fechaYHora DATETIME NOT NULL,
	CONSTRAINT PK_PASAN PRIMARY KEY (numeroTren, numeroLinea, codigoEstacion, fechaYHora),
	CONSTRAINT FK_PASAN_TRENES_NUMTREN FOREIGN KEY (numeroTren) REFERENCES TRENES (numero),
	CONSTRAINT FK_PASAN_LINEAS_NUMLINEA FOREIGN KEY (numeroLinea) REFERENCES LINEAS (numero),
	CONSTRAINT FK_PASAN_ESTACIONES_CODESTACION FOREIGN KEY (codigoEstacion) REFERENCES ESTACIONES (codigo),
);


INSERT INTO ESTACIONES VALUES (1, 'Acton Town station', 'Ealing');
INSERT INTO ESTACIONES VALUES (2, 'Archway station', 'Islington');
INSERT INTO ESTACIONES VALUES (3, 'Baker Street station', 'City of Westminster');
INSERT INTO ESTACIONES VALUES (4, 'Barons Court station', 'Hammersmith and Fulham');
INSERT INTO ESTACIONES VALUES (5, 'Bow Road station', 'Tower Hamlets');
INSERT INTO ESTACIONES VALUES (6, 'Cannon Street station', 'City of London');
INSERT INTO ESTACIONES VALUES (7, 'East Ham station', 'Newham');
INSERT INTO ESTACIONES VALUES (8, 'Highgate station', 'Haringey');
INSERT INTO ESTACIONES VALUES (9, 'Kennington station', 'Southwark');
INSERT INTO ESTACIONES VALUES (10, 'Leyton station', 'Waltham Forest');
INSERT INTO ESTACIONES VALUES (11, 'Liverpool Street station', 'City of London');
INSERT INTO ESTACIONES VALUES (12, 'Mill Hill East station', 'Barnet');
INSERT INTO ESTACIONES VALUES (13, 'Morden station', 'Merton');
INSERT INTO ESTACIONES VALUES (14, 'Notting Hill Gate station', 'Kensington and Chelsea');
INSERT INTO ESTACIONES VALUES (15, 'Oakwood station', 'Enfield');
INSERT INTO ESTACIONES VALUES (16, 'Oval Station station', 'Lambeth');
INSERT INTO ESTACIONES VALUES (17, 'Roding Valley station', 'Epping Forest Redbridge');
INSERT INTO ESTACIONES VALUES (18, 'Ruislip Gardens station', 'Hillingdon');
INSERT INTO ESTACIONES VALUES (19, 'South Kenton station', 'Brent');
INSERT INTO ESTACIONES VALUES (20, 'Woodford station', 'Redbridge');


INSERT INTO LINEAS VALUES (100, 'Bakerloo Line', 6, 'naranja', 1, 2);
INSERT INTO LINEAS VALUES (110, 'Central line', 3, 'rojo', 2, 3);
INSERT INTO LINEAS VALUES (120, 'Circle line', 10, 'amarillo', 3, 4);
INSERT INTO LINEAS VALUES (130, 'Hammersmith line', 2, 'azul', 5, 6);
INSERT INTO LINEAS VALUES (140, 'Jubilee line', 12, 'negro', 7, 8);
INSERT INTO LINEAS VALUES (150, 'Metropolitan line', 25, 'naranja', 9, 10);
INSERT INTO LINEAS VALUES (160, 'Northern line', 1, 'negro', 11, 12);
INSERT INTO LINEAS VALUES (170, 'Piccadilly line', 30, 'verde', 13, 14);
INSERT INTO LINEAS VALUES (180, 'Victoria line', 16, 'azul', 15, 16);
INSERT INTO LINEAS VALUES (190, 'Waterloo line', 19, 'azul', 17, 18);
INSERT INTO LINEAS VALUES (200, 'Godalming line', 5, 'verde', 19, 20);
INSERT INTO LINEAS VALUES (210, 'Royal line', 5, 'negro', 5,1);
INSERT INTO LINEAS VALUES (220, 'Ashford line', 22, 'amarillo', 10, 1);
INSERT INTO LINEAS VALUES (230, 'Gravesend line', 4, 'azul', 11, 2);
INSERT INTO LINEAS VALUES (240, 'Tring line', 12, 'azul', 13, 3);
INSERT INTO LINEAS VALUES (250, 'Wimbledon line', 50, 'rojo', 14, 5);
INSERT INTO LINEAS VALUES (260, 'Amersham line', 11, 'naranja', 16, 3);
INSERT INTO LINEAS VALUES (270, 'London Main line', 67, 'negro', 1, 2);
INSERT INTO LINEAS VALUES (280, 'Bromley line', 8, 'naranja', 1, 2);
INSERT INTO LINEAS VALUES (290, 'Windsor line', 45, 'verde', 1, 2);


INSERT INTO TRENES VALUES (1000, 'The Overland train', 'A', 10, 25);
INSERT INTO TRENES VALUES (1100, 'Travel train', 'B', 6, 12);
INSERT INTO TRENES VALUES (1200, 'Caledonian train', 'C', 4, 10);
INSERT INTO TRENES VALUES (1300, 'Cathedrals Express train', 'D', 25, 40);
INSERT INTO TRENES VALUES (1400, 'Clansman train', 'E', 11, 15);
INSERT INTO TRENES VALUES (1500, 'East Anglian train', 'F', 10, 25);
INSERT INTO TRENES VALUES (1600, 'Enterprise train', 'G', 5, 31);
INSERT INTO TRENES VALUES (1700, 'Fenman train', 'H', 8, 32);
INSERT INTO TRENES VALUES (1800, 'Flying Dutchman train', 'I', 4, 12);
INSERT INTO TRENES VALUES (1900, 'Hull Executive train', 'J', 2, 6);
INSERT INTO TRENES VALUES (2000, 'The Lewisman train', 'K', 4, 31);
INSERT INTO TRENES VALUES (2100, 'Night Ferry train', 'L', 2, 3);


INSERT INTO POSEEN VALUES (100, 1);
INSERT INTO POSEEN VALUES (110, 2);
INSERT INTO POSEEN VALUES (120, 3);
INSERT INTO POSEEN VALUES (130, 4);
INSERT INTO POSEEN VALUES (140, 5);
INSERT INTO POSEEN VALUES (150, 6);
INSERT INTO POSEEN VALUES (160, 7);
INSERT INTO POSEEN VALUES (170, 8);
INSERT INTO POSEEN VALUES (180, 9);
INSERT INTO POSEEN VALUES (190, 10);
INSERT INTO POSEEN VALUES (200, 11);
INSERT INTO POSEEN VALUES (210, 12);
INSERT INTO POSEEN VALUES (220, 13);
INSERT INTO POSEEN VALUES (230, 14);
INSERT INTO POSEEN VALUES (240, 15);
INSERT INTO POSEEN VALUES (250, 16);
INSERT INTO POSEEN VALUES (260, 17);
INSERT INTO POSEEN VALUES (270, 18);
INSERT INTO POSEEN VALUES (280, 19);
INSERT INTO POSEEN VALUES (290, 20);
INSERT INTO POSEEN VALUES (200, 15);--
INSERT INTO POSEEN VALUES (100, 14);--
INSERT INTO POSEEN VALUES (130, 10);--
INSERT INTO POSEEN VALUES (100, 8);--
INSERT INTO POSEEN VALUES (120, 19);--


INSERT INTO PASAN VALUES (1000, 110, 1, CONVERT (char(19), DATEADD(DAY, -360, GETDATE()),126));
INSERT INTO PASAN VALUES (1100, 120, 1, CONVERT (char(19), DATEADD(DAY, -300, GETDATE()),126));
INSERT INTO PASAN VALUES (1200, 130, 1, CONVERT (char(19), DATEADD(DAY, -250, GETDATE()),126));
INSERT INTO PASAN VALUES (1300, 140, 1, CONVERT (char(19), DATEADD(DAY, -220, GETDATE()),126));
INSERT INTO PASAN VALUES (1400, 150, 1, CONVERT (char(19), DATEADD(DAY, -200, GETDATE()),126));
INSERT INTO PASAN VALUES (1500, 160, 1, CONVERT (char(19), DATEADD(DAY, -180, GETDATE()),126));
INSERT INTO PASAN VALUES (1600, 170, 1, CONVERT (char(19), DATEADD(DAY, -160, GETDATE()),126));
INSERT INTO PASAN VALUES (1700, 180, 1, CONVERT (char(19), DATEADD(DAY, -140, GETDATE()),126));
INSERT INTO PASAN VALUES (1800, 190, 1, CONVERT (char(19), DATEADD(DAY, -110, GETDATE()),126));
INSERT INTO PASAN VALUES (1900, 200, 1, CONVERT (char(19), DATEADD(DAY, -80, GETDATE()),126));
INSERT INTO PASAN VALUES (2000, 210, 1, CONVERT (char(19), DATEADD(DAY, -50, GETDATE()),126));
INSERT INTO PASAN VALUES (2100, 220, 1, CONVERT (char(19), DATEADD(DAY, -40, GETDATE()),126));
INSERT INTO PASAN VALUES (1100, 230, 1, CONVERT (char(19), DATEADD(DAY, -20, GETDATE()),126));
INSERT INTO PASAN VALUES (1500, 240, 1, CONVERT (char(19), DATEADD(DAY, -15, GETDATE()),126));
INSERT INTO PASAN VALUES (1600, 250, 1, CONVERT (char(19), DATEADD(DAY, -10, GETDATE()),126));
INSERT INTO PASAN VALUES (2000, 260, 1, CONVERT (char(19), DATEADD(DAY, -1, GETDATE()),126));
INSERT INTO PASAN VALUES (2100, 270, 1, CONVERT (char(19), DATEADD(DAY, 1, GETDATE()),126));
INSERT INTO PASAN VALUES (1700, 280, 1, CONVERT (char(19), DATEADD(DAY, 10, GETDATE()),126));
INSERT INTO PASAN VALUES (1900, 290, 1, CONVERT (char(19), DATEADD(DAY, 25, GETDATE()),126));
INSERT INTO PASAN VALUES (1800, 150, 1, CONVERT (char(19), DATEADD(YEAR, -2, GETDATE()),126));

