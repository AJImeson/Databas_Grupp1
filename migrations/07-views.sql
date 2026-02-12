-- ==========================================
-- 07-VIEWS.SQL
-- Beskrivning: Skapar vyer för lager, produktinfo och meddelanden.
-- ==========================================

-- Vy för lagerstatus
CREATE OR REPLACE VIEW view_warehouse_stock AS
SELECT  
    city AS warehouse_city,
    name AS product_name,
    sku,
    stock_quantity
FROM warehouses 
JOIN inventory USING (warehouse_id)
jOIN product_information USING (sku)
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

CREATE OR REPLACE VIEW view_customer_order_details AS
SELECT
    orders.order_id,
    users.username AS customer_name,
    order_status.status_name AS order_status,
    products.name AS product_name,
    order_items.qty,
    order_items.sale_price,
    (order_items.qty * order_items.sale_price) AS line_total,
    orders.created_time
FROM orders 
JOIN users USING (user_id)
JOIN order_status USING (status_id)
JOIN order_items USING (order_id)
JOIN products USING (product_id)
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

-- SELECT * FROM view_customer_order_details
-- WHERE costumer_name = 'Alex'
-- ORDER BY created_time DESC;

-- SELECT * FROM view_user_pets;
