
USE ace_venture;

START TRANSACTION;
CREATE TABLE IF NOT EXISTS warehouses (
    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    UNIQUE(city)
);

CREATE TABLE IF NOT EXISTS inventory (
    warehouse_id INT,
    sku VARCHAR(50),
    stock_quantity INT NOT NULL DEFAULT 0,
    PRIMARY KEY (warehouse_id, sku)
);

INSERT IGNORE INTO warehouses (city)
VALUES ('stockholm'), ('göteborg'), ('malmö');

INSERT INTO inventory (warehouse_id, sku, stock_quantity)
VALUES
(1, 'pet-food-dog-01', 500),
(1, 'pet-leash-cat-02', 300),
(2, 'pet-food-dog-01', 5),
(2, 'pet-leash-cat-02', 0),
(3, 'pet-food-dog-01', 100)
ON DUPLICATE KEY UPDATE stock_quantity = VALUES(stock_quantity);

COMMIT;
