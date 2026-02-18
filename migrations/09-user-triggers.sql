
USE ace_ventura;

DELIMITER //

-- Users Triggers

-- Insert

CREATE TRIGGER users_insert
AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO activities (table_name, record_id, modification, modified_value, changed_by)
    VALUES ('users', NEW.user_id, 'INSERT', NEW.username, USER());
END; //

-- Update

CREATE TRIGGER users_update
AFTER UPDATE ON users
FOR EACH ROW 
BEGIN

    -- Email Change	

    IF OLD.email <> NEW.email THEN	
        INSERT INTO activities_users (table_name, record_id, modification, former_value, modified_value, changed_by)
        VALUES ('users', OLD.user_id, 'UPDATE', OLD.email, NEW.email, USER());
    END IF;

    -- Username Change

    IF OLD.username <> NEW.username THEN
	INSERT INTO activities_users (table_name, record_id, modification, former_value, modified_value, changed_by)
	VALUES ('users', OLD.user_id, 'UPDATE', OLD.username, NEW.username, USER());
    END IF;

    -- Email confirmation Change

    IF OLD.email_confirmed <> NEW.email_confirmed THEN
	INSERT INTO activities_users (table_name, record_id, modification, former_value, modified_value, changed_by)
	VALUES ('users', OLD.user_id, 'UPDATE', OLD.email_confirmed, NEW.email_confirmed, USER());
    END IF;

END; //

-- Delete

CREATE TRIGGER users_delete
BEFORE DELETE ON users
FOR EACH ROW
BEGIN
    INSERT INTO activities (table_name, record_id, modification, former_value, changed_by)
    VALUES ('users', OLD.user_id, 'DELETE', OLD.username, USER());
END; //

-- Addresses Triggers 

-- Insert 

CREATE TRIGGER addresses_insert
AFTER INSERT ON addresses
FOR EACH ROW
BEGIN
    INSERT INTO activities (table_name, record_id, modification, modified_value, changed_by)
    VALUES ('addresses', NEW.addresses_id, 'INSERT', NEW.street, USER());
END; //

-- Update

CREATE TRIGGER addresses_update
AFTER UPDATE ON addresses
FOR EACH ROW
BEGIN
    IF OLD.street <> NEW.street THEN
        INSERT INTO activities (table_name, record_id, modification, former_value, modified_value, changed_by)
        VALUES ('addresses', OLD.addresses_id, 'UPDATE', OLD.street, NEW.street, USER());
    END IF;

    IF OLD.city <> NEW.city THEN
        INSERT INTO activities (table_name, record_id, modification, former_value, modified_value, changed_by)
        VALUES ('addresses', OLD.addresses_id, 'UPDATE', OLD.city, NEW.city, USER());
    END IF;
END; //

-- Delete

CREATE TRIGGER addresses_delete
BEFORE DELETE ON addresses
FOR EACH ROW
BEGIN
    INSERT INTO activities (table_name, record_id, modification, former_value, changed_by)
    VALUES ('addresses', OLD.addresses_id, 'DELETE', CONCAT(OLD.street, ', ', OLD.city), USER());
END; //

DELIMITER ;

