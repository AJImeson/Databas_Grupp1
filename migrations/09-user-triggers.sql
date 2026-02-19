
USE ace_ventura;

DELIMITER //

-- Users Triggers

-- Insert

CREATE TRIGGER users_insert
AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO user_activities (user_id, modification, modified_value, changed_by)
    VALUES (NEW.user_id, 'INSERT', NEW.username, USER());
END; //

-- Update
CREATE TRIGGER users_update
AFTER UPDATE ON users
FOR EACH ROW 
BEGIN

    -- Email	
    IF OLD.email <> NEW.email THEN	
        INSERT INTO user_activities (user_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.user_id, 'UPDATE', OLD.email, NEW.email, USER());
    END IF;

    -- Username
    IF OLD.username <> NEW.username THEN
        INSERT INTO user_activities (user_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.user_id, 'UPDATE', OLD.username, NEW.username, USER());
    END IF;

    -- Password
    IF OLD.password_hash <> NEW.password_hash THEN
        INSERT INTO user_activities (user_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.user_id, 'UPDATE', '[PASSWORD HASH CHANGED]', '[PASSWORD HASH CHANGED]', USER());
    END IF;

    -- Email Confirmation
    IF OLD.email_confirmed <> NEW.email_confirmed THEN
        INSERT INTO user_activities (user_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.user_id, 'UPDATE', OLD.email_confirmed, NEW.email_confirmed, USER());
    END IF;

END; //

-- Delete
CREATE TRIGGER users_delete
BEFORE DELETE ON users
FOR EACH ROW
BEGIN
    INSERT INTO user_activities (user_id, modification, former_value, changed_by)
    VALUES (OLD.user_id, 'DELETE', OLD.username, USER());
END; //

-- Addresses Triggers 

-- Insert 
CREATE TRIGGER addresses_insert
AFTER INSERT ON addresses
FOR EACH ROW
BEGIN
    INSERT INTO user_activities (user_id, modification, modified_value, changed_by)
    VALUES (NEW.addresses_id, 'INSERT', NEW.street, USER());
END; //

-- Update
CREATE TRIGGER addresses_update
AFTER UPDATE ON addresses
FOR EACH ROW
BEGIN

    -- Address
    IF OLD.address_type <> NEW.address_type THEN
        INSERT INTO user_activities (user_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.user_id, 'UPDATE', OLD.address_type, NEW.address_type, USER());
    END IF;

    -- Street 
    IF OLD.street <> NEW.street THEN
        INSERT INTO user_activities (user_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.addresses_id, 'UPDATE', OLD.street, NEW.street, USER());
    END IF;

    -- City
    IF OLD.city <> NEW.city THEN
        INSERT INTO user_activities (user_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.addresses_id, 'UPDATE', OLD.city, NEW.city, USER());
    END IF;

    -- Postal Code
    IF OLD.postal_code <> NEW.postal_code THEN
        INSERT INTO user_activities (user_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.user_id, 'UPDATE', OLD.postal_code, NEW.postal_code, USER());
    END IF;

    -- Country
    IF OLD.country <> NEW.country THEN
        INSERT INTO user_activities (user_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.user_id, 'UPDATE', OLD.country, NEW.country, USER());
    END IF;

END; //

-- Delete
CREATE TRIGGER addresses_delete
BEFORE DELETE ON addresses
FOR EACH ROW
BEGIN
    INSERT INTO user_activities (user_id, modification, former_value, changed_by)
    VALUES (OLD.addresses_id, 'DELETE', CONCAT(OLD.street, ', ', OLD.city), USER());
END; //

DELIMITER ;
