-- =============================================
-- Orders 5.5
-- Ansvarig: Axel
-- =============================================
USE ace_ventura;

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
        user_id
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
    inventory_id INTEGER NOT NULL,
    sku VARCHAR(8) NOT NULL,
    qty INTEGER NOT NULL CHECK (qty > 0),
    sale_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (items_id),
    CONSTRAINT link_order FOREIGN KEY (order_id) REFERENCES orders (order_id),
    CONSTRAINT link_shop FOREIGN KEY (product_id) REFERENCES products (product_id),
    CONSTRAINT link_inventory FOREIGN KEY (inventory_id) REFERENCES inventory (inventory_id) ON UPDATE CASCADE
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
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 2, 4),
(5, 1, 5);
COMMIT;

-- Dummy data for Items
SET autocommit = 0;
INSERT INTO order_items (order_id, product_id, inventory_id, sku, qty, warehouse_id, sale_price) VALUES
(1, 1, 1, 'TOY001', 1, 1, 60000.00),
(2, 2, 2, 'SER001', 2, 1, 599.00),
(4, 3, 5, 'VIB001', 1, 3, 3999.00);
COMMIT;
