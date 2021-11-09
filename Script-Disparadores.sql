USE ObligatorioBD2N3A
GO
--------------------------------------------------------------------------------------------------------------------------
/* a. Auditar cualquier movimiento que exista en las Lineas, se debe llevar un registro detallado de las 
inserciones, modificaciones y borrados, en todos los casos registrar desde que PC se hacen los movimientos,
la fecha y la hora, el usuario y todos los datos que permitan una correcta auditoria 
(si son modificaciones que datos se modificaron, que datos había antes, que datos hay ahora, etc). 
La/s estructura/s necesaria para este punto es libre y queda a criterio del alumno. */

--Tabla de auditoria
GO
CREATE TABLE AuditarLineas (idAudit INT IDENTITY NOT NULL PRIMARY KEY,
							pc_direccion varchar(40), 
							usuario varchar(40),
							fecha_hora datetime,
                            numero INT NOT NULL,
							descripcion VARCHAR(60),
							descripcionNueva VARCHAR(60),
							longitud DECIMAL,
							longitudNueva DECIMAL,
							color VARCHAR(20),
							colorNuevo VARCHAR(20),
							codigoEstacionOrigen INT,
							codigoEstacionOrigenNuevo INT,
							codigoEstacionDestino INT,
							codigoEstacionDestinoNuevo INT,
							observacion VARCHAR(100))
GO							
--Trigger
CREATE TRIGGER trg_AuditaLinea
ON Lineas
AFTER insert, delete, update
AS
BEGIN

IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
/* INSERT */
  insert into AuditarLineas (pc_direccion,usuario, fecha_hora, numero, descripcion, longitud, color, codigoEstacionOrigen, codigoEstacionDestino, observacion) SELECT HOST_NAME(), USER_NAME(),getdate(),i.numero,i.descripcion,i.longitud,i.color,i.codigoEstacionOrigen,i.codigoEstacionDestino, 'Se creó una nueva Línea'
                           FROM inserted i

IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
/* DELETED */
  insert into AuditarLineas (pc_direccion,usuario, fecha_hora, numero, descripcion, longitud, color, codigoEstacionOrigen, codigoEstacionDestino, observacion) SELECT HOST_NAME(),USER_NAME(),getdate(),d.numero,d.descripcion,d.longitud,d.color,d.codigoEstacionOrigen,d.codigoEstacionDestino, 'Se ha borrado una Línea'
                           FROM  deleted d


IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
/* UPDATE */

IF UPDATE(descripcion)
  insert into AuditarLineas (pc_direccion,usuario, fecha_hora, numero, descripcion, descripcionNueva, longitud, color, codigoEstacionOrigen, codigoEstacionDestino, observacion) SELECT HOST_NAME(),USER_NAME(),getdate(),d.numero,d.descripcion, i.descripcion, d.longitud,d.color,d.codigoEstacionOrigen,d.codigoEstacionDestino, 'Se modificó la descripción'
                           FROM inserted i, deleted d
						   WHERE i.numero=d.numero							   
IF UPDATE(longitud)
  insert into AuditarLineas (pc_direccion,usuario, fecha_hora, numero, descripcion, longitud, longitudNueva, color, codigoEstacionOrigen, codigoEstacionDestino, observacion) SELECT HOST_NAME(),USER_NAME(),getdate(),d.numero,d.descripcion, d.longitud, i.longitud , d.color,d.codigoEstacionOrigen,d.codigoEstacionDestino, 'Se modificó la longitud'
                           FROM inserted i, deleted d
						   WHERE i.numero=d.numero
IF UPDATE(color)
  insert into AuditarLineas (pc_direccion,usuario, fecha_hora, numero, descripcion, longitud, color, colorNuevo, codigoEstacionOrigen, codigoEstacionDestino, observacion) SELECT HOST_NAME(),USER_NAME(),getdate(),d.numero,d.descripcion,d.longitud,d.color,i.color, d.codigoEstacionOrigen,d.codigoEstacionDestino, 'Se modificó el color'
                           FROM inserted i, deleted d
						   WHERE i.numero=d.numero
IF UPDATE(codigoEstacionOrigen)
  insert into AuditarLineas (pc_direccion,usuario, fecha_hora, numero, descripcion, longitud, color, codigoEstacionOrigen, codigoEstacionOrigenNuevo, codigoEstacionDestino, observacion) SELECT HOST_NAME(),USER_NAME(),getdate(),d.numero,d.descripcion,d.longitud,d.color,d.codigoEstacionOrigen,i.codigoEstacionOrigen,d.codigoEstacionDestino, 'Se modificó la estación de origen'
                           FROM inserted i, deleted d
						   WHERE i.numero=d.numero
IF UPDATE(codigoEstacionDestino)
  insert into AuditarLineas  (pc_direccion,usuario, fecha_hora, numero, descripcion, longitud, color, codigoEstacionOrigen, codigoEstacionDestino, codigoEstacionDestinoNuevo, observacion) SELECT HOST_NAME(),USER_NAME(),getdate(),d.numero,d.descripcion,d.longitud,d.color,d.codigoEstacionOrigen,d.codigoEstacionDestino, i.codigoEstacionDestino, 'Se modificó la estación de destino'
                           FROM inserted i, deleted d
						   WHERE i.numero=d.numero

