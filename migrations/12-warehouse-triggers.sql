
USE ace_ventura;

DELIMITER //

-- Warehouses

-- Insert

CREATE TRIGGER warehouses_insert AFTER INSERT ON warehouses FOR EACH ROW
BEGIN
    INSERT INTO activities (table_name, record_id, modification, modified_value, changed_by)
    VALUES ('warehouses', NEW.warehouse_id, 'INSERT', NEW.city, USER());
END; //

-- Update

CREATE TRIGGER warehouses_update AFTER UPDATE ON warehouses FOR EACH ROW
BEGIN
    IF OLD.city <> NEW.city THEN
        INSERT INTO activities (table_name, record_id, modification, former_value, modified_value, changed_by)
        VALUES ('warehouses', OLD.warehouse_id, 'UPDATE', OLD.city, NEW.city, USER());
    END IF;
    IF OLD.phone_number <> NEW.phone_number THEN
        INSERT INTO activities (table_name, record_id, modification, former_value, modified_value, changed_by)
        VALUES ('warehouses', OLD.warehouse_id, 'UPDATE', OLD.phone_number, NEW.phone_number, USER());
    END IF;
END; //

-- Delete

CREATE TRIGGER warehouses_delete BEFORE DELETE ON warehouses FOR EACH ROW
BEGIN
    INSERT INTO activities (table_name, record_id, modification, former_value, changed_by)
    VALUES ('warehouses', OLD.warehouse_id, 'DELETE', OLD.city, USER());
END; //

-- Inventory

-- Insert

CREATE TRIGGER inventory_insert AFTER INSERT ON inventory FOR EACH ROW
BEGIN
    INSERT INTO activities (table_name, record_id, modification, modified_value, changed_by)
    VALUES ('inventory', NEW.inventory_id, 'INSERT', CONCAT('SKU:', NEW.sku, ' Qty:', NEW.stock_quantity), USER());
END; //

-- Update

CREATE TRIGGER inventory_update AFTER UPDATE ON inventory FOR EACH ROW
BEGIN
    IF OLD.stock_quantity <> NEW.stock_quantity THEN
        INSERT INTO activities (table_name, record_id, modification, former_value, modified_value, changed_by)
        VALUES ('inventory', OLD.inventory_id, 'UPDATE', CAST(OLD.stock_quantity AS CHAR), CAST(NEW.stock_quantity AS CHAR), USER());
    END IF;

    IF OLD.warehouse_id <> NEW.warehouse_id THEN
        INSERT INTO activities (table_name, record_id, modification, former_value, modified_value, changed_by)
        VALUES ('inventory', OLD.inventory_id, 'UPDATE', CONCAT('From Warehouse:', OLD.warehouse_id), CONCAT('To Warehouse:', NEW.warehouse_id), USER());
    END IF;
END; //

-- Delete

CREATE TRIGGER inventory_delete BEFORE DELETE ON inventory FOR EACH ROW
BEGIN
    INSERT INTO activities (table_name, record_id, modification, former_value, changed_by)
    VALUES ('inventory', OLD.inventory_id, 'DELETE', CONCAT('SKU:', OLD.sku, ' was deleted'), USER());
END; //

DELIMITER ; 
