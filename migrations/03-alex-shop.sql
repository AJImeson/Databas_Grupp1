-- webshop with many products and different categories
-- table 1: products
-- product_id, name, description, sku, selling_price, wholesale_cost, manifacturer_id

-- table 2 manifacturers: manifacturer_id, name, country, adress, city, zip, contact_person_id 

-- table 3 contact_person_details: contact_person_id, first_name, last_name, email, phone, title 
SET autocommit = 0;
CREATE TABLE IF NOT EXISTS products (
    product_id INTEGER NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(60) NOT NULL,
    SKU VARCHAR(8) NOT NULL UNIQUE,
    selling_price FLOAT NOT NULL,
    wholesale_cost FLOAT NOT NULL,
    manifacturer_id INTEGER NOT NULL,
    PRIMARY KEY (product_id)
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
