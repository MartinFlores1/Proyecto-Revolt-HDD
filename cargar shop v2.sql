-- Insertar empleados
INSERT INTO empleados (nombre, email, contrasena, rol, telefono, puesto) VALUES
('Juan Pérez', 'juan.perez@revolt.com', 'password123', 'admin', '555-0101', 'Gerente'),
('Ana García', 'ana.garcia@revolt.com', 'password123', 'vendedor', '555-0102', 'Vendedora'),
('Luis López', 'luis.lopez@revolt.com', 'password123', 'almacen', '555-0103', 'Encargado de Almacén'),
('María Torres', 'maria.torres@revolt.com', 'password123', 'vendedor', '555-0104', 'Vendedora'),
('Pedro Sánchez', 'pedro.sanchez@revolt.com', 'password123', 'admin', '555-0105', 'Gerente');

-- Insertar clientes
INSERT INTO clientes (nombre, email, contrasena, telefono, direccion) VALUES
('Carlos Ruiz', 'carlos.ruiz@cliente.com', 'password123', '555-0201', 'Av. Siempre Viva 123'),
('Laura Jiménez', 'laura.jimenez@cliente.com', 'password123', '555-0202', 'Calle Falsa 456'),
('Javier Martínez', 'javier.martinez@cliente.com', 'password123', '555-0203', 'Calle 7 789'),
('Sofía Morales', 'sofia.morales@cliente.com', 'password123', '555-0204', 'Av. Libertad 101'),
('Diego Hernández', 'diego.hernandez@cliente.com', 'password123', '555-0205', 'Calle de la Paz 202');

-- Insertar categorías
INSERT INTO categorias (nombre, empleado_id) VALUES
('Hombres', 1),
('Mujeres', 1),
('Accesorios', 2),
('Calzado', 3);

-- Insertar productos