END

---------Consultas y datos de prueba---------
select * from AuditarLineas
select * from Lineas

delete from AuditarLineas

drop table AuditarLineas
drop trigger trg_AuditaLinea

INSERT INTO Lineas VALUES (300, 'NuevaLinea1', 6, 'naranja', 5, 10);
INSERT INTO Lineas VALUES (310, 'NuevaLinea3', 8, 'naranja', 6, 7);
INSERT INTO Lineas VALUES (320, 'NuevaLinea2', 9, 'naranja', 7, 2);

UPDATE Lineas SET descripcion='***Descripción Modificada***' WHERE numero=310
UPDATE Lineas SET codigoEstacionOrigen=5 WHERE numero=110
UPDATE Lineas SET longitud=45 WHERE numero=120
UPDATE Lineas SET color='negro' WHERE numero=120 

DELETE FROM Lineas WHERE numero=300
DELETE FROM Lineas WHERE numero=310
DELETE FROM Lineas WHERE numero=320


--------------------------------------------------------------------------------------------------------------------------

/* b. Cada vez que un tren pasa por una estación se debe llevar un registro del acumulado de 
trenes que pasaron por dicha estación, quizá deba crear un campo acumulado para que este punto pueda ser 
realizado. */

--Tabla de auditoria
GO
CREATE TABLE AuditarPasajes(idAudit INT IDENTITY NOT NULL PRIMARY KEY,
							codigoEstacion INT UNIQUE,
							contadorTrenes INT)

GO
--Trigger
CREATE TRIGGER Trg_AuditaPasaje
ON Pasan
AFTER INSERT
AS
BEGIN

IF NOT EXISTS(SELECT A.codigoEstacion
	      FROM AuditarPasajes A, inserted I
		  WHERE A.codigoEstacion = I.codigoEstacion)

		  INSERT INTO AuditarPasajes (codigoEstacion, contadorTrenes) SELECT i.codigoEstacion, 1
																	  FROM inserted i, Pasan p
																	  WHERE P.id = I.id

ELSE

UPDATE AuditarPasajes
SET contadorTrenes = contadorTrenes+1						
WHERE codigoEstacion IN (SELECT i.codigoEstacion
						 FROM inserted i
						 WHERE codigoEstacion = I.codigoEstacion)

END

---------Consultas y datos de prueba---------
select * from AuditarPasajes
select * from Pasan

delete from AuditarPasajes

drop table AuditarPasajes
drop trigger Trg_AuditaPasaje

INSERT INTO Pasan VALUES (1900, 130, 1, CONCAT(YEAR(DATEADD(YEAR, -2, GETDATE())), '-03-16 ', '19:25:00'));
INSERT INTO Pasan VALUES (2000, 140, 1, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-03-16 ', '19:25:00'));
INSERT INTO Pasan VALUES (1500, 150, 1, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-03-16 ', '19:25:00'));
INSERT INTO Pasan VALUES (1300, 190, 1, CONCAT(YEAR(DATEADD(YEAR, -2, GETDATE())), '-03-16 ', '19:25:00'));
INSERT INTO Pasan VALUES (1600, 160, 2, CONCAT(YEAR(DATEADD(YEAR, -1, GETDATE())), '-03-16 ', '19:25:00'));
INSERT INTO Pasan VALUES (1700, 170, 2, CONCAT(YEAR(DATEADD(YEAR, -2, GETDATE())), '-03-16 ', '19:25:00'));
INSERT INTO Pasan VALUES (1800, 130, 3, CONCAT(YEAR(DATEADD(YEAR, -2, GETDATE())), '-03-16 ', '19:25:00'));
INSERT INTO Pasan VALUES (1900, 130, 3, CONCAT(YEAR(DATEADD(YEAR, -2, GETDATE())), '-03-16 ', '19:25:00'));
INSERT INTO Pasan VALUES (1100, 130, 5, CONCAT(YEAR(DATEADD(YEAR, -2, GETDATE())), '-03-16 ', '19:25:00'));
INSERT INTO Pasan VALUES (1200, 170, 6, CONCAT(YEAR(DATEADD(YEAR, -2, GETDATE())), '-03-16 ', '19:25:00'));
INSERT INTO Pasan VALUES (1800, 180, 6, CONCAT(YEAR(DATEADD(YEAR, -2, GETDATE())), '-03-16 ', '19:25:00'));
INSERT INTO Pasan VALUES (1000, 110, 6, CONCAT(YEAR(DATEADD(YEAR, -2, GETDATE())), '-03-16 ', '19:25:00'));
INSERT INTO Pasan VALUES (1100, 110, 18, CONCAT(YEAR(DATEADD(YEAR, -2, GETDATE())), '-03-16 ', '19:25:00'));
INSERT INTO Pasan VALUES (1900, 110, 18, CONCAT(YEAR(DATEADD(YEAR, -2, GETDATE())), '-03-16 ', '19:25:00'));
INSERT INTO Pasan VALUES (2000, 110, 20, CONCAT(YEAR(DATEADD(YEAR, -2, GETDATE())), '-03-16 ', '19:25:00'));