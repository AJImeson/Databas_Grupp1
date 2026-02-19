-- Shop Triggers

USE ace_ventura;

DELIMITER //

-- Contact Person Details

CREATE TRIGGER contact_person_details_insert
AFTER INSERT ON contact_person_details
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, modified_value, changed_by)
    VALUES (NEW.contact_person_id, 'INSERT', NEW.email, USER());
END; //

CREATE TRIGGER contact_person_details_update
AFTER UPDATE ON contact_person_details
FOR EACH ROW
BEGIN
    IF OLD.email <> NEW.email THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.contact_person_id, 'UPDATE', OLD.email, NEW.email, USER());
    END IF;

    IF OLD.phone <> NEW.phone THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.contact_person_id, 'UPDATE', OLD.phone, NEW.phone, USER());
    END IF;
END; //

CREATE TRIGGER contact_person_details_delete
BEFORE DELETE ON contact_person_details
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, former_value, changed_by)
    VALUES (OLD.contact_person_id, 'DELETE', OLD.email, USER());
END; //

-- Manufacturers

CREATE TRIGGER manufacturers_insert
AFTER INSERT ON manufacturers
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, modified_value, changed_by)
    VALUES (NEW.manufacturer_id, 'INSERT', NEW.name, USER());
END; //

CREATE TRIGGER manufacturers_update
AFTER UPDATE ON manufacturers
FOR EACH ROW
BEGIN
    IF OLD.contact_person_id <> NEW.contact_person_id THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.manufacturer_id, 'UPDATE', CAST(OLD.contact_person_id AS CHAR), CAST(NEW.contact_person_id AS CHAR), USER());
    END IF;
END; //

-- Products

CREATE TRIGGER products_insert
AFTER INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, modified_value, changed_by)
    VALUES (NEW.product_id, 'INSERT', NEW.name, USER());
END; //

CREATE TRIGGER products_update
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    IF OLD.recommended_price <> NEW.recommended_price THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.product_id, 'UPDATE', CAST(OLD.recommended_price AS CHAR), CAST(NEW.recommended_price AS CHAR), USER());
    END IF;
END; //

-- Product Information

CREATE TRIGGER product_information_insert
AFTER INSERT ON product_information
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, modified_value, changed_by)
    VALUES (NEW.product_information_id, 'INSERT', NEW.sku, USER());
END; //

CREATE TRIGGER product_information_update
AFTER UPDATE ON product_information
FOR EACH ROW
BEGIN
    IF OLD.wholesale_cost <> NEW.wholesale_cost THEN
        INSERT INTO shop_activities (shop_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.product_information_id, 'UPDATE', CAST(OLD.wholesale_cost AS CHAR), CAST(NEW.wholesale_cost AS CHAR), USER());
    END IF;
END; //

-- Lookup Tables Inserts 

CREATE TRIGGER sizes_insert
AFTER INSERT ON sizes
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, modified_value, changed_by)
    VALUES (NEW.size_id, 'INSERT', NEW.size, USER());
END; //

CREATE TRIGGER materials_insert
AFTER INSERT ON materials
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, modified_value, changed_by)
    VALUES (NEW.material_id, 'INSERT', NEW.material, USER());
END; //

CREATE TRIGGER colours_insert
AFTER INSERT ON colours
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, modified_value, changed_by)
    VALUES (NEW.colour_id, 'INSERT', NEW.colour, USER());
END; //

CREATE TRIGGER instructions_insert
AFTER INSERT ON instructions
FOR EACH ROW
BEGIN
    INSERT INTO shop_activities (shop_id, modification, modified_value, changed_by)
    VALUES (NEW.instruction_id, 'INSERT', IF(NEW.machinewash, 'True', 'False'), USER());
END; //

DELIMITER ;
