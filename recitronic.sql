-- CREACION DE LA BASE DE DATOS --
CREATE DATABASE IF NOT EXISTS recitronic;
USE recitronic;

-- CREACION DE LAS TABLAS --
CREATE TABLE clientes(
    id_cliente int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    nombre VARCHAR(255),
    telefono VARCHAR(255),
    direccion VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE articulos(
    id_articulo int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    id_cliente int NOT NULL,
    tipo_articulo VARCHAR(255),
    estado VARCHAR(255),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
) ENGINE=InnoDB;

CREATE TABLE citas(
    id_cita int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    id_cliente int NOT NULL,
    fecha_hora DATETIME,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
) ENGINE=InnoDB;

CREATE TABLE pagos(
    id_pago int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    id_cliente int NOT NULL,
    monto DECIMAL(10, 0),
    fecha_pago DATETIME,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
) ENGINE=InnoDB;

-- CREACION DE LOS DATOS --
INSERT INTO clientes (nombre, direccion, telefono) VALUES
    ('Juan Perez', 'Calle 123', '9234567890'),
    ('Maria Gomez', 'Calle 456', '9876543210'),
    ('Pedro Rodriguez', 'Calle 789', '9555555555'),
    ('Ana Hernandez', 'Calle 321', '9111111111'),
    ('Luis Martinez', 'Calle 654', '9222222222'),
    ('Sofia Lopez', 'Calle 987', '9444444444'),
    ('Miguel Garcia', 'Calle 321', '9666666666'),
    ('Carolina Torres', 'Calle 654', '9888888888'),
    ('Diego Fernandez', 'Calle 987', '9111111111'),
    ('Valentina Ramirez', 'Calle 321', '9222222222');

INSERT INTO articulos (id_cliente, tipo_articulo, estado) VALUES
    (1, 'Celular', 'pendiente'),
    (2, 'Mouse', 'pendiente'),
    (3, 'Teclado', 'pendiente'),
    (4, 'Refrigerador', 'pendiente'),
    (5, 'Televisor', 'pendiente'),
    (6, 'Parlante', 'pendiente'),
    (7, 'Radio', 'pendiente'),
    (8, 'Cocina', 'pendiente'),
    (9, 'Celular', 'pendiente'),
    (10, 'Teclado', 'pendiente');

INSERT INTO citas (id_cliente, fecha_hora) VALUES
    (1, '2025-08-25 10:00:00'),
    (2, '2025-08-25 11:00:00'),
    (3, '2025-08-25 12:00:00'),
    (4, '2025-08-25 13:00:00'),
    (5, '2025-08-25 14:00:00'),
    (6, '2025-08-25 15:00:00'),
    (7, '2025-08-25 16:00:00'),
    (8, '2025-08-25 17:00:00'),
    (9, '2025-08-25 18:00:00'),
    (10, '2025-08-25 19:00:00');

INSERT INTO pagos (id_cliente, monto, fecha_pago) VALUES
    (1, 10000, '2025-08-25 10:30:00'),
    (2, 20000, '2025-08-25 11:50:00'),
    (3, 15000, '2025-08-25 13:10:00'),
    (4, 25000, '2025-08-25 14:30:00'),
    (5, 5000, '2025-08-25 15:50:00'),
    (6, 15000, '2025-08-25 17:10:00'),
    (7, 10000, '2025-08-25 18:30:00'),
    (8, 30000, '2025-08-25 19:50:00'),
    (9, 25000, '2025-08-25 21:10:00'),
    (10, 10000, '2025-08-25 22:30:00');

-- CONSULTAS Y TRANSACCIONES --
-- ejemplo de insercion de nuevos clientes --
INSERT INTO clientes (nombre, direccion, telefono) VALUES
    ('Lalo Landa', 'Calle 135', '9124567890'),
    ('Paco Ramirez', 'Calle 748', '9126543210'),
    ('Maria Perez', 'Calle 198', '9765432100');

-- ejemplo de insercion de nuevos articulos --
INSERT INTO articulos (id_cliente, tipo_articulo, estado) VALUES
    (11, 'Televisor', 'pendiente'),
    (12, 'Celular', 'pendiente'),
    (13, 'Computador', 'pendiente');

-- ejemplo de insercion de nuevas citas --
INSERT INTO citas (id_cliente, fecha_hora) VALUES
    (11, '2025-08-26 10:00:00'),
    (12, '2025-08-26 11:00:00'),
    (13, '2025-08-26 12:00:00');

-- ejemplo de insercion de nuevos pagos --
INSERT INTO pagos (id_cliente, monto, fecha_pago) VALUES
    (11, 10000, '2025-08-25 22:30:00'),
    (12, 20000, '2025-08-25 22:50:00'),
    (13, 15000, '2025-08-25 23:10:00');

-- ejemplo de actualizacion de datos de clientes: actualizacion de la direccion y telefono --
UPDATE clientes
SET direccion = 'Las Camelias 156', telefono = '9124567899'
WHERE id_cliente = 4;

UPDATE clientes
SET direccion = 'Avenida de la Libertad 523', telefono = '9991245678'
WHERE id_cliente = 9;

-- ejemplo de creacion de nuevo cliente, articulo, cita y pago --
START TRANSACTION;

INSERT INTO clientes (nombre, direccion, telefono) VALUES
    ('Romina Lopez', 'Las Dalias 777', '9124561234');

INSERT INTO articulos (id_cliente, tipo_articulo, estado) VALUES
    (14, 'Aspiradora', 'reciclado');

INSERT INTO citas (id_cliente, fecha_hora) VALUES
    (14, '2025-08-25 22:00:00');

INSERT INTO pagos (id_cliente, monto, fecha_pago) VALUES
    (14, 10000, '2025-08-25 22:30:00');

COMMIT;

-- ejemplo de actualizacion de citas --
UPDATE citas
SET fecha_hora = '2025-08-26 08:00:00'
WHERE id_cita = 5;

-- ejemplo de actualizacion de estado de articulos --
UPDATE articulos
SET estado = 'reciclado'
WHERE id_articulo = 1;

-- ejemplo de eliminacion de articulos --
DELETE FROM articulos
WHERE id_articulo = 2;

-- ejemplo de eliminacion de citas --
DELETE FROM citas
WHERE id_cita = 6;

-- ejemplo de transaccion: insertar datos, actualizar registros, eliminar registros --
-- caso hipotetico en el que se agrega un registro por error por lo que se debe eliminar y actualizar el correcto --
START TRANSACTION;
INSERT INTO citas (id_cliente, fecha_hora) VALUES
    (5, '2025-08-26 09:00:00');
UPDATE citas
SET fecha_hora = '2025-08-26 09:00:00'
WHERE id_cita = 5;
DELETE FROM citas
WHERE id_cita = 15;
COMMIT;

-- ejemplo de transaccion utilizando rollback y commit --
-- caso practico en el que se realiza un pago y se marca el articulo como reciclado y se revierte el estado en caso de haber un error con el pago --
START TRANSACTION;
INSERT INTO pagos (id_cliente, monto, fecha_pago) VALUES
    (10, 10000, '2025-08-25 22:30:00');

UPDATE articulos
SET estado = 'reciclado'
WHERE id_articulo = 10;
ROLLBACK;
COMMIT;