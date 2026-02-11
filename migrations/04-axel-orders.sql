-- =============================================
-- Orders 5.5
-- Ansvarig: Axel
-- =============================================
USE ace_ventura;
SET FOREIGN_KEY_CHECKS = 0;

-- Orders Migration Tables

-- Status
SET autocommit = 0;
CREATE TABLE IF NOT EXISTS order_status (
    status_id INTEGER NOT NULL AUTO_INCREMENT,
    status_name VARCHAR(20) NOT NULL UNIQUE,
    PRIMARY KEY (status_id),
    CONSTRAINT unique_status UNIQUE (status_name),
    CONSTRAINT monitor_status CHECK (
        status_name IN ('awaiting', 'fulfilled', 'cancelled')
    )
);
COMMIT;

-- Main Table
SET autocommit = 0;
CREATE TABLE IF NOT EXISTS orders (
    order_id INTEGER NOT NULL AUTO_INCREMENT,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL,
    status_id INTEGER NOT NULL,
    shipping_address_id INTEGER NOT NULL,
    PRIMARY KEY (order_id),
    CONSTRAINT order_users FOREIGN KEY (user_id) REFERENCES users (
        users_id
    ) ON UPDATE CASCADE,
    CONSTRAINT order_status FOREIGN KEY (status_id) REFERENCES order_status (
        status_id
    ) ON UPDATE CASCADE,
    CONSTRAINT order_adress FOREIGN KEY (shipping_address_id) REFERENCES addresses(addresses_id)
);
COMMIT;

-- Items
SET autocommit = 0;
CREATE TABLE IF NOT EXISTS order_items (
    items_id INTEGER NOT NULL AUTO_INCREMENT,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    sku VARCHAR(50) NOT NULL,
    qty INTEGER NOT NULL CHECK (qty > 0),
    warehouse_id INTEGER NOT NULL,
    sale_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (items_id),
    CONSTRAINT link_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT link_shop FOREIGN KEY (product_id) REFERENCES products(product_id)
    -- CONSTRAINT link_warehouse FOREIGN KEY (warehouse_id, sku) REFERENCES inventory(warehouse_id, sku) -- Warehouse table has in uppercase, should be converted to lowercase 
);
COMMIT;

SET autocommit = 0;
INSERT INTO order_status (status_name) VALUES ('awaiting');
INSERT INTO order_status (status_name) VALUES ('fulfilled');
INSERT INTO order_status (status_name) VALUES ('cancelled');
COMMIT;

 -- Dummy data for orders 
SET autocommit = 0;
INSERT INTO orders (user_id, status_id, shipping_address_id) VALUES
--User, Status, Address - Correct order?
(1, 1, 10), -- Awaiting
(2, 2, 11), -- Fulfilled
(3, 3, 12), -- Cancelled
(4, 2, 13),
(5, 2, 14),
(6, 3, 15),
(7, 1, 16);
COMMIT;

-- Dummy data for Items
SET autocommit = 0;
INSERT INTO order_items (order_id, product_id, sku, qty, warehouse_id, sale_price) VALUES
(1, 001, 'DB-15kg' ,4 , 1 , 35,99),
(1, 002, 'DB-20kg' ,4 ,1 , 39,99),
(1, 003, 'DB-26kg' ,4 ,1 , 42,99);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

