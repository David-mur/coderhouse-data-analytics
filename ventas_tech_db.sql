/************************
Script SQL de Ingeniería de Datos
Autor: David Muñoz Restrepo
Fecha: 24/09/2026

*************************/
DROP DATABASE IF EXISTS Ventas_Tech_DB;
CREATE DATABASE Ventas_Tech_DB;
GO

USE Ventas_Tech_DB;
GO

--Sección 1: DROP TABLES--
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;
GO

--Sección 2: CREATE TABLES--
CREATE TABLE categorias(
    id_categoria int IDENTITY(1,1) PRIMARY KEY,
    nombre_categoria varchar(50) NOT NULL,
    descripcion varchar(200)
)
GO

CREATE TABLE clientes(
    id_cliente int IDENTITY(1,1) PRIMARY KEY,
    nombre varchar(100) NOT NULL,
    email varchar(100) NOT NULL UNIQUE,
    ciudad varchar(50),
    fecha_registro date DEFAULT GETDATE() NOT NULL
)
GO

CREATE TABLE productos(
    id_producto int IDENTITY(1,1) PRIMARY KEY,
    nombre_producto varchar(100) NOT NULL,
    id_categoria int NOT NULL,
    precio decimal(10,2) NOT NULL,
    stock int DEFAULT 0,
    activo bit DEFAULT 1,
    CONSTRAINT FK_productos_categorias FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
)
GO

CREATE TABLE ventas(
    id_venta int IDENTITY(1,1) PRIMARY KEY,
    id_cliente int NOT NULL,
    id_producto int NOT NULL,
    cantidad int NOT NULL,
    precio_unitario decimal(10,2) NOT NULL,
    fecha_venta date DEFAULT GETDATE(),
    CONSTRAINT FK_ventas_clientes FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT FK_ventas_productos FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
)
GO

--Sección 3: INSERT DATA--

SET IDENTITY_INSERT categorias ON; --Este tipo de línea la vamos a usar en esta parte para respetar las líneas entregadas en la descripción del entregable, las debemos usar para poder proveer nosotros el número del id, ya que como se vio en la sección anterior, los id son la PK y tienen la sentencia IDENTITY, que tienen un asignamiento automático y tienen incremento, por lo que esta sentencia nos permite saltarnos esto de manera temporal

INSERT INTO categorias (id_categoria, nombre_categoria, descripcion) VALUES
  (1, 'Computación',    'Laptops, PCs y monitores'),
  (2, 'Accesorios',     'Periféricos y complementos'),
  (3, 'Audio',          'Auriculares y parlantes'),
  (4, 'Almacenamiento', 'Discos y memorias');

SET IDENTITY_INSERT categorias OFF; --Y luego de usarlo lo apagamos

SET IDENTITY_INSERT clientes ON;
INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro) VALUES
  (1, 'María López',  'maria@mail.com',  'Buenos Aires', '2024-01-05'),
  (2, 'Carlos Ruiz',  'carlos@mail.com', 'Córdoba',      '2024-01-10'),
  (3, 'Ana Gómez',    'ana@mail.com',    'Rosario',      '2024-02-01'),
  (4, 'Pedro Sanz',   'pedro@mail.com',  'Mendoza',      '2024-02-15'),
  (5, 'Laura Torres', 'laura@mail.com',  'Tucumán',      '2024-03-01');
SET IDENTITY_INSERT clientes OFF;

SET IDENTITY_INSERT productos ON;
INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, activo) VALUES
  (1, 'Laptop Pro 15',      1, 1200.00, 15, 1),
  (2, 'Mouse Inalámbrico',  2,   28.00, 80, 1),
  (3, 'Monitor 4K 27',      1,  450.00, 12, 1),
  (4, 'Auriculares BT Pro', 3,  120.00, 35, 1),
  (5, 'SSD Externo 1TB',    4,  130.00, 18, 1),
  (6, 'Teclado Mecánico',   2,   95.00, 40, 1);
SET IDENTITY_INSERT productos OFF;

SET IDENTITY_INSERT ventas ON;
INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES
  ( 1, 1, 1, 2, 1200.00, '2024-03-05'),
  ( 2, 2, 2, 5,   28.00, '2024-03-06'),
  ( 3, 3, 3, 1,  450.00, '2024-03-07'),
  ( 4, 1, 4, 2,  120.00, '2024-03-08'),
  ( 5, 4, 5, 3,  130.00, '2024-03-10'),
  ( 6, 2, 6, 4,   95.00, '2024-03-11'),
  ( 7, 5, 1, 1, 1200.00, '2024-03-12'),
  ( 8, 3, 2, 8,   28.00, '2024-03-13'),
  ( 9, 4, 4, 1,  120.00, '2024-03-14'),
  (10, 5, 3, 2,  450.00, '2024-03-15');
SET IDENTITY_INSERT ventas OFF;

GO

--Sección 4: VALIDACIÓN
SELECT * FROM categorias;   -- esperado: 4 filas
SELECT * FROM clientes;     -- esperado: 5 filas
SELECT * FROM productos;    -- esperado: 6 filas
SELECT * FROM ventas;       -- esperado: 10 filas

GO