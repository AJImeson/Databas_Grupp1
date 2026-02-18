-- Pets Triggers

USE ace_ventura;

DELIMITER //

-- Insert

CREATE TRIGGER species_insert
AFTER INSERT ON species
FOR EACH ROW
BEGIN
    INSERT INTO activities (table_name, record_id, modification, modified_value, changed_by)
    VALUES ('species', NEW.species_id, 'INSERT', NEW.common_name, USER());
END; //

CREATE TRIGGER pets_insert
AFTER INSERT ON pets
FOR EACH ROW
BEGIN
    INSERT INTO activities (table_name, record_id, modification, modified_value, changed_by)
    VALUES ('pets', NEW.pet_id, 'INSERT', NEW.given_name, USER());
END; //

-- Update

CREATE TRIGGER pets_update
AFTER UPDATE ON pets
FOR EACH ROW
BEGIN
    IF OLD.given_name <> NEW.given_name THEN
        INSERT INTO activities (table_name, record_id, modification, former_value, modified_value, changed_by)
        VALUES ('pets', OLD.pet_id, 'UPDATE', OLD.given_name, NEW.given_name, USER());
    END IF;

    IF OLD.user_id <> NEW.user_id THEN
        INSERT INTO activities (table_name, record_id, modification, former_value, modified_value, changed_by)
        VALUES ('pets', OLD.pet_id, 'UPDATE', CAST(OLD.user_id AS CHAR), CAST(NEW.user_id AS CHAR), USER());
    END IF;

    IF OLD.is_alive <> NEW.is_alive THEN
        INSERT INTO activities (table_name, record_id, modification, former_value, modified_value, changed_by)
        VALUES ('pets', OLD.pet_id, 'UPDATE', IF(OLD.is_alive, '1', '0'), IF(NEW.is_alive, '1', '0'), USER());
    END IF;
END; //

-- Delete

CREATE TRIGGER pets_delete
BEFORE DELETE ON pets
FOR EACH ROW
BEGIN
    INSERT INTO activities (table_name, record_id, modification, former_value, changed_by)
    VALUES ('pets', OLD.pet_id, 'DELETE', OLD.given_name, USER());
END; //

DELIMITER ;
