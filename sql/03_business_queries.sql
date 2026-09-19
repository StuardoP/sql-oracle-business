-- Inventory alerts
SELECT p.producto_id, p.nombre, i.existencia, i.stock_minimo
FROM HS_PRODUCTO p
JOIN HS_INVENTARIO i ON i.producto_id = p.producto_id
WHERE i.existencia <= i.stock_minimo
ORDER BY i.existencia;

-- Order totals
SELECT pe.pedido_id, c.nombre AS cliente,
       SUM(d.cantidad * d.precio_unitario) AS total
FROM HS_PEDIDO pe
JOIN HS_CLIENTE c ON c.cliente_id = pe.cliente_id
JOIN HS_DETALLE_PEDIDO d ON d.pedido_id = pe.pedido_id
GROUP BY pe.pedido_id, c.nombre
ORDER BY total DESC;

-- Monthly revenue
SELECT TO_CHAR(pe.fecha_pedido, 'YYYY-MM') AS mes,
       SUM(d.cantidad * d.precio_unitario) AS ventas
FROM HS_PEDIDO pe
JOIN HS_DETALLE_PEDIDO d ON d.pedido_id = pe.pedido_id
WHERE pe.estado <> 'CANCELADO'
GROUP BY TO_CHAR(pe.fecha_pedido, 'YYYY-MM')
ORDER BY mes;

-- Revenue by category
SELECT ca.nombre AS categoria,
       SUM(d.cantidad * d.precio_unitario) AS ingresos
FROM HS_CATEGORIA ca
JOIN HS_PRODUCTO p ON p.categoria_id = ca.categoria_id
JOIN HS_DETALLE_PEDIDO d ON d.producto_id = p.producto_id
GROUP BY ca.nombre
ORDER BY ingresos DESC;

-- Customer lifetime value
SELECT c.cliente_id, c.nombre,
       COUNT(DISTINCT pe.pedido_id) AS pedidos,
       NVL(SUM(d.cantidad * d.precio_unitario), 0) AS valor_total
FROM HS_CLIENTE c
LEFT JOIN HS_PEDIDO pe ON pe.cliente_id = c.cliente_id
LEFT JOIN HS_DETALLE_PEDIDO d ON d.pedido_id = pe.pedido_id
GROUP BY c.cliente_id, c.nombre
ORDER BY valor_total DESC;

-- Delivery tracking
SELECT pe.pedido_id, c.nombre AS cliente, e.estado,
       e.fecha_estimada, e.fecha_entrega
FROM HS_PEDIDO pe
JOIN HS_CLIENTE c ON c.cliente_id = pe.cliente_id
JOIN HS_ENTREGA e ON e.pedido_id = pe.pedido_id
ORDER BY e.fecha_estimada;

-- Safe inventory update transaction
SAVEPOINT before_inventory_change;
UPDATE HS_INVENTARIO
SET existencia = existencia - 2,
    actualizado_en = SYSTIMESTAMP
WHERE producto_id = 1 AND existencia >= 2;
COMMIT;

