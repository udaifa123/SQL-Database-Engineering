-- USERS
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- CATEGORIES
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- PRODUCTS
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price INT CHECK (price > 0),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- ORDERS
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- ORDER ITEMS (JUNCTION TABLE)
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- PAYMENTS
CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    order_id INT UNIQUE,
    amount INT,
    status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);