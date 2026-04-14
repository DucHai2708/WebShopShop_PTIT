UPDATE Product p 
SET p.quantity = (
    SELECT COALESCE(SUM(pv.stock_quantity), 0)
    FROM ProductVariant pv
    WHERE pv.product_id = p.id 
)
WHERE p.id > 0;