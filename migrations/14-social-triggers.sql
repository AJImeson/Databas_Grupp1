-- Social

USE ace_ventura;

DELIMITER //

-- Messages

-- Insert
CREATE TRIGGER messages_insert
AFTER INSERT ON messages
FOR EACH ROW
BEGIN
    -- Mapping messages_id to social_id in social_activities
    INSERT INTO social_activities (social_id, modification, modified_value, changed_by)
    VALUES (NEW.messages_id, 'INSERT', CONCAT('From:', NEW.sender_id, ' To:', NEW.receiver_id), USER());
END; //

-- Update
CREATE TRIGGER messages_update
AFTER UPDATE ON messages
FOR EACH ROW
BEGIN
    -- Body content 
    IF OLD.body <> NEW.body THEN
        INSERT INTO social_activities (social_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.messages_id, 'UPDATE', OLD.body, NEW.body, USER());
    END IF;

    -- Thread/Parent ID 
    IF OLD.parent_id <> NEW.parent_id OR (OLD.parent_id IS NULL AND NEW.parent_id IS NOT NULL) THEN
        INSERT INTO social_activities (social_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.messages_id, 'UPDATE', CAST(OLD.parent_id AS CHAR), CAST(NEW.parent_id AS CHAR), USER());
    END IF;
END; //

-- Delete
CREATE TRIGGER messages_delete
BEFORE DELETE ON messages
FOR EACH ROW
BEGIN
    INSERT INTO social_activities (social_id, modification, former_value, changed_by)
    VALUES (OLD.messages_id, 'DELETE', OLD.body, USER());
END; //

DELIMITER ;
