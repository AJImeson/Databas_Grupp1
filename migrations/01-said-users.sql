
-- =============================================
-- USERS 5.2(2.1-2)
-- Ansvarig: Said
-- =============================================

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    email_confirmed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE addresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    address_type VARCHAR(20) NOT NULL,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) DEFAULT 'Sweden',
    FOREIGN KEY  (user_id) REFERENCES users(id)
);

-- =============================================
-- TEST DATA
-- =============================================

INSERT INTO users (username, password_hash, email, email_confirmed) VALUES
('said', 'pwd123', 'said@chasacademy.se', TRUE),
('axel', 'pwd123', 'axel@chasacademy.se', TRUE),
('mika', 'pwd123', 'mika@chasacademy.se', FALSE),
('alexander', 'pwd123', 'alexander@chasacademy.se', TRUE),
('cebrail', 'pwd123', 'cebrail@chasacademy.se', TRUE);
