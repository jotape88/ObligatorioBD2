--a.	Mostrar los datos del/los trene/s que pasaron por �ltima vez por una l�nea-estaci�n

SELECT P.codigoEstacion, T.*
FROM Trenes T, Pasan P
WHERE T.numero = P.numeroTren AND
	  P.fechaYHora = (SELECT TOP 1 P2.fechaYHora
					  FROM Pasan P2
					  WHERE P2.codigoEstacion = P.codigoEstacion
					  ORDER BY P2.fechaYHora DESC)
ORDER BY P.codigoEstacion



--b.	Mostrar los datos de las estaciones por las que pasaron m�s trenes este 
--a�o que la cantidad promedio de trenes que pasaron en el a�o anterior.

SELECT E.codigo, E.barrio, E.descripcion, COUNT(*) as cantidadTrenes --No es solicitado, solo a modo de informacion
FROM Estaciones E, Pasan P
WHERE E.codigo = P.codigoEstacion AND 
	  YEAR(P.fechaYHora) = YEAR(GETDATE())
GROUP BY E.codigo, E.barrio, E.descripcion
HAVING COUNT(*) > (SELECT COUNT(*) / COUNT(DISTINCT P2.codigoEstacion) AS PromedioTrenes
				   FROM Pasan P2
				   WHERE YEAR(P2.fechaYHora) = YEAR(DATEADD(YEAR, -1, GETDATE())))
				

--c.	Mostrar numero de l�nea, descripci�n, nombre de la estaci�n inicio
--nombre de la estaci�n destino y cantidad de estaciones que la componen.


----------------------MAL, REPASAR
SELECT
	L.numero AS NumeroLinea,
	L.descripcion AS Descripcion,
	L.codigoEstacionOrigen,
	L.codigoEstacionDestino,
	COUNT(*) AS CantidadDeEstaciones
FROM
	LINEAS L,
	POSEEN P,
	ESTACIONES E
WHERE
	L.numero = P.numeroLinea AND
	E.codigo = P.codigoEstacion
GROUP BY
	L.numero,
	L.descripcion,
	L.codigoEstacionOrigen,
	L.codigoEstacionDestino

--------------------------------------
	

--d.	Mostrar los datos de la l�nea que recorre la distancia m�s larga
SELECT L.*
FROM Lineas L
WHERE L.longitud = (SELECT MAX(L2.longitud)
					FROM Lineas L2)


--e.	Mostrar los datos de las estaciones que est�n incluidas en l�neas de color rojo 
--pero no est�n incluidas en l�neas de color amarillo.

SELECT DISTINCT E.*
FROM Estaciones E, Lineas L, Poseen P
WHERE P.codigoEstacion = E.codigo AND 
	  P.numeroLinea = L.numero AND 
	  L.color = 'rojo' AND  
	  P.codigoEstacion NOT IN (SELECT P2.codigoEstacion
							   FROM Poseen P2, Lineas L2
			                   WHERE P2.numeroLinea = L2.numero AND 
									 L2.color = 'amarillo')


--f.	Mostrar los datos de los trenes que pasaron por todas las estaciones existentes.
SELECT T.*
FROM Trenes T
WHERE T.numero IN (SELECT P.numeroTren
				   FROM Pasan P
				   GROUP BY P.numeroTren
				   HAVING COUNT(DISTINCT P.codigoEstacion) = (SELECT COUNT (E.codigo)
													          FROM Estaciones E))
													       

--FORMA DESPROLIJA (muchos group by):

--SELECT T.*
--FROM TRENES T, PASAN P
--WHERE T.numero = P.numeroTren
--GROUP BY T.numero, T.descripcion, T.letra, T.capacVagon, T.cantVagon
--HAVING COUNT(DISTINCT P.codigoEstacion) = (SELECT COUNT (E.codigo)
--										     FROM ESTACIONES E)



