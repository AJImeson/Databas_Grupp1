
SET autocommit = 0;
CREATE TABLE IF NOT EXISTS products (
    product_id INTEGER NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(60) NOT NULL,
    selling_price FLOAT NOT NULL,
    manifacturer_id INTEGER NOT NULL,
    PRIMARY KEY (product_id)
);
COMMIT;

SET autocommit = 0;
CREATE TABLE IF NOT EXISTS product_information (
    product_information_id INTEGER NOT NULL AUTO_INCREMENT,
    product_id INTEGER NOT NULL,
    sku VARCHAR(8),
    wholesale_cost FLOAT NOT NULL,
    PRIMARY KEY (product_information_id)
);
COMMIT;


SET autocommit = 0;
CREATE TABLE IF NOT EXISTS product_description (
    product_description_id INTEGER NOT NULL AUTO_INCREMENT,
    product_id INTEGER NOT NULL,
    size VARCHAR(9) NOT NULL,
    colour VARCHAR(15) NOT NULL,
    material VARCHAR(20) NOT NULL,
    instructions VARCHAR(50) NOT NULL,
    PRIMARY KEY (product_description_id)
);
COMMIT;


SET autocommit = 0;
CREATE TABLE IF NOT EXISTS manifacturers (
    manifacturer_id INTEGER NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    country VARCHAR(20) NOT NULL,
    adress VARCHAR(25) NOT NULL,
    city VARCHAR(25) NOT NULL,
    zip INTEGER NOT NULL,
    contact_person_id INTEGER NOT NULL,
    PRIMARY KEY (manifacturer_id)
);
COMMIT;


SET autocommit = 0;
CREATE TABLE IF NOT EXISTS contact_person_details (
    contact_person_id INTEGER NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    email VARCHAR(40) NOT NULL UNIQUE,
    phone INTEGER NOT NULL,
    title VARCHAR(40) NOT NULL,
    PRIMARY KEY (contact_person_id)
);
COMMIT;
