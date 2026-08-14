--🔹 1. Users with their Orders
SELECT u.name, o.id AS order_id
FROM users u
INNER JOIN orders o ON u.id = o.user_id;
-- Meaning: user + avarude orders



--2. Products with their Categories
SELECT p.name AS product, c.name AS category
FROM products p
JOIN categories c ON p.category_id = c.id;


--3. Users who NEVER placed order
SELECT u.name
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE o.id IS NULL;



--🔹 4. Highest Value Customer
SELECT u.name, SUM(p.amount) AS total_spent
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN payments p ON o.id = p.order_id
GROUP BY u.name
ORDER BY total_spent DESC
LIMIT 1;



--🔹 5. Products above Category Average
SELECT p.name, p.price
FROM products p
WHERE p.price > (
    SELECT AVG(price)
    FROM products
    WHERE category_id = p.category_id
);
--(Correlated Subquery)



--🔹 6. CTE – Monthly Sales
WITH monthly_sales AS (
    SELECT DATE_TRUNC('month', o.created_at) AS month,
           SUM(p.amount) AS total_sales
    FROM orders o
    JOIN payments p ON o.id = p.order_id
    GROUP BY month
)
SELECT * FROM monthly_sales;



--🔹 7. Create VIEW – Active Customers
--Assume active = users with orders
CREATE VIEW active_customers AS
SELECT DISTINCT u.id, u.name
FROM users u
JOIN orders o ON u.id = o.user_id;



--Use view:
SELECT * FROM active_customers;