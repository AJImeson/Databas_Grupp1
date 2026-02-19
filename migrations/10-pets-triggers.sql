USE ace_ventura;

DELIMITER //

-- Pets

-- Species Triggers

-- Species ID  
CREATE TRIGGER species_insert
AFTER INSERT ON species
FOR EACH ROW	
BEGIN
    INSERT INTO pets_activities (pets_id, modification, modified_value, changed_by)
    VALUES (NEW.species_id, 'INSERT', 'New Species Record Created', USER());
END; //

-- Species Common Name
CREATE TRIGGER species_common_name_insert
AFTER INSERT ON species_common_names
FOR EACH ROW
BEGIN
    INSERT INTO pets_activities (pets_id, modification, modified_value, changed_by)
    VALUES (NEW.species_id, 'INSERT', CONCAT('Common Name: ', NEW.common_name), USER());
END; //

-- Species Latin Name
CREATE TRIGGER species_latin_name_insert
AFTER INSERT ON species_latin_names
FOR EACH ROW
BEGIN
    INSERT INTO pets_activities (pets_id, modification, modified_value, changed_by)
    VALUES (NEW.species_id, 'INSERT', CONCAT('Latin Name: ', NEW.latin_name), USER());
END; //

-- Pets Triggers

-- Insert
CREATE TRIGGER pets_insert
AFTER INSERT ON pets
FOR EACH ROW
BEGIN
    INSERT INTO pets_activities (pets_id, modification, modified_value, changed_by)
    VALUES (NEW.pet_id, 'INSERT', CONCAT('Name: ', NEW.given_name, ' | Species ID: ', NEW.species_id), USER());
END; //

-- Update
CREATE TRIGGER pets_update
AFTER UPDATE ON pets
FOR EACH ROW
BEGIN
    -- Name
    IF OLD.given_name <> NEW.given_name THEN
        INSERT INTO pets_activities (pets_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.pet_id, 'UPDATE', OLD.given_name, NEW.given_name, USER());
    END IF;

    -- Owner
    IF OLD.user_id <> NEW.user_id THEN
        INSERT INTO pets_activities (pets_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.pet_id, 'UPDATE', CAST(OLD.user_id AS CHAR), CAST(NEW.user_id AS CHAR), USER());
    END IF;

    -- Species ID
    IF OLD.species_id <> NEW.species_id THEN
        INSERT INTO pets_activities (pets_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.pet_id, 'UPDATE', CAST(OLD.species_id AS CHAR), CAST(NEW.species_id AS CHAR), USER());
    END IF;

    -- Date of Birth
    IF NOT (OLD.date_of_birth <=> NEW.date_of_birth) THEN
        INSERT INTO pets_activities (pets_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.pet_id, 'UPDATE', CAST(OLD.date_of_birth AS CHAR), CAST(NEW.date_of_birth AS CHAR), USER());
    END IF;

    -- Description (Activities)
    IF NOT (OLD.description <=> NEW.description) THEN
        INSERT INTO pets_activities (pets_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.pet_id, 'UPDATE', OLD.description, NEW.description, USER());
    END IF;

    -- Status
    IF OLD.is_alive <> NEW.is_alive THEN
        INSERT INTO pets_activities (pets_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.pet_id, 'UPDATE', IF(OLD.is_alive, 'Alive', 'Deceased'), IF(NEW.is_alive, 'Alive', 'Deceased'), USER());
    END IF;
END; //

-- Delete
CREATE TRIGGER pets_delete
BEFORE DELETE ON pets
FOR EACH ROW
BEGIN
    INSERT INTO pets_activities (pets_id, modification, former_value, changed_by)
    VALUES (OLD.pet_id, 'DELETE', CONCAT('Name: ', OLD.given_name, ' | Owner ID: ', OLD.user_id), USER());
END; //

DELIMITER ;
