-- Crear tabla Vivero
CREATE TABLE Vivero (
    ID_Vivero SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Latitud DECIMAL(9, 6) NOT NULL,
    Longitud DECIMAL(9, 6) NOT NULL
);

-- Crear tabla Zona
CREATE TABLE Zona (
    ID_Vivero INT,
    ID_Zona SERIAL,
    Nombre VARCHAR(100) NOT NULL,
    Latitud DECIMAL(9, 6) NOT NULL,
    Longitud DECIMAL(9, 6) NOT NULL,
    PRIMARY KEY (ID_Vivero, ID_Zona),
    FOREIGN KEY (ID_Vivero) REFERENCES Vivero(ID_Vivero) ON DELETE CASCADE
);

-- Crear tabla Producto
CREATE TABLE Producto (
    ID_Producto SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);

-- Crear tabla Empleado
CREATE TABLE Empleado (
    ID_Empleado SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);

-- Crear tabla Cliente
CREATE TABLE Cliente (
    ID_Cliente SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);

-- Crear tabla Pedido
CREATE TABLE Pedido (
    ID_Pedido SERIAL PRIMARY KEY,
    ID_Cliente INT,
    Fecha_Pedido DATE NOT NULL,
    ID_Empleado INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente) ON DELETE CASCADE,
    FOREIGN KEY (ID_Empleado) REFERENCES Empleado(ID_Empleado) ON DELETE CASCADE
);

-- Crear tabla Detalle_Pedido
CREATE TABLE Detalle_Pedido (
    ID_Pedido INT,
    ID_Producto INT,
    Cantidad INT NOT NULL,
    PRIMARY KEY (ID_Pedido, ID_Producto),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido) ON DELETE CASCADE,
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto) ON DELETE CASCADE
);

-- Crear tabla Historial_Puesto
CREATE TABLE Historial_Puesto (
    ID_Vivero INT,
    ID_Zona INT,
    ID_Empleado INT,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE,
    Tarea VARCHAR(200),
    TrabajosRealizados INT,
    PRIMARY KEY (ID_Vivero, ID_Zona, ID_Empleado, Fecha_Inicio),
    FOREIGN KEY (ID_Vivero, ID_Zona) REFERENCES Zona(ID_Vivero, ID_Zona) ON DELETE CASCADE,
    FOREIGN KEY (ID_Empleado) REFERENCES Empleado(ID_Empleado) ON DELETE CASCADE,
    CHECK (Fecha_Fin IS NULL OR Fecha_Fin > Fecha_Inicio),
    CHECK (TrabajosRealizados >= 0),
    CHECK (Tarea IS NOT NULL AND Tarea <> '')
);

-- Crear tabla Stock
CREATE TABLE Stock (
    ID_Vivero INT,
    ID_Zona INT,
    ID_Producto INT,
    Cantidad INT NOT NULL,
    PRIMARY KEY (ID_Vivero, ID_Zona, ID_Producto),
    FOREIGN KEY (ID_Vivero, ID_Zona) REFERENCES Zona(ID_Vivero, ID_Zona) ON DELETE CASCADE,
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto) ON DELETE CASCADE
);

-- Insertar datos en la tabla Vivero
INSERT INTO Vivero (Nombre, Latitud, Longitud) VALUES
('Vivero Central', 40.712776, -74.005974),
('Vivero Norte', 41.878113, -87.629799),
('Vivero Sur', 34.052235, -118.243683),
('Vivero Este', 34.052235, -118.243683),
('Vivero Oeste', 37.774929, -122.419418);

-- Insertar datos en la tabla Zona
INSERT INTO Zona (ID_Vivero, Nombre, Latitud, Longitud) VALUES
(1, 'Zona A', 40.712776, -74.005974),
(1, 'Zona B', 40.712776, -74.005974),
(2, 'Zona C', 41.878113, -87.629799),
(3, 'Zona D', 34.052235, -118.243683),
(4, 'Zona E', 34.052235, -118.243683);

-- Insertar datos en la tabla Producto
INSERT INTO Producto (Nombre) VALUES
('Producto 1'),
('Producto 2'),
('Producto 3'),
('Producto 4'),
('Producto 5');

-- Insertar datos en la tabla Empleado
INSERT INTO Empleado (Nombre) VALUES
('Empleado 1'),
('Empleado 2'),
('Empleado 3'),
('Empleado 4'),
('Empleado 5');

-- Insertar datos en la tabla Cliente
INSERT INTO Cliente (Nombre) VALUES
('Cliente 1'),
('Cliente 2'),
('Cliente 3'),
('Cliente 4'),
('Cliente 5');

-- Insertar datos en la tabla Pedido
INSERT INTO Pedido (ID_Cliente, Fecha_Pedido, ID_Empleado) VALUES
(1, '2023-01-01', 1),
(2, '2023-02-01', 2),
(3, '2023-03-01', 3),
(4, '2023-04-01', 4),
(5, '2023-05-01', 5);

-- Insertar datos en la tabla Detalle_Pedido
INSERT INTO Detalle_Pedido (ID_Pedido, ID_Producto, Cantidad) VALUES
(1, 1, 10),
(1, 2, 5),
(2, 3, 7),
(3, 4, 3),
(4, 5, 12),
(5, 1, 8);

-- Insertar datos en la tabla Historial_Puesto
INSERT INTO Historial_Puesto (ID_Vivero, ID_Zona, ID_Empleado, Fecha_Inicio, Fecha_Fin, Tarea, TrabajosRealizados) VALUES
(1, 1, 1, '2023-01-01', '2023-01-10', 'Riego', 100),
(1, 2, 2, '2023-02-01', '2023-02-15', 'Poda', 150),
(2, 3, 3, '2023-03-01', '2023-03-20', 'Fertilización', 200),
(3, 4, 4, '2023-04-01', '2023-04-25', 'Plantación', 250),
(4, 5, 5, '2023-05-01', '2023-06-25', 'Mantenimiento', 300);

-- Insertar datos en la tabla Stock
INSERT INTO Stock (ID_Vivero, ID_Zona, ID_Producto, Cantidad) VALUES
(1, 1, 1, 50),
(1, 2, 2, 30),
(2, 3, 3, 20),
(3, 4, 4, 40),
(4, 5, 5, 60);