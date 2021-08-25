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
	CONSTRAINT CK_LINEAS_LONGITUD CHECK (longitud < 1),
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
INSERT INTO LINEAS VALUES (260, 'Bromley line', 8, 'naranja', 1, 2);
INSERT INTO LINEAS VALUES (270, 'Windsor line', 45, 'verde', 1, 2);


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

INSERT INTO TRENES VALUES (1000, 'The Overland train', 'A', 10, 25);
INSERT INTO TRENES VALUES (1100, 'Travel train', 'B', 6, 12);
INSERT INTO TRENES VALUES (1200, 'Caledonian train', 'C', 4, 10);
INSERT INTO TRENES VALUES (1300, 'Cathedrals Express Train', 'D', 25, 40);
INSERT INTO TRENES VALUES (1400, 'Clansman Train', 'E', 11, 15);
INSERT INTO TRENES VALUES (1500, 'East Anglian Train', 'A', 10, 25);
INSERT INTO TRENES VALUES (1600, 'Enterprise train', 'A', 10, 25);
INSERT INTO TRENES VALUES (1700, 'The Overland', 'A', 10, 25);
INSERT INTO TRENES VALUES (1800, 'The Overland', 'A', 10, 25);
INSERT INTO TRENES VALUES (1900, 'The Overland', 'A', 10, 25);
INSERT INTO TRENES VALUES (2000, 'The Overland', 'A', 10, 25);
INSERT INTO TRENES VALUES (2100, 'The Overland', 'A', 10, 25);