INSERT INTO productos (nombre, precio, descripcion, categoria_id, empleado_id, marca_nombre, color_nombre, stock, image_dir, image_dir_d_01, image_dir_d_02, image_dir_d_03, puntuacion, creado_en, actualizado_en)
VALUES 
('Zapatillas Running', 257, 'Las más deportivas, uso casual', 4, 2, 'adidas', 'negro', 100, 'img/Hombre/Zapatos_H/redi/2.jpg', 'img/Hombre/Zapatos_H/redi/2.jpg', 'img/Hombre/Zapatos_H/redi/2.jpg', 'img/Hombre/Zapatos_H/redi/2.jpg', 2, DEFAULT, DEFAULT),
('Zapatilla Deportiva', 459, 'Deportiva, para todo terreno', 4, 2, 'adidas', 'pastel', 50, 'img/Hombre/Zapatos_H/redi/Z_CM1.png', 'img/Hombre/Zapatos_H/redi/Z_CM1.png', 'img/Hombre/Zapatos_H/redi/Z_CM1.png', 'img/Hombre/Zapatos_H/redi/Z_CM1.png', 4, DEFAULT, DEFAULT),
('Camiseta Deportiva', 170, 'Camiseta ultra suave...', 1, 3, 'reebok', 'blanco', 200, 'img/Hombre/Camisas_H/redi/CM1.png', 'img/Hombre/Camisas_H/redi/CM1.png', 'img/Hombre/Camisas_H/redi/CM1.png', 'img/Hombre/Camisas_H/redi/CM1.png', 5, DEFAULT, DEFAULT),
('Vestido Casual', 350, 'Vestido con telas importadas', 2, 3, 'udy', 'crema', 30, 'img/Mujeres/Vestidos_M/redi/V_CM1.png', 'img/Mujeres/Vestidos_M/redi/V_CM1.png', 'img/Mujeres/Vestidos_M/redi/V_CM1.png', 'img/Mujeres/Vestidos_M/redi/V_CM1.png', 1, DEFAULT, DEFAULT),
('Camisa de Lino', 120, 'Camisa color vainilla exclusivo en verano', 1, 3, 'udy', 'blanco', 30, 'img/Hombre/Camisas_H/redi/CH1.jpg', 'img/Hombre/Camisas_H/redi/CH1.jpg', 'img/Hombre/Camisas_H/redi/CH1.jpg', 'img/Hombre/Camisas_H/redi/CH1.jpg', 4, DEFAULT, DEFAULT),
('Camisa de Tela', 120, 'Camisa de vestir blanca', 1, 3, 'udy', 'blanco', 30, 'img/Hombre/Camisas_H/redi/CH2.jpg', 'img/Hombre/Camisas_H/redi/CH2.jpg', 'img/Hombre/Camisas_H/redi/CH2.jpg', 'img/Hombre/Camisas_H/redi/CH2.jpg', 5, DEFAULT, DEFAULT),
('Short Negro', 70, 'Short casual tela importada', 1, 3, 'udy', 'negro', 30, 'img/Hombre/Shorts_H/redi/SH1.jpg', 'img/Hombre/Shorts_H/redi/SH1.jpg', 'img/Hombre/Shorts_H/redi/SH1.jpg', 'img/Hombre/Shorts_H/redi/SH1.jpg', 2, DEFAULT, DEFAULT),
('Short Recortado', 70, 'Short casual 100% algodón', 1, 3, 'udy', 'blanco', 30, 'img/Hombre/Shorts_H/redi/SH2.jpg', 'img/Hombre/Shorts_H/redi/SH2.jpg', 'img/Hombre/Shorts_H/redi/SH2.jpg', 'img/Hombre/Shorts_H/redi/SH2.jpg', 4, DEFAULT, DEFAULT),
('Vestido Drapeado', 220, 'Vestido negro con franjas blancas', 2, 3, 'udi', 'negro', 30, 'img/Mujeres/Vestidos_M/redi/V1.jpg', 'img/Mujeres/Vestidos_M/redi/V1.jpg', 'img/Mujeres/Vestidos_M/redi/V1.jpg', 'img/Mujeres/Vestidos_M/redi/V1.jpg', 2, DEFAULT, DEFAULT),
('Vestido Tejido', 250, 'Vestido elegante, modo noche', 2, 3, 'udy', 'blanco', 30, 'img/Mujeres/Vestidos_M/redi/V2.jpg', 'img/Mujeres/Vestidos_M/redi/V2.jpg', 'img/Mujeres/Vestidos_M/redi/V2.jpg', 'img/Mujeres/Vestidos_M/redi/V2.jpg', 3, DEFAULT, DEFAULT),
('Short de Lino', 180, 'Short elegante, tela importada', 2, 3, 'udy', 'blanco', 30, 'img/Mujeres/Shorts_M/redi/S1.jpg', 'img/Mujeres/Shorts_M/redi/S1.jpg', 'img/Mujeres/Shorts_M/redi/S1.jpg', 'img/Mujeres/Shorts_M/redi/S1.jpg', 5, DEFAULT, DEFAULT),
('Short de Mezclilla', 150, 'Short deportivo, casual chicas', 2, 4, 'udy', 'negro', 75, 'img/Mujeres/Shorts_M/redi/S2.jpg', 'img/Mujeres/Shorts_M/redi/S2.jpg', 'img/Mujeres/Shorts_M/redi/S2.jpg', 'img/Mujeres/Shorts_M/redi/S2.jpg', 5, DEFAULT, DEFAULT);



-- Insertar métodos de pago
INSERT INTO metodos_pago (nombre, descripcion, es_tarjeta) VALUES
('Tarjeta de Crédito', 'Pago con tarjeta de crédito', 1),
('Tarjeta de Débito', 'Pago con tarjeta de débito', 1),
('Transferencia Bancaria', 'Pago mediante transferencia bancaria', 0),
('PayPal', 'Pago a través de PayPal', 0),
('Efectivo', 'Pago en efectivo al momento de la entrega', 0);

-- Insertar pasarelas de pago
INSERT INTO pasarelas_pago (nombre, descripcion, comision) VALUES
('Stripe', 'Pasarela de pago en línea', 2.5),
('PayPal', 'Sistema de pagos en línea', 3.0),
('Mercado Pago', 'Pasarela de pago para América Latina', 2.0),
('Authorize.Net', 'Solución de pago en línea', 2.5),
('Redsys', 'Pasarela de pago para tarjetas', 1.5);

