-- INSERT
INSERT INTO users (name, email)
VALUES ('Udaifa', 'udaifa@gmail.com');

INSERT INTO products (name, price, stock)
VALUES ('Shoes', 2000, 5);

INSERT INTO orders (user_id, product_id, quantity)
VALUES (1, 1, 2);

-- SELECT
SELECT * FROM users;
SELECT * FROM products;
SELECT * FROM orders;

-- UPDATE
UPDATE users
SET name = 'Udaifa KK'
WHERE id = 1;

-- DELETE
DELETE FROM orders WHERE id = 1;


-- ALTER
ALTER TABLE users ADD phone VARCHAR(15);

-- DROP
DROP TABLE IF EXISTS test_table;