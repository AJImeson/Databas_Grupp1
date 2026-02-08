-- Migration: Create warehouse and inventory for pet supplies
--Support requirement 5.6 (warehouse) and 5.8.2 (fullfillment logic)

START TRANSACTIONi;
-- 5.6.1: warehouse in major cities
CREATE TABLE warehouses (
    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    UNIQUE(city)
);
-- 5.6.2 inventory tracking for products (3nf)
CREATE TABLE inventory (
    warehouse_id INT,
    sku VARCHAR(50),
    stock_quantity INT NOT NULL DEFAULT 0,
	PRIMARY KEY (warehouse_id, sku)
);

-- populatiing with 3 warehouses (5.6.1)
INSERT INTO warehouses (city)
VALUES
    ('stockholm'),
    ('göteborg'),
    ('malmö');

-- populating inventory for pet products (5.6.2)
INSERT INTO inventory (warehouse_id, sku, stock_quantity)
VALUES
    (1, 'pet-food-dog-01', 500),
    (1, 'pet-leash-cat-02', 300),
    (2, 'pet-food-dog-01', 5),
    (2, 'pet-leash-cat-02', 0),,
    (3, 'pet-food-dog-01', 100);

COMMIT;
 
--- retry
