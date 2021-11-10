USE ObligatorioBD2N3A
GO
--------------------------------------------------------------------------------------------------------------------------
/*a. Implementar un procedimiento que reciba una línea y una estación y cambie la 
estación destino de dicha línea por la estación que se recibe como parámetro, en caso 
que la estación recibida ya sea el destino de la línea, se debe retornar un parámetro 
con un valor mayor a 0, de otro modo retornar 0 */
CREATE PROCEDURE SP_EjercicioA
@numeroLinea INT, @codigoEstacionDestino INT, @retorno INT OUTPUT
AS
BEGIN

DECLARE @esDestino INT

SELECT @esDestino=COUNT(*)
FROM Lineas L
WHERE L.numero = @numeroLinea AND 
      L.codigoEstacionDestino = @codigoEstacionDestino  

IF @esDestino = 0
	BEGIN
		UPDATE Lineas
		SET codigoEstacionDestino = @codigoEstacionDestino
		WHERE numero = @numeroLinea
		SET @retorno = 0
	END
ELSE
	SET @retorno = 1
END

---------Consultas y datos de prueba---------
DECLARE @retornoEj1 INT
EXECUTE SP_EjercicioA 100, 20, @retornoEj1 OUTPUT
PRINT @retornoEj1

select * from Estaciones
select * from Lineas


--------------------------------------------------------------------------------------------------------------------------
/*b. Mediante una función, dado un rango de fechas, 
retornar el nombre de la estación por la que pasaron más trenes en dicho rango.*/
GO
CREATE FUNCTION SF_EjercicioB(@fechaYHoraInicial DATETIME, @fechaYHoraFinal DATETIME)
	RETURNS VARCHAR(60)
AS
BEGIN
DECLARE @retorno VARCHAR(60)

SELECT @retorno = E.descripcion
FROM Pasan P, Estaciones E
WHERE P.codigoEstacion = E.codigo AND
	  P.fechaYHora >= @fechaYHoraInicial AND
	  P.fechaYHora <= @fechaYHoraFinal
GROUP BY E.codigo, E.descripcion
HAVING COUNT(*) = (SELECT MAX(miTabla.CtdTrenes)
				   FROM (SELECT COUNT(*) AS CtdTrenes
				         FROM Pasan P, Estaciones E
						 WHERE P.codigoEstacion = E.codigo AND
							   P.fechaYHora >= @fechaYHoraInicial AND
	                           P.fechaYHora <= @fechaYHoraFinal
					     GROUP BY E.codigo, E.descripcion) miTabla)
RETURN @retorno

END
GO

---------Consultas y datos de prueba---------
SELECT dbo.SF_EjercicioB ('2020-01-01', '2021-06-06') AS 'Nombre de Estacion' --> Debe devolver barons court station
SELECT dbo.SF_EjercicioB (DATEADD(DAY, -12, GETDATE()), GETDATE()) AS 'Nombre de Estacion' --> Debe devolver bow road station

select * from Pasan

--La cantidad de trenes que pasan por todas las estaciones s/fecha
SELECT E.codigo AS CodigoEstacion, E.descripcion, COUNT(*) AS CantidadTrenes
FROM Pasan P, Estaciones E
WHERE P.codigoEstacion = E.codigo AND p.fechaYHora >= '' AND p.fechaYHora <= ''
GROUP BY E.codigo, E.descripcion