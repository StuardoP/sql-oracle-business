INSERT INTO HS_CLIENTE (nombre, email, telefono) VALUES ('Ana López', 'ana@example.com', '5551-1001');
INSERT INTO HS_CLIENTE (nombre, email, telefono) VALUES ('Carlos Méndez', 'carlos@example.com', '5551-1002');
INSERT INTO HS_CLIENTE (nombre, email, telefono) VALUES ('Sofía Ramírez', 'sofia@example.com', '5551-1003');

INSERT INTO HS_PROVEEDOR (nombre, email, telefono) VALUES ('Distribuidora Central', 'ventas@central.example', '5552-2001');
INSERT INTO HS_PROVEEDOR (nombre, email, telefono) VALUES ('Productos del Norte', 'pedidos@norte.example', '5552-2002');

INSERT INTO HS_CATEGORIA (nombre, descripcion) VALUES ('Alimentos', 'Productos alimenticios empacados');
INSERT INTO HS_CATEGORIA (nombre, descripcion) VALUES ('Bebidas', 'Bebidas frías y calientes');

INSERT INTO HS_PRODUCTO (categoria_id, proveedor_id, nombre, precio) VALUES (1, 1, 'Café premium', 48.50);
INSERT INTO HS_PRODUCTO (categoria_id, proveedor_id, nombre, precio) VALUES (1, 2, 'Galletas integrales', 22.00);
INSERT INTO HS_PRODUCTO (categoria_id, proveedor_id, nombre, precio) VALUES (2, 1, 'Té verde', 31.75);

INSERT INTO HS_INVENTARIO (producto_id, existencia, stock_minimo) VALUES (1, 30, 10);
INSERT INTO HS_INVENTARIO (producto_id, existencia, stock_minimo) VALUES (2, 4, 8);
INSERT INTO HS_INVENTARIO (producto_id, existencia, stock_minimo) VALUES (3, 18, 6);

INSERT INTO HS_EMPLEADO (nombre, puesto, email) VALUES ('Luis Pérez', 'Ventas', 'luis@example.com');
INSERT INTO HS_EMPLEADO (nombre, puesto, email) VALUES ('María Castillo', 'Supervisora', 'maria@example.com');

INSERT INTO HS_PEDIDO (cliente_id, empleado_id, fecha_pedido, estado) VALUES (1, 1, DATE '2026-09-10', 'ENTREGADO');
INSERT INTO HS_PEDIDO (cliente_id, empleado_id, fecha_pedido, estado) VALUES (2, 2, DATE '2026-09-15', 'ENVIADO');

INSERT INTO HS_DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1, 1, 2, 48.50);
INSERT INTO HS_DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (1, 2, 1, 22.00);
INSERT INTO HS_DETALLE_PEDIDO (pedido_id, producto_id, cantidad, precio_unitario) VALUES (2, 3, 3, 31.75);

INSERT INTO HS_ENTREGA (pedido_id, direccion, fecha_estimada, fecha_entrega, estado)
VALUES (1, 'Zona 10, Guatemala', DATE '2026-09-12', DATE '2026-09-12', 'ENTREGADA');
INSERT INTO HS_ENTREGA (pedido_id, direccion, fecha_estimada, estado)
VALUES (2, 'Zona 1, Guatemala', DATE '2026-09-18', 'EN_RUTA');

COMMIT;

