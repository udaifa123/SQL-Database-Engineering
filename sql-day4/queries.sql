--🔹 1. CREATE INDEX
CREATE INDEX idx_users_email ON users(email);
--frequently search column to create index
--email search fast



--🔹 2. COMPARE (Before vs After Index)
--❌ Without Index
EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'udaifa@gmail.com';
--output
--sequential scan show(slow)


--✅ With Index
CREATE INDEX idx_users_email ON users(email);

EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'udaifa@gmail.com';
--output
--seuential scen show(fast)



--🔹 3. EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT * FROM products WHERE price > 1000;
--how to run query+time show



--🔹 4. TRANSACTION IMPLEMENT
BEGIN;

UPDATE users
SET name = 'Test User'
WHERE id = 1;

COMMIT;
--change permanent



--🔹 5. ROLLBACK DEMO
BEGIN;

UPDATE users
SET name = 'Wrong Name'
WHERE id = 1;

ROLLBACK;
--change cancel


--🔹 6. SAVEPOINT DEMO
BEGIN;

UPDATE users SET name = 'A' WHERE id = 1;

SAVEPOINT sp1;

UPDATE users SET name = 'B' WHERE id = 1;

ROLLBACK TO sp1;

COMMIT;
--B cancel,A save



--🔹 7. OPTIMIZE SLOW QUERY
--❌ Slow Query
SELECT * FROM products WHERE price > 1000;
--full table scan



--✅ Optimized
CREATE INDEX idx_products_price ON products(price);

SELECT * FROM products WHERE price > 1000;
--faster result