/**************************
BodegaTech — Script de Inventario
Autor: David Muñoz Restrepo
Fecha: 24/09/2026
*****************************/


--Sección DDL--

CREATE DATABASE practice_2;

USE practice_2;

DROP TABLE IF EXISTS inventario;

CREATE TABLE inventario(
    id_producto int identity(1,1), PRIMARY KEY NOT NULL,
    nombre_producto varchar(100) NOT NULL,
    categoria varchar(50) NOT NULL,
    precio_unitario decimal(10,2) NOT NULL,
    stock_actual int NOT NULL,
    stock_minimo int NOT NULL,
    fecha_ingreso date NOT NULL,
    activo bit NOT NULL
)

--Sección DML--

INSERT INTO inventario (nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo) --No se incluye id_producto porque ya con el identity(1,1) se asigna de manera automática, incrementando de uno en uno. Si se quita esto en la creación de la tabla, se tendría que poner siempre el ID y asegurarse de que no se repita.
VALUES ('Laptop Pro 15', 'Computación', 1200.00,	15	,3,	'2024-01-10',	1);

INSERT INTO inventario (nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo) 
VALUES('Mouse Inalámbrico'	,'Accesorios',	28.00,	80,	10,	'2024-01-10'	,1);

INSERT INTO inventario (nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo) 
VALUES('Monitor 4K 27in',	'Computación',	450.00,	12,	2,	'2024-01-15',	1);

INSERT INTO inventario (nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo) 
VALUES('Teclado Mecánico',	'Accesorios',	95.00,	40,	5,	'2024-01-15',	1);

INSERT INTO inventario (nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo) 
VALUES('Laptop Basic 14',	'Computación'	,650.00,	20,	3,	'2024-02-01',	1);

INSERT INTO inventario (nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo) 
VALUES('Auriculares BT Pro',	'Audio',	120.00,	35,	5,	'2024-02-01',	1);

INSERT INTO inventario (nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo) 
VALUES('Hub USB-C 7 puertos',	'Accesorios',	45.00,	60,	10,	'2024-02-10',	1);

INSERT INTO inventario (nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo) 
VALUES('Webcam HD 1080p',	'Accesorios',	85.00,	25,	5,	'2024-02-10',	1);


INSERT INTO inventario (nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo) 
VALUES('SSD Externo 1TB',	'Almacenamiento',	130.00,	18,	3,	'2024-03-01',	1);

INSERT INTO inventario (nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo) 
VALUES('Parlante Bluetooth',	'Audio',	60.00,	45,	8,	'2024-03-01',	1);

UPDATE inventario SET stock_actual = stock_actual - 3
WHERE id_producto = 1

UPDATE inventario SET stock_actual = stock_actual - 12
WHERE id_producto = 2

UPDATE inventario SET stock_actual = stock_actual - 5
WHERE id_producto = 6

UPDATE inventario SET activo = 0
WHERE id_producto = 8

SELECT * FROM inventario;