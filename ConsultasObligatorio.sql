--a.	Mostrar los datos del/los trene/s que pasaron por última vez por una línea-estación

SELECT P.codigoEstacion, T.*
FROM Trenes T, Pasan P
WHERE T.numero = P.numeroTren AND
	  P.fechaYHora = (SELECT TOP 1 P2.fechaYHora
					  FROM Pasan P2
					  WHERE P2.codigoEstacion = P.codigoEstacion
					  ORDER BY P2.fechaYHora DESC)
ORDER BY P.codigoEstacion



--b.	Mostrar los datos de las estaciones por las que pasaron más trenes este 
--año que la cantidad promedio de trenes que pasaron en el año anterior.

SELECT E.codigo, E.barrio, E.descripcion, COUNT(*) as CantidadTrenes --No es solicitado, solo a modo de informacion
FROM Estaciones E, Pasan P
WHERE E.codigo = P.codigoEstacion AND 
	  YEAR(P.fechaYHora) = YEAR(GETDATE())
GROUP BY E.codigo, E.barrio, E.descripcion
HAVING COUNT(*) > (SELECT COUNT(*) / COUNT(DISTINCT P2.codigoEstacion) AS PromedioTrenes
				   FROM Pasan P2
				   WHERE YEAR(P2.fechaYHora) = YEAR(DATEADD(YEAR, -1, GETDATE())))

--Version Corregida
SELECT E.codigo, E.barrio, E.descripcion, COUNT(*) as CantidadTrenes --No es solicitado, solo a modo de informacion
FROM Estaciones E, Pasan P
WHERE E.codigo = P.codigoEstacion AND 
	  YEAR(P.fechaYHora) = YEAR(GETDATE())
GROUP BY E.codigo, E.barrio, E.descripcion
HAVING COUNT(*) > (SELECT AVG(miTabla.Cantidad)
				   FROM (SELECT P2.CodigoEstacion, COUNT(*) AS Cantidad
				         FROM Pasan P2
						 WHERE YEAR(P2.fechaYHora) = YEAR(DATEADD(YEAR, -1, GETDATE()))
						 GROUP BY p2.codigoEstacion) miTabla)
				   
--c.	Mostrar numero de línea, descripción, nombre de la estación inicio
--nombre de la estación destino y cantidad de estaciones que la componen.

SELECT
	L.numero AS NumeroLinea,
	L.descripcion AS Descripcion,
	E.descripcion AS EstacionOrigen,
	E2.descripcion AS EstacionDestino,
	COUNT(*) AS CantidadDeEstaciones
FROM
	LINEAS L,
	Lineas L2,
	POSEEN P,
	ESTACIONES E,
	ESTACIONES E2
WHERE
	L.numero = P.numeroLinea AND
	L2.numero = P.numeroLinea AND
	L.codigoEstacionOrigen = E.codigo AND
	L2.codigoEstacionDestino = E2.codigo
GROUP BY
	L.numero,
	L.descripcion,
	E.descripcion,
	E2.descripcion

--------------------------------------
	

--d.	Mostrar los datos de la línea que recorre la distancia más larga
SELECT L.*
FROM Lineas L
WHERE L.longitud = (SELECT MAX(L2.longitud)
					FROM Lineas L2)


--e.	Mostrar los datos de las estaciones que están incluidas en líneas de color rojo 
--pero no están incluidas en líneas de color amarillo.

SELECT E.*
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
													       
--OTRA forma (muchos group by):

--SELECT T.*
--FROM TRENES T, PASAN P
--WHERE T.numero = P.numeroTren
--GROUP BY T.numero, T.descripcion, T.letra, T.capacVagon, T.cantVagon
--HAVING COUNT(DISTINCT P.codigoEstacion) = (SELECT COUNT (E.codigo)
--										     FROM ESTACIONES E)



