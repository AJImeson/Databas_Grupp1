-- =============================================
-- Orders 5.5
-- Ansvarig: Axel
-- =============================================

-- Orders Migration Tables

START TRANSACTION; 

-- Status

CREATE TABLE IF NOT EXISTS order_status (
        status_id INTEGER NOT NULL AUTO_INCREMENT,
        status_name VARCHAR(20) NOT NULL UNIQUE,
        PRIMARY KEY (status_id),
        CONSTRAINT unique_status UNIQUE (status_name),  
        CONSTRAINT monitor_status CHECK (status_name IN ('awaiting', 'fulfilled', 'cancelled'))
);

-- Main Table

CREATE TABLE IF NOT EXISTS orders (
        order_id INTEGER NOT NULL AUTO_INCREMENT,
        created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        user_id INTEGER NOT NULL,
        status_id INTEGER NOT NULL,
        PRIMARY KEY (order_id),
        CONSTRAINT order_users FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE, 
        CONSTRAINT order_status FOREIGN KEY (status_id) REFERENCES order_status (status_id) ON UPDATE CASCADE
);

-- Items

CREATE TABLE IF NOT EXISTS order_items (
        items_id INTEGER NOT NULL AUTO_INCREMENT,
        order_id INTEGER NOT NULL,
        product_id INTEGER NOT NULL,
        sku VARCHAR(50) NOT NULL, -- Mapping for warehouse?
        qty INTEGER NOT NULL CHECK (qty > 0),
        warehouse_id INTEGER NOT NULL,
        PRIMARY KEY (items_id),
        CONSTRAINT distinct_complete UNIQUE (order_id, sku, warehouse_id),
        CONSTRAINT item_order FOREIGN KEY (order_id) REFERENCES orders(order_id) ON UPDATE CASCADE,
        CONSTRAINT item_product FOREIGN KEY (product_id) REFERENCES products (product_id) ON UPDATE CASCADE, 
        CONSTRAINT links FOREIGN KEY (warehouse_id, sku) REFERENCES warehouse(warehouse_id, sku) ON UPDATE CASCADE -- Link to Warehouse? 
);

COMMIT;
