
USE ace_ventura;

-- User Trigger Table

CREATE TABLE IF NOT EXISTS activities (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(30) NOT NULL,
    record_id INT NOT NULL,
    modification ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    former_value TEXT,
    modified_value TEXT,
    changed_by VARCHAR(100),
    changed_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

