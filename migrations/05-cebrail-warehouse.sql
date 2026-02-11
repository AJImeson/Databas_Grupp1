
-- =============================================================
-- INVENTORY & WAREHOUSING
-- Ansvarig: Cebrail
-- =============================================================

USE ace_ventura;  -- <--- Viktigaste raden för att hamna rätt!
SET FOREIGN_KEY_CHECKS = 0;


START TRANSACTION;

-- Table for locations
CREATE TABLE IF NOT EXISTS warehouses (
    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    UNIQUE(city)
);


-- Table for stock balances
CREATE TABLE IF NOT EXISTS inventory (
    warehouse_id INT,
    sku VARCHAR(50),
    stock_quantity INT DEFAULT 0 CHECK (stock_quantity >=0),
    PRIMARY KEY (warehouse_id, sku),
    CONSTRAINT fk_inv_warehouse
        FOREIGN KEY (warehouse_id) REFERENCES warehouses (warehouse_id)
        ON UPDATE CASCADE ON DELETE CASCADE,

    CONSTRAINT fk_inv_sku
        FOREIGN KEY (sku) REFERENCES product_information (sku)
        ON UPDATE CASCADE
);

-- Test data: Warehouses
INSERT IGNORE INTO warehouses (city)
VALUES ('stockholm'), ('göteborg'), ('malmö');

-- Test data: Inventory level
INSERT INTO inventory (warehouse_id, sku, stock_quantity)
VALUES
    (1, 'pet-food-dog-01', 500),
    (1, 'pet-leash-cat-02', 300),
    (2, 'pet-food-dog-01', 5),
    (2, 'pet-leash-cat-02', 0),
    (3, 'pet-food-dog-01', 100)
ON DUPLICATE KEY UPDATE stock_quantity = VALUES(stock_quantity);

COMMIT;
SET FOREIGN_KEY_CHECKS = 1;

SELECT
    war.city AS warehouse_city,
    inv.sku AS product_sku,
    LPAD(inv.stock_quantity, 13, ' ') AS current_stock
FROM warehouses AS war
JOIN inventory AS inv ON war.warehouse_id = inv.warehouse_id;
