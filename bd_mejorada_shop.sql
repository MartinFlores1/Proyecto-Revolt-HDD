-- Creación de la base de datos
CREATE DATABASE BD_Shopping;
GO

USE BD_Shopping;
GO

-- Crear tablas principales primero
CREATE TABLE empleados (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) UNIQUE NOT NULL,
    contrasena NVARCHAR(MAX) NOT NULL,
    rol NVARCHAR(255) NOT NULL,
    telefono NVARCHAR(255),
    puesto NVARCHAR(255),
    estado NVARCHAR(50) DEFAULT 'activo',
    creado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET(),
    actualizado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET()
);

CREATE TABLE clientes (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) UNIQUE NOT NULL,
    contrasena NVARCHAR(MAX) NOT NULL,
    telefono NVARCHAR(255),
    direccion NVARCHAR(MAX),
    estado NVARCHAR(50) DEFAULT 'activo',
    creado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET(),
    actualizado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET()
);

CREATE TABLE categorias (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(255) NOT NULL,
    empleado_id BIGINT FOREIGN KEY REFERENCES empleados(id),
    creado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET(),
    actualizado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET()
);

CREATE TABLE productos (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(255) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    descripcion NVARCHAR(MAX),
    categoria_id BIGINT FOREIGN KEY REFERENCES categorias(id),
    empleado_id BIGINT FOREIGN KEY REFERENCES empleados(id),
    marca_nombre NVARCHAR(255) NOT NULL,
	color_nombre NVARCHAR(255) NOT NULL,
    stock INT NOT NULL,
	image_dir NVARCHAR(MAX),
	image_dir_d_01 NVARCHAR(MAX),
	image_dir_d_02 NVARCHAR(MAX),
	image_dir_d_03 NVARCHAR(MAX),
	puntuacion INT NOT NULL,
    creado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET(),
    actualizado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET()
);

CREATE TABLE metodos_pago (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(255) NOT NULL,
    descripcion NVARCHAR(MAX),
    es_tarjeta BIT DEFAULT 0,
    creado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET(),
    actualizado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET()
);

CREATE TABLE pasarelas_pago (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(255) NOT NULL,
    descripcion NVARCHAR(MAX),
    comision DECIMAL(5, 2) NOT NULL,
    creado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET(),
    actualizado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET()
);

CREATE TABLE proveedores (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(255) NOT NULL,
    contacto NVARCHAR(255),
    telefono NVARCHAR(255),
    email NVARCHAR(255) UNIQUE
);

-- Crear la tabla 'ordenes' antes que las dependientes
CREATE TABLE ordenes (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    cliente_id BIGINT FOREIGN KEY REFERENCES clientes(id),
    fecha DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET(),
    total DECIMAL(10, 2) NOT NULL,
    estado NVARCHAR(50) DEFAULT 'pendiente',
    metodo_pago_id BIGINT FOREIGN KEY REFERENCES metodos_pago(id),
    pasarela_pago_id BIGINT FOREIGN KEY REFERENCES pasarelas_pago(id),
    facturacion_id BIGINT, -- Se actualiza después
    tarjeta_id BIGINT,     -- Se actualiza después
    creado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET(),
    actualizado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET()
);

-- Crear tablas que dependen de 'ordenes'
CREATE TABLE facturacion (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    orden_id BIGINT FOREIGN KEY REFERENCES ordenes(id),
    nombre_completo NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) NOT NULL,
    direccion NVARCHAR(MAX) NOT NULL,
    ciudad NVARCHAR(255),
    pais NVARCHAR(255),
    codigo_postal NVARCHAR(10),
    creado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET(),
    actualizado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET()
);

CREATE TABLE informacion_tarjeta (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    orden_id BIGINT FOREIGN KEY REFERENCES ordenes(id),
    nombre_tarjeta NVARCHAR(255) NOT NULL,
    numero_tarjeta NVARCHAR(20) NOT NULL,
    mes_exp NVARCHAR(2) NOT NULL,
    ano_exp NVARCHAR(4) NOT NULL,
    cvv NVARCHAR(4) NOT NULL,
    creado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET(),
    actualizado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET()
);

CREATE TABLE notas_credito (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    orden_id BIGINT FOREIGN KEY REFERENCES ordenes(id),
    fecha_emision DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET(),
    total DECIMAL(10, 2) NOT NULL,
    motivo NVARCHAR(MAX),
    estado NVARCHAR(50) DEFAULT 'activo',
    creado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET(),
    actualizado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET()
);

-- Crear otras tablas relacionadas
CREATE TABLE detalles_orden (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    orden_id BIGINT FOREIGN KEY REFERENCES ordenes(id),
    producto_id BIGINT FOREIGN KEY REFERENCES productos(id),
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL
);

CREATE TABLE compras (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    proveedor_id BIGINT FOREIGN KEY REFERENCES proveedores(id),
    fecha DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET(),
    total DECIMAL(10, 2) NOT NULL,
    estado NVARCHAR(50) DEFAULT 'pendiente',
    creado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET(),
    actualizado_en DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET()
);

CREATE TABLE detalles_compra (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    compra_id BIGINT FOREIGN KEY REFERENCES compras(id),
    producto_id BIGINT FOREIGN KEY REFERENCES productos(id),
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL
);

CREATE TABLE inventario (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    producto_id BIGINT FOREIGN KEY REFERENCES productos(id),
    cantidad INT NOT NULL,
    ubicacion NVARCHAR(255),
    empleado_id BIGINT FOREIGN KEY REFERENCES empleados(id)
);