-- Insertar órdenes
INSERT INTO ordenes (cliente_id, total, estado, metodo_pago_id, pasarela_pago_id) VALUES
(1, 59.97, 'confirmado', 1, 1),
(2, 29.99, 'pendiente', 2, 2),
(3, 39.99, 'cancelado', 3, 3),
(4, 89.99, 'confirmado', 4, 4),
(5, 15.99, 'confirmado', 5, 5);

-- Insertar facturación
INSERT INTO facturacion (orden_id, nombre_completo, email, direccion, ciudad, pais, codigo_postal) VALUES
(1, 'Carlos Ruiz', 'carlos.ruiz@cliente.com', 'Av. Siempre Viva 123', 'Ciudad A', 'País A', '12345'),
(2, 'Laura Jiménez', 'laura.jimenez@cliente.com', 'Calle Falsa 456', 'Ciudad B', 'País B', '23456'),
(3, 'Javier Martínez', 'javier.martinez@cliente.com', 'Calle 7 789', 'Ciudad C', 'País C', '34567'),
(4, 'Sofía Morales', 'sofia.morales@cliente.com', 'Av. Libertad 101', 'Ciudad D', 'País D', '45678'),
(5, 'Diego Hernández', 'diego.hernandez@cliente.com', 'Calle de la Paz 202', 'Ciudad E', 'País E', '56789');

-- Insertar información de tarjeta
INSERT INTO informacion_tarjeta (orden_id, nombre_tarjeta, numero_tarjeta, mes_exp, ano_exp, cvv) VALUES
(1, 'Juan Pérez', '1234567890123456', '12', '25', '123'),
(2, 'Ana García', '9876543210987654', '11', '24', '456'),
(3, 'Luis López', '4567890123456789', '10', '26', '789'),
(4, 'María Torres', '3216549870123456', '09', '27', '321'),
(5, 'Pedro Sánchez', '6543210987654321', '08', '25', '654');

-- Insertar detalles de órdenes
INSERT INTO detalles_orden (orden_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 3, 19.99),
(2, 2, 1, 29.99),
(3, 4, 1, 89.99),
(4, 3, 1, 15.99),
(5, 5, 1, 39.99);

-- Insertar proveedores
INSERT INTO proveedores (nombre, contacto, telefono, email) VALUES
('Proveedor A', 'Contacto A', '555-0301', 'contactoA@proveedora.com'),
('Proveedor B', 'Contacto B', '555-0302', 'contactoB@proveedora.com'),
('Proveedor C', 'Contacto C', '555-0303', 'contactoC@proveedora.com'),
('Proveedor D', 'Contacto D', '555-0304', 'contactoD@proveedora.com'),
('Proveedor E', 'Contacto E', '555-0305', 'contactoE@proveedora.com');

-- Insertar compras
INSERT INTO compras (proveedor_id, total, estado) VALUES
(1, 199.99, 'confirmado'),
(2, 150.50, 'pendiente'),
(3, 300.00, 'cancelado'),
(4, 400.75, 'pendiente'),
(5, 50.25, 'confirmado');

-- Insertar detalles de compras
INSERT INTO detalles_compra (compra_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 10, 19.99),
(2, 2, 5, 29.99),
(3, 3, 8, 15.99),
(4, 4, 2, 89.99),
(5, 5, 3, 39.99);

-- Insertar inventario
INSERT INTO inventario (producto_id, cantidad, ubicacion, empleado_id) VALUES
(1, 50, 'Almacén A', 3),
(2, 30, 'Almacén B', 3),
(3, 100, 'Almacén C', 2),
(4, 20, 'Almacén D', 4),
(5, 70, 'Almacén E', 4);

-- Insertar notas de crédito
INSERT INTO notas_credito (orden_id, total, motivo, estado) VALUES
(1, 10.00, 'Devolución de producto', 'activo'),
(2, 5.00, 'Cambio de talla', 'activo'),
(3, 15.00, 'Error en el pedido', 'activo'),
(4, 8.00, 'Producto defectuoso', 'activo'),
(5, 2.00, 'No conforme', 'activo');

