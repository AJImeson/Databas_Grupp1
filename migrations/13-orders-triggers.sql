-- Orders Triggers

DELIMITER //

-- Orders

-- Insert
CREATE TRIGGER orders_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO orders_activities (orders_id, modification, modified_value, changed_by)
    VALUES (NEW.order_id, 'INSERT', CONCAT('User:', NEW.user_id, ' Status:', NEW.status_id), USER());
END; //

-- Update
CREATE TRIGGER orders_update
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    -- Status
    IF NOT (OLD.status_id <=> NEW.status_id) THEN
        INSERT INTO orders_activities (orders_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.order_id, 'UPDATE', CAST(OLD.status_id AS CHAR), CAST(NEW.status_id AS CHAR), USER());
    END IF;

    -- Shipping Address
    IF NOT (OLD.shipping_address_id <=> NEW.shipping_address_id) THEN
        INSERT INTO orders_activities (orders_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.order_id, 'UPDATE', CONCAT('Addr:', OLD.shipping_address_id), CONCAT('Addr:', NEW.shipping_address_id), USER());
    END IF;
END; //

-- Delete
CREATE TRIGGER orders_delete
BEFORE DELETE ON orders
FOR EACH ROW
BEGIN
    INSERT INTO orders_activities (orders_id, modification, former_value, changed_by)
    VALUES (OLD.order_id, 'DELETE', CONCAT('Order for User:', OLD.user_id), USER());
END; //

-- Orders Items

-- Insert
CREATE TRIGGER order_items_insert
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    INSERT INTO orders_activities (orders_id, modification, modified_value, changed_by)
    VALUES (NEW.order_id, 'INSERT', CONCAT('Added SKU:', NEW.sku, ' Qty:', NEW.qty), USER());
END; //

-- Update
CREATE TRIGGER order_items_update
AFTER UPDATE ON order_items
FOR EACH ROW
BEGIN
    -- Quantity 
    IF NOT (OLD.qty <=> NEW.qty) THEN
        INSERT INTO orders_activities (orders_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.order_id, 'UPDATE', CONCAT('SKU:', NEW.sku, ' Old Qty:', OLD.qty), CONCAT('New Qty:', NEW.qty), USER());
    END IF;

    -- Sale Price
    IF NOT (OLD.sale_price <=> NEW.sale_price) THEN
        INSERT INTO orders_activities (orders_id, modification, former_value, modified_value, changed_by)
        VALUES (OLD.order_id, 'UPDATE', CONCAT('SKU:', NEW.sku, ' Old Price:', OLD.sale_price), CONCAT('New Price:', NEW.sale_price), USER());
    END IF;
END; //

-- Delete
CREATE TRIGGER order_items_delete
BEFORE DELETE ON order_items
FOR EACH ROW
BEGIN
    INSERT INTO orders_activities (orders_id, modification, former_value, changed_by)
    VALUES (OLD.order_id, 'DELETE', CONCAT('Removed SKU:', OLD.sku), USER());
END; //

DELIMITER ;
