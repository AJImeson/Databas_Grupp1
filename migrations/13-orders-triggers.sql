-- Orders Triggers

USE ace_ventura;

DELIMITER //

-- Order Status

CREATE TRIGGER order_status_insert
AFTER INSERT ON order_status
FOR EACH ROW
BEGIN
    INSERT INTO order_activities (orders_id, modification, modified_value, changed_by)
    VALUES (NEW.status_id, 'INSERT', NEW.status_name, USER());
END; //

-- Orders

-- Insert
CREATE TRIGGER orders_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_activities (orders_id, modification, modified_value, changed_by)
    VALUES (NEW.order_id, 'INSERT', CONCAT('User:', NEW.user_id, ' StatusID:', NEW.status_id), USER());
END; //

-- Update
CREATE TRIGGER orders_update
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    -- Status 
    IF OLD.status_id <> NEW.status_id THEN
        INSERT INTO order_activities (orders_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.order_id, 'UPDATE', CAST(OLD.status_id AS CHAR), CAST(NEW.status_id AS CHAR), USER());
    END IF;

    -- Shipping Address 
    IF OLD.shipping_address_id <> NEW.shipping_address_id THEN
        INSERT INTO order_activities (orders_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.order_id, 'UPDATE', CONCAT('Address:', OLD.shipping_address_id), CONCAT('Address:', NEW.shipping_address_id), USER());
    END IF;
END; //

-- Delete
CREATE TRIGGER orders_delete
BEFORE DELETE ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_activities (orders_id, modification, former_value, changed_by)
    VALUES (OLD.order_id, 'DELETE', CONCAT('Order for User:', OLD.user_id), USER());
END; //

-- Order Items

-- Insert
CREATE TRIGGER order_items_insert
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    INSERT INTO order_activities (orders_id, modification, modified_value, changed_by)
    VALUES (NEW.items_id, 'INSERT', CONCAT('SKU:', NEW.sku, ' Qty:', NEW.qty, ' Price:', NEW.sale_price), USER());
END; //

-- Update
CREATE TRIGGER order_items_update
AFTER UPDATE ON order_items
FOR EACH ROW
BEGIN
    -- Quantity 
    IF OLD.qty <> NEW.qty THEN
        INSERT INTO order_activities (orders_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.items_id, 'UPDATE', CAST(OLD.qty AS CHAR), CAST(NEW.qty AS CHAR), USER());
    END IF;

    -- Price 
    IF OLD.sale_price <> NEW.sale_price THEN
        INSERT INTO order_activities (orders_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.items_id, 'UPDATE', CAST(OLD.sale_price AS CHAR), CAST(NEW.sale_price AS CHAR), USER());
    END IF;
END; //

-- Delete
CREATE TRIGGER order_items_delete
BEFORE DELETE ON order_items
FOR EACH ROW
BEGIN
    INSERT INTO order_activities (orders_id, modification, former_value, changed_by)
    VALUES (OLD.items_id, 'DELETE', CONCAT('SKU:', OLD.sku, ' from Order:', OLD.order_id), USER());
END; //

DELIMITER ;
