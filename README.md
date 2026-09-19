# Oracle Business Database

Relational database project for managing customers, suppliers, products, inventory, employees, orders and deliveries. It demonstrates Oracle SQL modeling, integrity constraints, transactions and business reporting.

## Highlights

- Nine normalized business entities
- Primary, foreign, unique and check constraints
- Identity columns and sequence-independent inserts
- Sample data for immediate execution
- Analytical queries for sales, inventory and customers
- Transaction examples with `COMMIT` and `ROLLBACK`
- Indexes for frequent lookup paths

## Data model

```mermaid
erDiagram
  HS_CLIENTE ||--o{ HS_PEDIDO : realiza
  HS_EMPLEADO ||--o{ HS_PEDIDO : atiende
  HS_PEDIDO ||--|{ HS_DETALLE_PEDIDO : contiene
  HS_PRODUCTO ||--o{ HS_DETALLE_PEDIDO : aparece
  HS_CATEGORIA ||--o{ HS_PRODUCTO : clasifica
  HS_PROVEEDOR ||--o{ HS_PRODUCTO : suministra
  HS_PRODUCTO ||--|| HS_INVENTARIO : mantiene
  HS_PEDIDO ||--o| HS_ENTREGA : genera
```

## Run order

Execute the scripts with Oracle SQL Developer or SQL*Plus:

```text
1. sql/01_schema.sql
2. sql/02_sample_data.sql
3. sql/03_business_queries.sql
```

## Business questions answered

- Which products are below their minimum stock?
- What are monthly sales totals?
- Who are the highest-value customers?
- Which categories generate the most revenue?
- What is the status of each delivery?

## Skills demonstrated

Oracle SQL, relational modeling, DDL, DML, joins, aggregation, subqueries, constraints, indexes and transactions.

## Author

**Herbert Stuardo Pacheco** — [GitHub](https://github.com/StuardoP) · [LinkedIn](https://linkedin.com/in/stuardopacheco)

