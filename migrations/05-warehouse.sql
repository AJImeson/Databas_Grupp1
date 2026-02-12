
-- =============================================================
-- INVENTORY & WAREHOUSING
-- Ansvarig: Cebrail
-- =============================================================

USE ace_ventura;

START TRANSACTION;

-- Clean up the database
DROP VIEW IF EXISTS inventory_details;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS warehouses;

-- Table for locations
CREATE TABLE warehouses (
    warehouse_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    adress VARCHAR(255) NOT NULL,
    postal_code VARCHAR(20),
    phone_number VARCHAR(20),
    UNIQUE(city)
);

-- Creating Test data/Seeding the database for development
INSERT INTO warehouses (city, adress, postal_code, phone_number) VALUES
    ('Stockholm', 'Lagergränd 10', '111 22', '08-123 45 67'),
    ('Göteborg', 'Hamngatann 5', '411 01', '031-99 88 77'),
    ('Malmö', 'Södra vägen 22', '211 44', '040-55 44 33');


-- Table for stock balances
CREATE TABLE inventory (
    inventory_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    warehouse_id INTEGER,
    sku VARCHAR(20) NOT NULL,
    stock_quantity INTEGER DEFAULT 0 CHECK (stock_quantity >=0),
    CONSTRAINT fk_inventory_warehouse
        FOREIGN KEY (warehouse_id)
        REFERENCES warehouses (warehouse_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_inv_sku
        FOREIGN KEY (sku)
        REFERENCES product_information (sku)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    UNIQUE (warehouse_id, sku)
);


-- Creating Test data: Inventory level
INSERT INTO inventory (warehouse_id, sku, stock_quantity)
VALUES
    (1, 'TOY001', 500),
    (1, 'SER001', 300),
    (2, 'TOY001', 5),
    (2, 'SER002', 0),
    (3, 'VIB001', 100)
ON DUPLICATE KEY UPDATE stock_quantity = VALUES(stock_quantity);

CREATE VIEW  inventory_details AS
SELECT
    war.city AS warehouse_city,
    inv.sku AS product_sku,
    inv.stock_quantity AS current_stock
FROM warehouses AS war
JOIN inventory AS inv
    ON war.warehouse_id = inv.warehouse_id;

COMMIT;
