
-- =============================================================
-- INVENTORY & WAREHOUSING
-- Ansvarig: Cebrail
-- =============================================================

USE ace_ventura;  

-- Stop the check of foreign keys to clean up
SET FOREIGN_KEY_CHECKS = 0;

START TRANSACTION;

-- Clean up the database
DROP VIEW IF EXISTS inventory_details;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS warehouses;

-- Table for locations
CREATE TABLE warehouses (
    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    adress VARCHAR(255) NOT NULL,
    postal_code VARCHAR(20),
    phone_number VARCHAR(20)
    UNIQUE(city)
);

-- Creating Test data/Seeding the database for development
INSERT INTO warehouses (city, adress, postal_code, phone_number) VALUES
    ('Stockholm', 'Lagergränd 10', '111 22', '08-123 45 67'),
    ('Göteborg', 'Hamngatann 5', '411 01', '031-99 88 77'),
    ('Malmö', 'Södra vägen 22', '211 44', '040-55 44 33');

 
-- Table for stock balances
CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    warehouse_id INT,
    sku VARCHAR(50) NOT NULL,
    stock_quantity INT DEFAULT 0 CHECK (stock_quantity >=0),
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
    (1, 'pet-food-dog-01', 500),
    (1, 'pet-leash-cat-02', 300),
    (2, 'pet-food-dog-01', 5),
    (2, 'pet-leash-cat-02', 0),
    (3, 'pet-food-dog-01', 100)
ON DUPLICATE KEY UPDATE stock_quantity = VALUES(stock_quantity);

CREATE VIEW  inventory_details AS
SELECT
    war.city AS warehouse_city,
    inv.sku AS product_sku,
    inv.stock_quantity AS current_stock
FROM warehouse AS war
JOIN inventory AS inv
    ON war.warehouse_id = inv.warehouse_id;

COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
