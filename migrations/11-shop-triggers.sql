-- Shop Triggers

USE ace_ventura;

DELIMITER //

-- Contact Person Details

-- Insert
CREATE TRIGGER contact_person_details_insert
AFTER INSERT ON contact_person_details
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, modified_value, changed_by)
    VALUES (NEW.contact_person_id, 'INSERT', CONCAT(NEW.first_name, ' ', NEW.last_name, ' (', NEW.title, ')'), USER());
END; //

-- Update
CREATE TRIGGER contact_person_details_update
AFTER UPDATE ON contact_person_details
FOR EACH ROW
BEGIN
    -- First name
    IF OLD.first_name <> NEW.first_name THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.contact_person_id, 'UPDATE', OLD.first_name, NEW.first_name, USER());
    END IF;

    -- Last Name
    IF OLD.last_name <> NEW.last_name THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.contact_person_id, 'UPDATE', OLD.last_name, NEW.last_name, USER());
    END IF;

    -- Email
    IF OLD.email <> NEW.email THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.contact_person_id, 'UPDATE', OLD.email, NEW.email, USER());
    END IF;

    -- Phone
    IF OLD.phone <> NEW.phone THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.contact_person_id, 'UPDATE', OLD.phone, NEW.phone, USER());
    END IF;

    -- Title
    IF OLD.title <> NEW.title THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.contact_person_id, 'UPDATE', OLD.title, NEW.title, USER());
    END IF;
END; //

-- Delete
CREATE TRIGGER contact_person_details_delete
BEFORE DELETE ON contact_person_details
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, former_value, changed_by)
    VALUES (OLD.contact_person_id, 'DELETE', OLD.email, USER());
END; //

-- Manufacturers

-- Insert
CREATE TRIGGER manufacturers_insert
AFTER INSERT ON manufacturers
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, modified_value, changed_by)
    VALUES (NEW.manufacturer_id, 'INSERT', CONCAT(NEW.name, ' - ', NEW.city), USER());
END; //

-- Update
CREATE TRIGGER manufacturers_update
AFTER UPDATE ON manufacturers
FOR EACH ROW
BEGIN
    -- Name
    IF OLD.name <> NEW.name THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.manufacturer_id, 'UPDATE', OLD.name, NEW.name, USER());
    END IF;

    -- Country
    IF OLD.country <> NEW.country THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.manufacturer_id, 'UPDATE', OLD.country, NEW.country, USER());
    END IF;

    -- Adress
    IF OLD.adress <> NEW.adress THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.manufacturer_id, 'UPDATE', OLD.adress, NEW.adress, USER());
    END IF;

    -- City
    IF OLD.city <> NEW.city THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.manufacturer_id, 'UPDATE', OLD.city, NEW.city, USER());
    END IF;

    -- Zip/Postal code
    IF OLD.zip <> NEW.zip THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.manufacturer_id, 'UPDATE', OLD.zip, NEW.zip, USER());
    END IF;

    -- Contact
    IF OLD.contact_person_id <> NEW.contact_person_id THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.manufacturer_id, 'UPDATE', CAST(OLD.contact_person_id AS CHAR), CAST(NEW.contact_person_id AS CHAR), USER());
    END IF;
END; //

-- Delete
CREATE TRIGGER manufacturers_delete
BEFORE DELETE ON manufacturers
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, former_value, changed_by)
    VALUES (OLD.manufacturer_id, 'DELETE', CONCAT('Name: ', OLD.name, ' | City: ', OLD.city), USER());
END; //

-- Products

-- Insert
CREATE TRIGGER products_insert
AFTER INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, modified_value, changed_by)
    VALUES (NEW.product_id, 'INSERT', NEW.name, USER());
END; //

-- Update
CREATE TRIGGER products_update
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    -- Name
    IF OLD.name <> NEW.name THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.product_id, 'UPDATE', OLD.name, NEW.name, USER());
    END IF;

    -- Description
    IF OLD.description <> NEW.description THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.product_id, 'UPDATE', OLD.description, NEW.description, USER());
    END IF;

    -- Recommended Price
    IF OLD.recommended_price <> NEW.recommended_price THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.product_id, 'UPDATE', CAST(OLD.recommended_price AS CHAR), CAST(NEW.recommended_price AS CHAR), USER());
    END IF;

    -- Manufacturer id
    IF OLD.manufacturer_id <> NEW.manufacturer_id THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.product_id, 'UPDATE', CAST(OLD.manufacturer_id AS CHAR), CAST(NEW.manufacturer_id AS CHAR), USER());
    END IF;
END; //

-- Products Delete
CREATE TRIGGER products_delete
BEFORE DELETE ON products
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, former_value, changed_by)
    VALUES (OLD.product_id, 'DELETE', CONCAT('Name: ', OLD.name, ' | Price: ', OLD.recommended_price), USER());
END; //

-- Product Information

-- Insert

CREATE TRIGGER product_information_insert
AFTER INSERT ON product_information
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, modified_value, changed_by)
    VALUES (NEW.product_information_id, 'INSERT', NEW.sku, USER());
END; //

-- Update

CREATE TRIGGER product_information_update
AFTER UPDATE ON product_information
FOR EACH ROW
BEGIN
    -- Sku
    IF OLD.sku <> NEW.sku THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.product_information_id, 'UPDATE', OLD.sku, NEW.sku, USER());
    END IF;

    -- Wholesale cost
    IF OLD.wholesale_cost <> NEW.wholesale_cost THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.product_information_id, 'UPDATE', CAST(OLD.wholesale_cost AS CHAR), CAST(NEW.wholesale_cost AS CHAR), USER());
    END IF;

    -- Product id
    IF OLD.product_id <> NEW.product_id THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.product_information_id, 'UPDATE', CAST(OLD.product_id AS CHAR), CAST(NEW.product_id AS CHAR), USER());
    END IF;
