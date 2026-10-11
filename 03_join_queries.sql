-- =====================================================
-- Short names used:
-- c = Customers, o = Orders, oi = Order_Items, p = Products,
-- cat = Categories, s = Suppliers, e = Employees, sh = Shippers
--
-- JOIN       = show only rows that match in both tables
-- LEFT JOIN  = show ALL rows from the first table, even if no match
-- =====================================================

USE ecommerce_db;


-- Q1. Display all customers with their orders.
SELECT c.customer_name, o.order_id
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

-- Q2. Display order details with customer names.
SELECT o.order_id, o.order_date, c.customer_name
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

-- Q3. Show every product with its category.
SELECT p.product_name, cat.category_name
FROM Products p
JOIN Categories cat ON p.category_id = cat.category_id;

-- Q4. Display products with supplier names.
SELECT p.product_name, s.supplier_name
FROM Products p
JOIN Suppliers s ON p.supplier_id = s.supplier_id;

-- Q5. Show orders handled by each employee.
SELECT e.first_name, o.order_id
FROM Employees e
JOIN Orders o ON e.employee_id = o.employee_id;

-- Q6. Display orders with shipper names.
SELECT o.order_id, sh.shipper_name
FROM Orders o
JOIN Shippers sh ON o.shipper_id = sh.shipper_id;

-- Q7. Show customers who placed at least one order.
-- DISTINCT = show each customer only once.
SELECT DISTINCT c.customer_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id;

-- Q8. Display products purchased in each order.
SELECT oi.order_id, p.product_name
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id;

-- Q9. Display product name and quantity ordered.
SELECT p.product_name, oi.quantity
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id;

-- Q10. Display employee names and customer names.
SELECT e.first_name AS employee, c.customer_name AS customer
FROM Orders o
JOIN Employees e ON o.employee_id = e.employee_id
JOIN Customers c ON o.customer_id = c.customer_id;


-- Q11. Display customer, order, product, quantity and price.
SELECT c.customer_name, o.order_id, p.product_name, oi.quantity, oi.unit_price
FROM Orders o
JOIN Customers c    ON o.customer_id = c.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p     ON oi.product_id = p.product_id;

-- Q12. Display supplier name with products sold.
SELECT s.supplier_name, p.product_name, oi.quantity
FROM Suppliers s
JOIN Products p     ON s.supplier_id = p.supplier_id
JOIN Order_Items oi ON p.product_id = oi.product_id;

-- Q13. Display category-wise product count.
SELECT cat.category_name, COUNT(p.product_id) AS product_count
FROM Categories cat
LEFT JOIN Products p ON cat.category_id = p.category_id
GROUP BY cat.category_name;

-- Q14. Find total orders for each customer.
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- Q15. Find total sales by employee. (sales = quantity x price)
SELECT e.first_name, SUM(oi.quantity * oi.unit_price) AS total_sales
FROM Employees e
JOIN Orders o       ON e.employee_id = o.employee_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY e.first_name;

-- Q16. Find total revenue by category.
SELECT cat.category_name, SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Categories cat
JOIN Products p     ON cat.category_id = p.category_id
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY cat.category_name;

-- Q17. Display the most expensive product in every category.
-- MAX(price) gives the highest price in each category.
SELECT cat.category_name, MAX(p.price) AS highest_price
FROM Categories cat
JOIN Products p ON cat.category_id = p.category_id
GROUP BY cat.category_name;

-- Q18. Find products never ordered.
-- LEFT JOIN + IS NULL = rows with NO match in the other table.
SELECT p.product_name
FROM Products p
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;

-- Q19. Find customers who never placed orders.
SELECT c.customer_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Q20. Display suppliers without products.
SELECT s.supplier_name
FROM Suppliers s
LEFT JOIN Products p ON s.supplier_id = p.supplier_id
WHERE p.product_id IS NULL;


-- Q21. Find top five customers by spending.
SELECT c.customer_name, SUM(oi.quantity * oi.unit_price) AS total_spent
FROM Customers c
JOIN Orders o       ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 5;

-- Q22. Display monthly sales by employee.
-- MONTH() gives the month number (1 = January, 2 = February ...).
SELECT e.first_name, MONTH(o.order_date) AS month_no,
       SUM(oi.quantity * oi.unit_price) AS monthly_sales
FROM Employees e
JOIN Orders o       ON e.employee_id = o.employee_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY e.first_name, MONTH(o.order_date);

-- Q23. Find the best-selling product.
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 1;

-- Q24. Display supplier-wise revenue.
SELECT s.supplier_name, SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Suppliers s
JOIN Products p     ON s.supplier_id = p.supplier_id
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY s.supplier_name;

-- Q25. Find average order value per customer.
-- Total spent divided by number of orders.
SELECT c.customer_name,
       SUM(oi.quantity * oi.unit_price) / COUNT(DISTINCT o.order_id) AS avg_order_value
FROM Customers c
JOIN Orders o       ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name;

-- Q26. Display orders with more than three products.
-- HAVING is like WHERE, but used after GROUP BY.
SELECT order_id, COUNT(product_id) AS product_count
FROM Order_Items
GROUP BY order_id
HAVING COUNT(product_id) > 3;

-- Q27. Find customers ordering from multiple categories.
SELECT c.customer_name, COUNT(DISTINCT p.category_id) AS category_count
FROM Customers c
JOIN Orders o       ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p     ON oi.product_id = p.product_id
GROUP BY c.customer_name
HAVING COUNT(DISTINCT p.category_id) > 1;

-- Q28. Display categories with no sales.
SELECT cat.category_name
FROM Categories cat
LEFT JOIN Products p     ON cat.category_id = p.category_id
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;

-- Q29. Display the highest-value order.
SELECT order_id, SUM(quantity * unit_price) AS order_value
FROM Order_Items
GROUP BY order_id
ORDER BY order_value DESC
LIMIT 1;

-- Q30. Generate a complete invoice report using all tables.
SELECT o.order_id, o.order_date, c.customer_name, e.first_name AS employee,
       sh.shipper_name, p.product_name, cat.category_name, s.supplier_name,
       oi.quantity, oi.unit_price, oi.quantity * oi.unit_price AS line_total
FROM Orders o
JOIN Customers c    ON o.customer_id = c.customer_id
JOIN Employees e    ON o.employee_id = e.employee_id
JOIN Shippers sh    ON o.shipper_id = sh.shipper_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p     ON oi.product_id = p.product_id
JOIN Categories cat ON p.category_id = cat.category_id
JOIN Suppliers s    ON p.supplier_id = s.supplier_id;
