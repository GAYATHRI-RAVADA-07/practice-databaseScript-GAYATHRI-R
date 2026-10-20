-- Start the transaction block as required
START TRANSACTION

--create a databse
CREATE DATABASE restaura
-- ============================================================================
-- 1. DROP TABLES (Ordered to prevent foreign key constraint violations)
-- ============================================================================

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

-- ============================================================================
-- 2. CREATE TABLES (With primary keys and foreign key relationships)
-- ============================================================================

-- Table 1: Customers
CREATE TABLE customers (
                           customer_id INT AUTO_INCREMENT PRIMARY KEY,
                           first_name VARCHAR(50) NOT NULL,
                           last_name VARCHAR(50) NOT NULL,
                           email VARCHAR(100) UNIQUE NOT NULL,
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table 2: Orders (Contains a foreign key referencing customers)
CREATE TABLE orders (
                        order_id INT AUTO_INCREMENT PRIMARY KEY,
                        customer_id INT NOT NULL,
                        order_date DATE NOT NULL,
                        total_amount DECIMAL(10, 2) NOT NULL,
                        FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- Table 3: Order Items (Contains a foreign key referencing orders)
CREATE TABLE order_items (
                             item_id INT AUTO_INCREMENT PRIMARY KEY,
                             order_id INT NOT NULL,
                             product_name VARCHAR(100) NOT NULL,
                             quantity INT NOT NULL CHECK (quantity > 0),
                             unit_price DECIMAL(10, 2) NOT NULL,
                             FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

-- ============================================================================
-- 3. INSERT SAMPLE DATA
-- ============================================================================
-- Insert into Customers
INSERT INTO customers (first_name, last_name, email) VALUES
            ('Gayathri', 'Devi', 'gayathri@example.com'),
            ('Alex', 'Johnson', 'alex.j@example.com'),
            ('Jane', 'Smith', 'jane.smith@example.com');

-- Insert into Orders (Using generated IDs 1 and 2)
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
            (1, '2026-10-14', 1250.50),
            (2, '2026-10-15', 45.00);

-- Insert into Order Items
INSERT INTO order_items (order_id, product_name, quantity, unit_price) VALUES
            (1, 'Laptop computer', 1, 1200.00),
            (1, 'Wireless Mouse', 1, 50.50),
            (2, 'SQL Practice Book', 1, 45.00);

-- ============================================================================
-- 4. VERIFY RESULTS
-- ============================================================================
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;

-- Commit the transaction to save all changes permanently
COMMIT;

