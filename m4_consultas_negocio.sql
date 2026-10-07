USE Ventas_Tech_DB;
GO

-- Resumen ejecutivo mensual, consulta 1 --

SELECT MONTH(fecha_venta) AS mes,
COUNT(*) AS cantidad_pedidos,
SUM(cantidad * precio_unitario) AS total_facturado,
AVG (cantidad * precio_unitario) AS ticket_promedio 
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes ASC;

GO

-- Top 5 de productos, consulta 2 --

SELECT TOP 5
id_producto AS producto,
SUM(cantidad) AS productos_vendidos,
SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;


GO

-- Clientes recurrentes, consulta 3 --

SELECT id_cliente AS cliente,
COUNT(*) AS pedidos_totales,
SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

GO

-- Rendimientos mensuales encima y debajo del promedio, consulta 4 --


SELECT MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unitario) AS total_facturado_mes,
    CASE
        WHEN SUM(cantidad * precio_unitario) >= (
            SELECT AVG(total_facturado_mes) 
                FROM(
                    SELECT SUM(cantidad * precio_unitario) AS total_facturado_mes
                    FROM ventas
                    GROUP BY MONTH(fecha_venta))
            AS promedio_total_mensual
        ) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_mensual
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes ASC;

GO

-- Hallazgos hasta lo que se ha hecho --
-- 1. Aún solo se tienen ventas de un mes, por lo que la información es poca, y la última consulta arroja que el mes estuvo por encima, a pesar de que no hay ningún otro mes en el cual comparar. Esta consulta debería probarse al tener más meses. --
-- 2. Todos los clientes que han comprado más de una vez han comprado exactamente dos veces, y también hay un gran margen de los dos que encabezan la lista de gastos sobre los demás. --
-- 3. Según las ventas del mes 3, se generó mucho más vendiendo en menos cantidad los productos con mayor costo unitario que en más cantidad los productos de menor costo unitario, y en este caso, para los valores de venta registrados, la diferencia fue significativa. --