CREATE TABLE HS_CLIENTE (
    cliente_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    email VARCHAR2(150) NOT NULL UNIQUE,
    telefono VARCHAR2(20),
    fecha_registro DATE DEFAULT SYSDATE NOT NULL
);

CREATE TABLE HS_PROVEEDOR (
    proveedor_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(120) NOT NULL,
    email VARCHAR2(150) UNIQUE,
    telefono VARCHAR2(20)
);

CREATE TABLE HS_CATEGORIA (
    categoria_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(80) NOT NULL UNIQUE,
    descripcion VARCHAR2(250)
);

CREATE TABLE HS_PRODUCTO (
    producto_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    categoria_id NUMBER NOT NULL,
    proveedor_id NUMBER NOT NULL,
    nombre VARCHAR2(120) NOT NULL,
    precio NUMBER(10,2) NOT NULL CHECK (precio > 0),
    activo CHAR(1) DEFAULT 'S' CHECK (activo IN ('S','N')),
    CONSTRAINT fk_producto_categoria FOREIGN KEY (categoria_id) REFERENCES HS_CATEGORIA(categoria_id),
    CONSTRAINT fk_producto_proveedor FOREIGN KEY (proveedor_id) REFERENCES HS_PROVEEDOR(proveedor_id)
);

CREATE TABLE HS_INVENTARIO (
    inventario_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    producto_id NUMBER NOT NULL UNIQUE,
    existencia NUMBER DEFAULT 0 NOT NULL CHECK (existencia >= 0),
    stock_minimo NUMBER DEFAULT 5 NOT NULL CHECK (stock_minimo >= 0),
    actualizado_en TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT fk_inventario_producto FOREIGN KEY (producto_id) REFERENCES HS_PRODUCTO(producto_id)
);

CREATE TABLE HS_EMPLEADO (
    empleado_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    puesto VARCHAR2(80) NOT NULL,
    email VARCHAR2(150) NOT NULL UNIQUE,
    fecha_contratacion DATE DEFAULT SYSDATE
);

CREATE TABLE HS_PEDIDO (
    pedido_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cliente_id NUMBER NOT NULL,
    empleado_id NUMBER NOT NULL,
    fecha_pedido DATE DEFAULT SYSDATE NOT NULL,
    estado VARCHAR2(20) DEFAULT 'PENDIENTE' CHECK (estado IN ('PENDIENTE','PAGADO','ENVIADO','ENTREGADO','CANCELADO')),
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (cliente_id) REFERENCES HS_CLIENTE(cliente_id),
    CONSTRAINT fk_pedido_empleado FOREIGN KEY (empleado_id) REFERENCES HS_EMPLEADO(empleado_id)
);

CREATE TABLE HS_DETALLE_PEDIDO (
    detalle_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pedido_id NUMBER NOT NULL,
    producto_id NUMBER NOT NULL,
    cantidad NUMBER NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMBER(10,2) NOT NULL CHECK (precio_unitario > 0),
    CONSTRAINT uq_detalle_producto UNIQUE (pedido_id, producto_id),
    CONSTRAINT fk_detalle_pedido FOREIGN KEY (pedido_id) REFERENCES HS_PEDIDO(pedido_id),
    CONSTRAINT fk_detalle_producto FOREIGN KEY (producto_id) REFERENCES HS_PRODUCTO(producto_id)
);

CREATE TABLE HS_ENTREGA (
    entrega_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pedido_id NUMBER NOT NULL UNIQUE,
    direccion VARCHAR2(250) NOT NULL,
    fecha_estimada DATE,
    fecha_entrega DATE,
    estado VARCHAR2(20) DEFAULT 'PREPARANDO' CHECK (estado IN ('PREPARANDO','EN_RUTA','ENTREGADA','INCIDENCIA')),
    CONSTRAINT fk_entrega_pedido FOREIGN KEY (pedido_id) REFERENCES HS_PEDIDO(pedido_id)
);

CREATE INDEX idx_pedido_fecha ON HS_PEDIDO(fecha_pedido);
CREATE INDEX idx_producto_categoria ON HS_PRODUCTO(categoria_id);
CREATE INDEX idx_detalle_pedido ON HS_DETALLE_PEDIDO(pedido_id);

