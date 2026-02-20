
USE ace_ventura;

-- Trigger Tables

-- Users

CREATE TABLE IF NOT EXISTS user_activities (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    modification ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    former_value TEXT,
    modified_value TEXT,
    changed_by VARCHAR(100),
    changed_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Pets

CREATE TABLE IF NOT EXISTS pets_activities(
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    pet_id INT NOT NULL,
    modification ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    former_value TEXT,
    modified_value TEXT,
    changed_by VARCHAR(100),
    changed_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Shop

CREATE TABLE IF NOT EXISTS shop_activities(
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    shop_id INT NOT NULL,
    modification ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    former_value TEXT,
    modified_value TEXT,
    changed_by VARCHAR(100),
    changed_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Warehouse

CREATE TABLE IF NOT EXISTS warehouse_activities(
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    warehouse_id INT NOT NULL,
    modification ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    former_value TEXT,
    modified_value TEXT,
    changed_by VARCHAR(100),
    changed_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Orders

CREATE TABLE IF NOT EXISTS orders_activities(
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    orders_id INT NOT NULL,
    modification ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    former_value TEXT,
    modified_value TEXT,
    changed_by VARCHAR(100),
    changed_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Social

CREATE TABLE IF NOT EXISTS social_activities( 
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    social_id INT NOT NULL,
    modification ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    former_value TEXT,
    modified_value TEXT,
    changed_by VARCHAR(100),
    changed_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
