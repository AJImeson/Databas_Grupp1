-- =============================================
-- PETS 5.3(3.1-4)
-- Ansvarig: Mika
-- =============================================

USE ace_ventura;
SET FOREIGN_KEY_CHECKS = 0;

-- Skapa tabellen för arter
SET autocommit = 0;
CREATE TABLE species (
    species_id INT AUTO_INCREMENT PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    latin_name VARCHAR(100) NOT NULL
);
COMMIT;

-- Skapa tabellen för husdjur
SET autocommit = 0;
CREATE TABLE pets (
    pet_id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id INT NOT NULL, -- Tänkte länka till User-tabellen
    species_id INT NOT NULL, -- Länkar detta till Species-tabellen
    given_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    description TEXT,
    is_alive BOOLEAN DEFAULT 1, -- 1 för levande, 0 för avlidna
    FOREIGN KEY (species_id) REFERENCES species (species_id),
    FOREIGN KEY (owner_id) REFERENCES users (users_id)
);
COMMIT;

-- Testdata för arter (5.3.1)
SET autocommit = 0;
INSERT INTO species (common_name, latin_name) VALUES
('Hund', 'Canis Familiaris'),
('Katt', 'Felis Catus'),
('Tiger', 'Panthera tigris')
;
COMMIT;
-- Testdata för husdjur (5.3.2-5.3.4)
SET autocommit = 0;
INSERT INTO pets (owner_id, species_id, given_name, date_of_birth, description, is_alive)
VALUES (1, 1, 'Nalle', '2022-05-16', 'En busig retriever.', 1)
;
COMMIT;
SET FOREIGN_KEY_CHECKS = 1;

