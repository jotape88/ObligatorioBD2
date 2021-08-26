--a.	Mostrar los datos del/los trene/s que pasaron por �ltima vez por una l�nea-estaci�n
SELECT
	P.codigoEstacion,
	T.*
FROM
	TRENES T,
	PASAN P
WHERE
	T.numero = P.numeroTren AND
	P.fechaYHora = (SELECT TOP 1
						P2.fechaYHora
					FROM
						PASAN P2
					WHERE
						P2.codigoEstacion = P.codigoEstacion
					ORDER BY
						P2.fechaYHora DESC)
ORDER BY
	P.codigoEstacion


--b.	Mostrar los datos de las estaciones por las que pasaron m�s trenes este 
--a�o que la cantidad promedio de trenes que pasaron en el a�o anterior.
SELECT
	E.codigo as codigoestacion,
	COUNT(P.numeroTren) as cantidadTrenes
FROM
	ESTACIONES E,
	PASAN P
WHERE
	E.codigo = P.codigoEstacion AND
	YEAR(P.fechaYHora) = YEAR(GETDATE())
GROUP BY
	E.codigo
HAVING
	COUNT(P.numeroTren) > (SELECT
								E2.codigo,
								COUNT(P2.numeroTren)
							FROM
								PASAN P2,
								ESTACIONES E2
							WHERE
								E2.codigo = p2.codigoEstacion AND
								YEAR(P2.fechaYHora) = '2021'
							GROUP BY
								E2.codigo
							
									)



--c.	Mostrar numero de l�nea, descripci�n, nombre de la estaci�n inicio
--nombre de la estaci�n destino y cantidad de estaciones que la componen.
SELECT
	L.numero AS NumeroLinea,
	L.descripcion AS Descripcion,
	L.codigoEstacionOrigen,
	L.codigoEstacionDestino,
	COUNT(P.codigoEstacion) AS CantidadDeEstaciones
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


	
	

--d.	Mostrar los datos de la l�nea que recorre la distancia m�s larga
SELECT
	L.*
FROM
	LINEAS L
WHERE
	L.longitud = (SELECT
						MAX(L2.LONGITUD)
					FROM
						LINEAS L2)


--e.	Mostrar los datos de las estaciones que est�n incluidas en l�neas de color rojo 
--pero no est�n incluidas en l�neas de color amarillo.
SELECT
	DISTINCT E.*
FROM
	ESTACIONES E,
	LINEAS L,
	POSEEN P
WHERE
	P.codigoEstacion = E.codigo AND
	P.numeroLinea = L.numero AND
	L.color = 'rojo' AND 
	P.codigoEstacion NOT IN (SELECT
								P2.codigoEstacion
							 FROM
								POSEEN P2,
								LINEAS L2
							  WHERE
								P2.numeroLinea = L2.numero AND
								L2.color = 'amarillo')


--f.	Mostrar los datos de los trenes que pasaron por todas las estaciones existentes.
SELECT
	T.*
FROM
	TRENES T
WHERE
	T.numero IN (SELECT
					P.numeroTren
				 FROM
					PASAN P
				 GROUP BY
					P.numeroTren
				 HAVING
					COUNT(DISTINCT P.codigoEstacion) = (SELECT
													       COUNT (E.codigo)
													    FROM
													       ESTACIONES E))
													     

--FORMA DESPROLIJA (muchos group by):

--SELECT
--	T.*
--FROM
--	TRENES T,
--	PASAN P
--WHERE
--	T.numero = P.numeroTren
--GROUP BY
--	T.numero,
--	T.descripcion,
--	T.letra,
--	T.capacVagon,
--	T.cantVagon
--HAVING
--	COUNT(DISTINCT P.codigoEstacion) = (SELECT
--											COUNT (E.codigo)
--										FROM
--											ESTACIONES E)


