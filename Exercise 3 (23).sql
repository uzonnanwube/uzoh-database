CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50),
  email VARCHAR(50),
  phone VARCHAR(20)
);



CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(50),
  description TEXT,
  product_category VARCHAR(50),
 unit_price DECIMAL (10,2)
);



CREATE TABLE "Order" (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  product_id INT,
  quantity INT,
  delivery_status VARCHAR(50),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id),
);



CREATE TABLE Payment (
  payment_id INT PRIMARY KEY,
  order_id INT,
  payment_date DATE,
  FOREIGN KEY (order_id) REFERENCES "Order"(order_id)
);



CREATE TABLE creditcard (
    card_number VARCHAR(50),
    customer_id INT,
    card_expiry DATE,
    bank_name VARCHAR(50),
  FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);



-- Add unit_cost column to the product table
ALTER TABLE products
ADD COLUMN unit_cost DECIMAL(10,2);

-- Update the unit_cost column with 95% of the unit_price
UPDATE products
SET unit_cost = unit_price * 0.95;




--1. Find the highest and lowest priced products along with their prices.

--USING UNION ALL CLAUSE
SELECT p.product_name, p.unit_price, 'Max_priced' AS price_category
FROM products p
WHERE p.unit_price = (SELECT MAX(unit_price) FROM products)
UNION ALL
SELECT p.product_name, p.unit_price, 'Lowest_priced' AS price_category
FROM products p
WHERE p.unit_price = (SELECT MIN(unit_price) FROM products);



--2. Find the total number of orders in each month in the year 2022.

SELECT TO_CHAR(order_date, 'Month') AS month, COUNT(*) AS total_orders
FROM "Order"
WHERE EXTRACT(YEAR FROM order_date) = 2022
GROUP BY EXTRACT(MONTH FROM order_date), TO_CHAR(order_date, 'Month')
ORDER BY EXTRACT(MONTH FROM order_date);



--3. Find the average unit price and unit cost (2 decimals) for each product category.

SELECT product_category, ROUND(AVG(unit_price),2) AS avg_unit_price, 
ROUND(AVG(unit_cost),2) AS avg_unit_cost
FROM products
GROUP BY product_category;



--4. Find all orders that were placed on or after August 1, 2022.



SELECT *
FROM "Order"
WHERE order_date >= '2023-08-01';


--5. Count the number of payments made on April 14, 2023.



SELECT COUNT(*)
FROM payment
WHERE payment_date = '2023-04-14';

--6. Which customer_id had the highest orders placed in the order table?



SELECT customer_id, COUNT(*) AS order_count
FROM "Order"
GROUP BY customer_id
ORDER BY order_count DESC
LIMIT 1;



--7. What is the total number of orders made by each customer id.

SELECT customer_id, COUNT(*) AS total_orders
FROM "Order"
GROUP BY customer_id;



--8. How many orders were delivered between Jan and Feb 2023?

SELECT COUNT(*) AS num_orders
FROM "Order"
WHERE delivery_status = 'delivered' 
  AND order_date >= '2023-01-01' 
  AND order_date < '2023-03-01';



--9. Add a credit_card table to the exercise1 DB and populate the data for all customers 
--(Ensure that it is linked to one of the other 4 tables). See table columns below;
	--card_number, customer_id, card_expiry_date, bank_name. 
	
	SELECT * FROM CREDITCARD
	
--10. Retrieve all the information associated with the credit card that is next to expire from the “credit card" table?

SELECT *
FROM CreditCard
WHERE card_expiry = (
  SELECT MIN(card_expiry)
  FROM CreditCard
  WHERE card_expiry >= CURRENT_DATE
);


--10b. how many have expired?

SELECT COUNT(*)
FROM CreditCard
WHERE card_expiry < CURRENT_DATE;












