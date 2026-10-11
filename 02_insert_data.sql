USE ecommerce_db;

INSERT INTO Categories (category_name) VALUES
('Electronics'),   -- 1
('Books'),         -- 2
('Toys');          -- 3

INSERT INTO Suppliers (supplier_name, city) VALUES
('TechWorld',     'Bengaluru'),   -- 1
('BookBay',       'Chennai'),     -- 2
('GlobalTraders', 'Kolkata');     -- 3 (no products)

INSERT INTO Employees (first_name, last_name, hire_date) VALUES
('Arun',  'Kumar',  '2022-01-10'),  -- 1
('Priya', 'Sharma', '2022-03-15');  -- 2

INSERT INTO Shippers (shipper_name) VALUES
('BlueDart'),   -- 1
('DHL');        -- 2

INSERT INTO Customers (customer_name, email, city) VALUES
('Amit Patel',   'amit@example.com',   'Mumbai'),     -- 1
('Neha Gupta',   'neha@example.com',   'Delhi'),      -- 2
('Ravi Nair',    'ravi@example.com',   'Bengaluru'),  -- 3
('Anjali Mehta', 'anjali@example.com', 'Pune');       -- 4 (no orders)

INSERT INTO Products (product_name, category_id, supplier_id, price) VALUES
('Smartphone',      1, 1, 15000.00),  -- 1
('Headphones',      1, 1,  2000.00),  -- 2
('SQL Handbook',    2, 2,   450.00),  -- 3
('Python Basics',   2, 2,   600.00),  -- 4
('Building Blocks', 3, 1,  1500.00);  -- 5 (never ordered)

INSERT INTO Orders (customer_id, employee_id, shipper_id, order_date) VALUES
(1, 1, 1, '2026-01-05'),  -- 1
(2, 2, 2, '2026-01-20'),  -- 2
(1, 2, 1, '2026-02-10'),  -- 3
(3, 1, 2, '2026-02-18');  -- 4

INSERT INTO Order_Items (order_id, product_id, quantity, unit_price) VALUES
-- Order 1 (4 different products)
(1, 1, 1, 15000.00),
(1, 2, 2,  2000.00),
(1, 3, 1,   450.00),
(1, 4, 1,   600.00),
-- Order 2
(2, 3, 3,   450.00),
-- Order 3
(3, 2, 1,  2000.00),
(3, 4, 2,   600.00),
-- Order 4
(4, 1, 1, 15000.00);
