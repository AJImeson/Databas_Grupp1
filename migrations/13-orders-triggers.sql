
SE ace_ventura;

DELIMITER //

-- Orders

-- Status Insert

CREATE TRIGGER order_status_insert AFTER INSERT ON order_status FOR EACH ROW
BEGIN
    INSERT INTO activities (table_name, record_id, modification, modified_value, changed_by)
    VALUES ('order_status', NEW.status_id, 'INSERT', NEW.status_name, USER());
END; //

-- Insert

CREATE TRIGGER orders_insert AFTER INSERT ON orders FOR EACH ROW
BEGIN
    INSERT INTO activities (table_name, record_id, modification, modified_value, changed_by)
    VALUES ('orders', NEW.order_id, 'INSERT', CONCAT('User:', NEW.user_id, ' StatusID:', NEW.status_id), USER());
END; //

-- Update

CREATE TRIGGER orders_update AFTER UPDATE ON orders FOR EACH ROW
BEGIN
    IF OLD.status_id <> NEW.status_id THEN
        INSERT INTO activities (table_name, record_id, modification, former_value, modified_value, changed_by)
        VALUES ('orders', OLD.order_id, 'UPDATE', CAST(OLD.status_id AS CHAR), CAST(NEW.status_id AS CHAR), USER());
    END IF;
    IF OLD.shipping_address_id <> NEW.shipping_address_id THEN
        INSERT INTO activities (table_name, record_id, modification, former_value, modified_value, changed_by)
        VALUES ('orders', OLD.order_id, 'UPDATE', CONCAT('Address:', OLD.shipping_address_id), CONCAT('Address:', NEW.shipping_address_id), USER());
    END IF;
END; //

-- Delete

CREATE TRIGGER orders_delete BEFORE DELETE ON orders FOR EACH ROW
BEGIN
    INSERT INTO activities (table_name, record_id, modification, former_value, changed_by)
    VALUES ('orders', OLD.order_id, 'DELETE', CONCAT('Order for User:', OLD.user_id), USER());
END; //

-- Items

-- Insert

CREATE TRIGGER order_items_insert AFTER INSERT ON order_items FOR EACH ROW
BEGIN
    INSERT INTO activities (table_name, record_id, modification, modified_value, changed_by)
    VALUES ('order_items', NEW.items_id, 'INSERT', CONCAT('SKU:', NEW.sku, ' Qty:', NEW.qty, ' Price:', NEW.sale_price), USER());
END; //

-- Update

CREATE TRIGGER order_items_update AFTER UPDATE ON order_items FOR EACH ROW
BEGIN
    IF OLD.qty <> NEW.qty THEN
        INSERT INTO activities (table_name, record_id, modification, former_value, modified_value, changed_by)
        VALUES ('order_items', OLD.items_id, 'UPDATE', CAST(OLD.qty AS CHAR), CAST(NEW.qty AS CHAR), USER());
    END IF;
    IF OLD.sale_price <> NEW.sale_price THEN
        INSERT INTO activities (table_name, record_id, modification, former_value, modified_value, changed_by)
        VALUES ('order_items', OLD.items_id, 'UPDATE', CAST(OLD.sale_price AS CHAR), CAST(NEW.sale_price AS CHAR), USER());
    END IF;
END; //

-- Delete

CREATE TRIGGER order_items_delete BEFORE DELETE ON order_items FOR EACH ROW
BEGIN
    INSERT INTO activities (table_name, record_id, modification, former_value, changed_by)
    VALUES ('order_items', OLD.items_id, 'DELETE', CONCAT('SKU:', OLD.sku, ' from Order:', OLD.order_id), USER());
END; //

DELIMITER ;