END; //

-- Delete
CREATE TRIGGER product_information_delete
BEFORE DELETE ON product_information
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, former_value, changed_by)
    VALUES (OLD.product_information_id, 'DELETE', CONCAT('SKU: ', OLD.sku, ' | Cost: ', OLD.wholesale_cost), USER());
END; //

-- Product Description

-- Insert
CREATE TRIGGER product_description_insert
AFTER INSERT ON product_description
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, modified_value, changed_by)
    VALUES (NEW.product_description_id, 'INSERT',
            CONCAT('P_ID:', NEW.product_id, ' | S_ID:', NEW.size_id, ' | C_ID:', NEW.colour_id), USER());
END; //

-- Update
CREATE TRIGGER product_description_update
AFTER UPDATE ON product_description
FOR EACH ROW
BEGIN
    -- Product id
    IF OLD.product_id <> NEW.product_id THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.product_description_id, 'UPDATE', CAST(OLD.product_id AS CHAR), CAST(NEW.product_id AS CHAR), USER());
    END IF;

    -- Size
    IF OLD.size_id <> NEW.size_id THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.product_description_id, 'UPDATE', CAST(OLD.size_id AS CHAR), CAST(NEW.size_id AS CHAR), USER());
    END IF;

    -- Colour
    IF OLD.colour_id <> NEW.colour_id THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.product_description_id, 'UPDATE', CAST(OLD.colour_id AS CHAR), CAST(NEW.colour_id AS CHAR), USER());
    END IF;

    -- Material
    IF OLD.material_id <> NEW.material_id THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.product_description_id, 'UPDATE', CAST(OLD.material_id AS CHAR), CAST(NEW.material_id AS CHAR), USER());
    END IF;

    -- Instruction
    IF OLD.instruction_id <> NEW.instruction_id THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.product_description_id, 'UPDATE', CAST(OLD.instruction_id AS CHAR), CAST(NEW.instruction_id AS CHAR), USER());
    END IF;
END; //

-- Delete
CREATE TRIGGER product_description_delete
BEFORE DELETE ON product_description
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, former_value, changed_by)
    VALUES (OLD.product_description_id, 'DELETE', CONCAT('P_ID:', OLD.product_id, ' | S_ID:', OLD.size_id), USER());
END; //

-- Sizes

-- Sizes Inserts
CREATE TRIGGER sizes_insert
AFTER INSERT ON sizes
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, modified_value, changed_by)
    VALUES (NEW.size_id, 'INSERT', NEW.size, USER());
END; //

-- Materials Insert
CREATE TRIGGER materials_insert
AFTER INSERT ON materials
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, modified_value, changed_by)
    VALUES (NEW.material_id, 'INSERT', NEW.material, USER());
END; //

-- Colours Insert
CREATE TRIGGER colours_insert
AFTER INSERT ON colours
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, modified_value, changed_by)
    VALUES (NEW.colour_id, 'INSERT', NEW.colour, USER());
END; //

-- Instructions Insert
CREATE TRIGGER instructions_insert
AFTER INSERT ON instructions
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, modified_value, changed_by)
    VALUES (NEW.instruction_id, 'INSERT', IF(NEW.machinewash, 'True', 'False'), USER());
END; //

-- Update
CREATE TRIGGER sizes_update
AFTER UPDATE ON sizes
FOR EACH ROW
BEGIN
    IF OLD.size <> NEW.size THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.size_id, 'UPDATE', OLD.size, NEW.size, USER());
    END IF;
END; //

-- Delete
CREATE TRIGGER sizes_delete
BEFORE DELETE ON sizes
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, former_value, changed_by)
    VALUES (OLD.size_id, 'DELETE', OLD.size, USER());
END; //

-- Materials

-- Update
CREATE TRIGGER materials_update
AFTER UPDATE ON materials
FOR EACH ROW
BEGIN
    IF OLD.material <> NEW.material THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.material_id, 'UPDATE', OLD.material, NEW.material, USER());
    END IF;
END; //

-- Delete
CREATE TRIGGER materials_delete
BEFORE DELETE ON materials
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, former_value, changed_by)
    VALUES (OLD.material_id, 'DELETE', OLD.material, USER());
END; //

-- Colours

-- Update
CREATE TRIGGER colours_update
AFTER UPDATE ON colours
FOR EACH ROW
BEGIN
    IF OLD.colour <> NEW.colour THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.colour_id, 'UPDATE', OLD.colour, NEW.colour, USER());
    END IF;
END; //

-- Delete
CREATE TRIGGER colours_delete
BEFORE DELETE ON colours
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, former_value, changed_by)
    VALUES (OLD.colour_id, 'DELETE', OLD.colour, USER());
END; //

-- Instructions

-- Update
CREATE TRIGGER instructions_update
AFTER UPDATE ON instructions
FOR EACH ROW
BEGIN
    IF OLD.machinewash <> NEW.machinewash THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.instruction_id, 'UPDATE', IF(OLD.machinewash, 'True', 'False'), IF(NEW.machinewash, 'True', 'False'), USER());
    END IF;
END; //

-- Delete
CREATE TRIGGER instructions_delete
BEFORE DELETE ON instructions
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, former_value, changed_by)
    VALUES (OLD.instruction_id, 'DELETE', IF(OLD.machinewash, 'True', 'False'), USER());
END; //

DELIMITER ;
