-- ==========================================
-- 07-VIEWS.SQL
-- Beskrivning: Skapar vyer för lager, produktinfo och meddelanden.
-- ==========================================

-- Vy för lagerstatus
CREATE OR REPLACE VIEW view_warehouse_stock AS
SELECT  
    CITY AS warehouse_city,
    name AS product_name,
    sku,
    STOCK_QUANTITY
FROM WAREHOUSES 
JOIN INVENTORY USING (WAREHOUSE_ID)
JOIN product_information USING (sku)
JOIN products USING (product_id)
;

-- Vy för produktbeskrivningar
CREATE OR REPLACE VIEW view_product_catalog AS
SELECT
    name, sku, selling_price, size, colour, material
FROM products
JOIN product_information USING (product_id)
JOIN product_description USING (product_id)
;

-- Vy om kund ringer om sin beställning
CREATE OR REPLACE VIEW view_customer_order_details AS
SELECT
    o.order_id,
    u.username AS customer_name,
    os.status_name AS order_status,
    p.name AS product_name,
    oi.qty,
    oi.sale_price,
    (oi.qty * oi.sale_price) AS line_total,
    o.created_time
FROM orders o
JOIN users u USING (user_id)
JOIN order_status os USING (status_id)
JOIN order_items oi USING (order_id)
JOIN products p USING (product_id)
;

-- Vy för djur ägare
CREATE OR REPLACE VIEW view_user_pets AS
SELECT
    username AS owner_name,
    given_name AS per_name,
    common_name AS species,
    is_alive
FROM users
JOIN pets USING (user_id)
JOIN species USING (species_id)
;


-- TEST-QUERIES (Kör dessa gör att se resultat)
-- SELECT * FROM view_warehouse_stock;
-- SELECT * FROM view_product_catalog;
-- SELECT * FROM view_user_pets;
