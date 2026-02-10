-- =============================================
-- PETS 5.3(3.1-4)
-- Ansvarig: Mika
-- =============================================

USE ace_ventura;

-- Skapa tabellen för arter
START TRANSACTION;

CREATE TABLE species (
    id INT AUTO_INCREMENT PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    latin_name VARCHAR(100) NOT NULL
);

-- Skapa tabellen för husdjur
CREATE TABLE pets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id INT NOT NULL, -- Tänkte länka till User-tabellen
    species_id INT NOT NULL, -- Länkar detta till Species-tabellen
    given_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    description TEXT,
    is_alive BOOLEAN DEFAULT 1, -- 1 för levande, 0 för avlidna
    FOREIGN KEY (species_id) REFERENCES species (id),
    FOREIGN KEY (owner_id) REFERENCES users (id)
);

-- Testdata för arter (5.3.1)
INSERT INTO species (common_name, latin_name) VALUES
('Hund', 'Canis Familiaris'),
('Katt', 'Felis Catus'),
('Tiger', 'Panthera tigris')
;

-- Testdata för husdjur (5.3.2-5.3.4)
INSERT INTO pets (owner_id, species_id, given_name, date_of_birth, description, is_alive)
VALUES (1, 1, 'Nalle', '2022-05-16', 'En busig retriever.', 1)
;
COMMIT;
