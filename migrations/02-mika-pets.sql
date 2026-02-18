-- =============================================
-- PETS 5.3(3.1-4)
-- Ansvarig: Mika
-- =============================================

USE ace_ventura;

-- Skapar art-tabellen nu utan namn
SET autocommit = 0;
CREATE TABLE IF NOT EXISTS species (
    species_id INT AUTO_INCREMENT PRIMARY KEY,
);
COMMIT;

-- Tabellen för vanliga namn (kan ha flera namn)
CREATE TABLE IF NOT EXISTS species_common_names (
name_id INT AUTO_INCREMENT PRIMARY KEY,
species_id INT NOT NULL,
common_name VARCHAR(100) NOT NULL,
FOREIGN KEY (species_id) REFERENCES species (species_id) ON DELETE CASCADE
);

-- Tabellen för latinska namn (kan ha flera namn)
CREATE TABLE IF NOT EXISTS species_latin_names (
name_id INT AUTO_INCREMENT PRIMARY KEY,
species_id INT NOT NULL,
latin_name VARCHAR(100) NOT NULL,
FOREIGN KEY (species_id) REFERENCES species (species_id) ON DELETE CASCADE
);

-- Skapa tabellen för husdjur
SET autocommit = 0;
CREATE TABLE IF NOT EXISTS pets (
    pet_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL, -- Tänkte länka till User-tabellen
    species_id INT NOT NULL, -- Länkar detta till Species-tabellen
    given_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    description TEXT,
    is_alive BOOLEAN DEFAULT 1, -- 1 för levande, 0 för avlidna
    FOREIGN KEY (species_id) REFERENCES species (species_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);
COMMIT;

-- Testdata för arter (5.3.1)
SET autocommit = 0;
INSERT INTO species () VALUES ();

INSERT INTO species_common_names (species_id, common_name) VALUES
(LAST_INSERT_ID(), 'Hund'),
(LAST_INSERT_ID(), 'Voffsis'),
(LAST_INSERT_ID(), 'Katt'),
(LAST_INSERT_ID(), 'kissemiss')
;

INSERT INTO species_latin_names (species_id, latin_name) VALUES
(LAST_INSERT_ID(), 'Canis lupus familiaris'),
(LAST_INSERT_ID(), 'Canis familiaris'),
(LAST_INSERT_ID(), 'Felis catus')
(LAST_INSERT_ID(), 'Felis silvestris catus')
;

COMMIT;

-- Testdata för husdjur (5.3.2-5.3.4)
SET autocommit = 0;
INSERT INTO pets (user_id, species_id, given_name, date_of_birth, description, is_alive)
VALUES (1, 1, 'Nalle', '2022-05-16', 'En busig retriever.', 1)
;
COMMIT;
SET FOREIGN_KEY_CHECKS = 1;

