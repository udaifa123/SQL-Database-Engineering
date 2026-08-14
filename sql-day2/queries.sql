-- USERS
INSERT INTO users (name, email) VALUES
('Udaifa', 'udaifa@gmail.com'),
('Rahul', 'rahul@gmail.com');

-- CATEGORIES
INSERT INTO categories (name) VALUES
('Shoes'), ('Clothing');

-- PRODUCTS
INSERT INTO products (name, price, category_id) VALUES
('Nike Shoes', 3000, 1),
('T-Shirt', 800, 2);

-- ORDERS
INSERT INTO orders (user_id) VALUES
(1), (2);

-- ORDER ITEMS
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),
(2, 2, 1);

-- PAYMENTS
INSERT INTO payments (order_id, amount, status) VALUES
(1, 6000, 'SUCCESS'),
(2, 800, 'SUCCESS');





--STEP 4: Filtering Queries

-- WHERE
SELECT * FROM products WHERE price > 1000;

-- ORDER BY
SELECT * FROM products ORDER BY price DESC;

-- LIMIT
SELECT * FROM products LIMIT 1;

-- DISTINCT
SELECT DISTINCT category_id FROM products;

-- LIKE
SELECT * FROM users WHERE name LIKE 'U%';

-- IN
SELECT * FROM products WHERE id IN (1,2);

-- BETWEEN
SELECT * FROM products WHERE price BETWEEN 500 AND 3000;

-- IS NULL
SELECT * FROM users WHERE email IS NULL;

-- AND
SELECT * FROM products WHERE price > 500 AND price < 4000;




--STEP 5: Aggregate Queries

-- COUNT
SELECT COUNT(*) FROM users;

-- SUM
SELECT SUM(amount) FROM payments;

-- AVG
SELECT AVG(price) FROM products;

-- MIN / MAX
SELECT MIN(price), MAX(price) FROM products;

-- GROUP BY
SELECT user_id, COUNT(*) FROM orders GROUP BY user_id;

-- HAVING
SELECT user_id, COUNT(*) FROM orders
GROUP BY user_id
HAVING COUNT(*) > 0;




--STEP 6: JOIN Queries

-- Products with category
SELECT p.name, c.name AS category
FROM products p
JOIN categories c ON p.category_id = c.id;

-- Orders with user
SELECT o.id, u.name
FROM orders o
JOIN users u ON o.user_id = u.id;

-- Order details
SELECT o.id, p.name, oi.quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.id
JOIN orders o ON oi.order_id = o.id;