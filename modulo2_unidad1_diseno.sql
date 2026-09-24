CREATE DATABASE practice_1; --Se crea así la base de datos de esta práctica

USE practice_1; --Se usa esa base de datos antes creada

CREATE TABLE clientes( --Creando la tabla de clientes se definen las siguientes columnas que podrán contener entradas
    id_cliente int identity(1,1) NOT NULL, --Esta es la PK, un número entero donde no puede haber campo vacío (esto último se repite para los demás en ambas tablas)
    nombre varchar(100) NOT NULL, --Se usa el tipo variable para un almacenammiento dinámico según la información que se ingrese, lo mismo que perfil bio, estableciendo un límite según lo que se querrá ingresar
    perfil_bio varchar(255) NOT NULL, --Tipo variable para almacenar una gran cantidad de caractéres hasta un límite y que almacene lo que tenga
    fecha_registro date NOT NULL --Tipo de dato de fecha sin hora
);

CREATE TABLE productos(
    id_producto int identity(1,1) NOT NULL,--Esta es la PK, nuevamente número entero donde no puede haber campo vacío
    descripcion varchar(255) NOT NULL, --Tipo variable para almacenar una gran cantidad de caractéres hasta un límite y que almacene lo que tenga
    precio decimal (10,2) NOT NULL, --Precio con tipo decimal y 2 cifras decimales para demarcar exactitud, ya que float constaría en almacenar aproximaciones
    esta_activo bit NOT NULL --Se define si el producto está activo mediante un valor booleano (para la sintaxis de SQL Server) 
)

SELECT * FROM productos