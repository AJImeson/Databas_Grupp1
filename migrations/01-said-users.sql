
-- =============================================
-- USERS 5.2(2.1-2)
-- Ansvarig: Said
-- =============================================

USE ace_ventura;
SET FOREIGN_KEY_CHECKS = 0;

SET autocommit = 0;
CREATE TABLE users (
    users_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    email_confirmed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
COMMIT;

SET autocommit = 0;
CREATE TABLE addresses (
    addresses_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    address_type VARCHAR(20) NOT NULL,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) DEFAULT 'Sweden',
    FOREIGN KEY (user_id) REFERENCES users (users_id)
);
COMMIT;

-- =============================================
-- TEST DATA
-- =============================================
SET autocommit = 0;
INSERT INTO users (username, password_hash, email, email_confirmed) VALUES
('said', 'pwd123', 'said@chasacademy.se', TRUE),
('axel', 'pwd123', 'axel@chasacademy.se', TRUE),
('mika', 'pwd123', 'mika@chasacademy.se', FALSE),
('alexander', 'pwd123', 'alexander@chasacademy.se', TRUE),
('cebrail', 'pwd123', 'cebrail@chasacademy.se', TRUE);
COMMIT;

SET autocommit = 0;
INSERT INTO addresses (user_id, address_type, street, city, postal_code) VALUES
(1, 'billing', 'Rinkebystråket 15', 'Rinkeby', '16373'),
(1, 'delivery', 'Rinkebystråket 15', 'Rinkeby', '16373'),
(2, 'billing', 'Rosengård Centrum 8', 'Malmö', '21437'),
(2, 'delivery', 'Ramels väg 12', 'Rosengård', '21434'),
(3, 'billing', 'Hammarkulletorget 3', 'Göteborg', '42437'),
(3, 'delivery', 'Hammarkulletorget 3', 'Göteborg', '42437'),
(4, 'billing', 'Hovsjövägen 22', 'Södertälje', '15165'),
(4, 'delivery', 'Fittja Gårdsväg 6', 'Botkyrka', '14571'),
(5, 'billing', 'Tenstagången 9', 'Tensta', '16364'),
(5, 'delivery', 'Tenstagången 9', 'Tensta', '16364');
COMMIT;
SET FOREIGN_KEY_CHECKS = 1;

