/******************************
Script SQL, consultas JOIN
Autor : David Muñoz Restrepo
Fecha: Octubre 14 de 2026

*****************************/


-- Parte 1: Usar la base de datos previamente creada para M3

USE Ventas_Tech_DB;
GO

-- Parte 2: Consulta 1, INNER JOIN, vista general
-- En esta consulta se desea visualizar de manera global todos los registros de ventas, los cuales van a incluir información de otras tablas en la base de datos, donde se detalla información relacionada con los clientes y los productos que fueron registrados en la venta.

SELECT
    v.id_venta,
    v.fecha_venta,
    v.id_cliente,
    c.nombre as nombre_cliente,
    c.email as correo_cliente,
    v.id_producto,
    p.nombre_producto,
    ca.nombre_categoria,
    v.cantidad,
    (v.cantidad * v.precio_unitario) as total_venta
FROM ventas as v
INNER JOIN clientes as c ON v.id_cliente = c.id_cliente
INNER JOIN productos as p ON v.id_producto = p.id_producto
INNER JOIN categorias as ca ON p.id_categoria = ca.id_categoria
--Nota: He aquí que hay una especie de puente de un INNER JOIN al otro. Debido a que las tablas clientes y productos no tienen ninguna PK ni FK que puedan conectarlas, se usa una tabla intermedia que contiene información que lleve de una a la otra, en este caso, es la tabla de ventas, ya que esta tiene la id_cliente y la id_producto, entonces se hace primero el INNER JOIN de clientes con ventas para mirar las id_cliente y de ahí se usa la tabla ventas para las id_producto.

--Hallazgo: Las categorías que tuvieron más ventas en las fechas indicadas hasta el momento son Computación y Accesorios, y la que menos ventas registra es Almacenamiento.
GO



--Parte 3, consulta 2, ¿Qué clientes no hay comprado nada?
--El objetivo de esta consulta es revisar si para la información consignada en la base de datos hasta ahora hay clientes que no han registrado compras, esto mediante un cruce de la información entre la tabla de clientes y la tabla de ventas usando un LEFT JOIN que va desde la tabla de clientes hasta la tabla de ventas.

SELECT
    c.nombre as nombre_cliente,
    c.email as correo_cliente,
    c.fecha_registro
FROM clientes as c
LEFT JOIN ventas as v on c.id_cliente = v.id_cliente WHERE v.id_venta IS NULL;
--Hallazgo: En esta consulta ocurre que no sale nada, esto es porque, al menos con la información en la base de datos actual, todos los clientes han comprado al menos una vez.
GO

--Parte 4, consulta 3, ¿Qué productos nunca se han vendido?
-- En esta consulta se desea ahora revisar si hay productos en la base de datos que se tiene hasta el momento que no registran ninguna venta.
SELECT
    p.id_producto,
    p.nombre_producto,
    ca.nombre_categoria,
    p.precio
FROM productos as p
INNER JOIN categorias as ca ON p.id_categoria = ca.id_categoria
LEFT JOIN ventas as v on p.id_producto = v.id_producto where v.id_venta IS NULL;
--Hallazgo: Como en la anterior consulta, resulta curioso el hecho de que tampoco sale nada en la consulta, indicando que aún no se tiene ningún producto que no se haya vendido.
GO

--Parte 5, consulta 4, ventas por canal
--Finalmente, en esta consulta se quiere, mediante condiciones en el SELECT, separar las ventas hechas en dos canales distintos, uno 'En línea' y el otro 'Presencial'. Hay muchas posibilidades para estas condiciones, pero en esta ocasión se decidió por una simple: si en una venta se registró que un cliente se llevó 3 o menos unidades, la compra se realizó en línea, esto porque, de manera imaginaria, se puede realizar de mejor manera el envío de estos productos ya que es una menor cantidad. Por otro lado, si fueron más de 3, entonces la compra se hizo de forma presencial, esto poniendo la recolecta de los productos en manos del cliente porque el envío de los mismos se dificulta un poco más.
SELECT canal, SUM(total) AS total_canal
FROM (
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Online' AS canal
    FROM ventas WHERE cantidad <= 3
    UNION ALL
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Presencial' AS canal
    FROM ventas WHERE cantidad > 3
) AS consolidado
GROUP BY canal;
--Hallazgo: Según esta consulta, y debido a la condición puesta por la consulta (y también por la tienda), las ventas en línea tienen unos valores mayores que los presenciales, quizás en este caso imaginario debido a que los clientes prefieren recibir los productos a domicilio que desplazarse personalmente por ellos.
GO