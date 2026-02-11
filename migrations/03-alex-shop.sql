USE ace_ventura;
<<<<<<< HEAD
=======

>>>>>>> 25b2b71 (tog bort SET FOREIGN_KEY_CHECKS = 0;)

-- table contact_person_id
SET autocommit = 0;
CREATE TABLE IF NOT EXISTS contact_person_details (
    contact_person_id INTEGER NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    email VARCHAR(40) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    title VARCHAR(40) NOT NULL,
    PRIMARY KEY (contact_person_id)
);
COMMIT;

-- table for manufacturers
SET autocommit = 0;
CREATE TABLE IF NOT EXISTS manufacturers (
    manufacturer_id INTEGER NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    country VARCHAR(20) NOT NULL,
    adress VARCHAR(25) NOT NULL,
    city VARCHAR(25) NOT NULL,
    zip VARCHAR(10) NOT NULL,
    contact_person_id INTEGER NOT NULL,
    PRIMARY KEY (manufacturer_id),
    FOREIGN KEY (contact_person_id) REFERENCES contact_person_details (contact_person_id) ON DELETE RESTRICT ON UPDATE CASCADE
);
COMMIT;

-- table for products
SET autocommit = 0;
CREATE TABLE IF NOT EXISTS products (
    product_id INTEGER NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(200) NOT NULL,
    recommended_price DECIMAL(10,2) NOT NULL,
    manufacturer_id INTEGER NOT NULL,
    PRIMARY KEY (product_id),
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturers (manufacturer_id) ON DELETE RESTRICT ON UPDATE CASCADE
);
COMMIT;

-- table for sizes, support product_description table.
SET autocommit = 0;
CREATE TABLE IF NOT EXISTS sizes (
    size_id INTEGER NOT NULL AUTO_INCREMENT,
    size VARCHAR (12) NOT NULL CHECK (size IN ('onesize', 'xs', 's', 'm', 'l', 'xl', 'xxl', 'xxxl', 'xxxxl')),
    PRIMARY KEY (size_id)
);
COMMIT;

-- table for materials
SET autocommit = 0;
CREATE TABLE IF NOT EXISTS materials (
    material_id INTEGER NOT NULL AUTO_INCREMENT,
    material VARCHAR(25) NOT NULL CHECK (material IN ('mechanical', 'cotton', 'wool', 'leather')),
    PRIMARY KEY (material_id)
);
COMMIT;

-- table for colours
CREATE TABLE IF NOT EXISTS colours (
    colour_id INTEGER NOT NULL AUTO_INCREMENT,
    colour VARCHAR(10) NOT NULL CHECK (colour IN ('blue', 'green', 'red', 'grey')),
    PRIMARY KEY (colour_id)
);
COMMIT;

-- table for instructions
SET autocommit = 0;
CREATE TABLE IF NOT EXISTS instructions (
    instruction_id INTEGER NOT NULL AUTO_INCREMENT,
    machinewash BOOLEAN NOT NULL CHECK (machinewash IN (TRUE, FALSE)),
    PRIMARY KEY (instruction_id)
);
COMMIT;

-- Workhorse table product_description
SET autocommit = 0;
CREATE TABLE IF NOT EXISTS product_description (
    product_description_id INTEGER NOT NULL AUTO_INCREMENT,
    product_id INTEGER NOT NULL,
    size_id INTEGER NOT NULL,
    colour_id INTEGER NOT NULL,
    material_id INTEGER NOT NULL,
    instruction_id INTEGER NOT NULL,
    PRIMARY KEY (product_description_id),
    FOREIGN KEY (size_id) REFERENCES sizes (size_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (colour_id) REFERENCES colours (colour_id) ON UPDATE CASCADE,
    FOREIGN KEY (material_id) REFERENCES materials (material_id) ON UPDATE CASCADE,
    FOREIGN KEY (instruction_id) REFERENCES instructions (instruction_id) ON UPDATE CASCADE
);
COMMIT;

-- table for product_information
SET autocommit = 0;
CREATE TABLE IF NOT EXISTS product_information (
    product_information_id INTEGER NOT NULL AUTO_INCREMENT,
    product_description_id INTEGER NOT NULL UNIQUE,
    product_id INTEGER NOT NULL,
    sku VARCHAR(8) NOT NULL,
    wholesale_cost DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (product_information_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (product_description_id) REFERENCES product_description (product_description_id) ON UPDATE CASCADE
);
COMMIT;



-- Insert for contact_person_id
SET autocommit = 0;
INSERT INTO contact_person_details (first_name, last_name, email, phone, title) VALUES
('Ace', 'Ventura', 'ace.ventura@petdetective.se', '0701234567', 'master of animals'),
('Alexander', 'Piensoho', 'alexander.piensoho@grupp1.se', '0701345678', 'Cheif technical shitstorm'),
('Said', 'Borna', 'said.borna@grupp1.se', '0731234567', 'Head of Vibe coding'),
('Axel', 'Imse', 'axel.imse@grupp1.se', '0707654321', 'Head of Scotland')
;
COMMIT;


-- insert for manufacturers
SET autocommit = 0;
INSERT INTO manufacturers (name, country, adress, city, zip, contact_person_id) VALUES
('Petdetectives INC', 'USA', 'vetura street 113', 'Johns Creek', '12345', 1),
('Dogs & Cats AB', 'Sweden', 'hundgatan 1337', 'flen', '14452', 2),
('HamsterAI INC', 'Dubai', 'gemeni street 2', 'AI city', '11122', 3),
('Scotland sheep LTD', 'Scotland', 'sheep street 5', 'sheeptown', '22244', 4)
;
COMMIT;


-- inserts for products
SET autocommit = 0;
INSERT INTO products (name, description, recommended_price, manufacturer_id) VALUES
('Mechanical rhino', 'Mechanical rhino that helps you spy on people', 60000, 1),
('Taxidermy dog', 'Get your old dog back to life with taxidermy!', 599, 2),
('AI driven hamster', 'hamster that can code your next app!', 3999, 3),
('Sheep fur', 'The finest sheep fur in all of Scotland', 19990, 4)
;
COMMIT;


-- inserts for sizes
SET autocommit = 0;
INSERT INTO sizes (size) VALUES
('onesize'),
('xs'),
('s'),
('m'),
('l'),
('xl'),
('xxl'),
('xxxl'),
('xxxxl')
;
COMMIT;

-- inserts for materials
INSERT INTO materials (material) VALUES
('mechanical'),
('cotton'),
('wool'),
('leather')
;
COMMIT;


-- Inserts for colours
SET autocommit = 0;
INSERT INTO colours (colour) VALUES
('blue'),
('green'),
('red'),
('grey')
;
COMMIT;

-- inserts for instructions
SET autocommit = 0;
INSERT INTO instructions (machinewash) VALUES
(TRUE),
(FALSE)
;
COMMIT;

-- inserts for product_description
SET autocommit = 0;
INSERT INTO product_description (product_id, size_id, colour_id, material_id, instruction_id) VALUES
(1, 1, 4, 1, 2),
(2, 3, 1, 2, 1),
(2, 4, 2, 2, 1),
(3, 1, 1, 4, 2),
(4, 1, 4, 3, 2)
;
COMMIT;


-- inserts for product_information
SET autocommit = 0;
INSERT INTO product_information (product_description_id, product_id, sku, wholesale_cost) VALUES
(1, 1, 'TOY001', 30000),
(2, 2, 'SER001', 199),
(3, 2, 'SER002', 199),
(4, 3, 'VIB001', 1799),
(5, 4, 'FUR001', 11990)
;
COMMIT;


