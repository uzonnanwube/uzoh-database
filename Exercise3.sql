--1. Find the highest and lowest priced products along with their prices.

--USING UNION ALL CLAUSE
SELECT p.product_name, p.unit_price, 'Max_priced' AS price_category
FROM product p
WHERE p.unit_price = (SELECT MAX(unit_price) FROM product)
UNION ALL
SELECT p.product_name, p.unit_price, 'Lowest_priced' AS price_category
FROM product p
WHERE p.unit_price = (SELECT MIN(unit_price) FROM product);


--2. Find the total number of orders in each month in the year 2022.
SELECT TO_CHAR(DATE_TRUNC('month', order_date), 'Month, YYYY') AS month_year, COUNT(*) AS total_orders
FROM order_table
WHERE order_date >= '2022-01-01' AND order_date < '2023-01-01'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date);

--3. Find the average unit price and unit cost (2 decimals) for each product category.
SELECT product_category, ROUND(AVG(unit_price),2) AS avg_unit_price, ROUND(AVG(unit_cost),2) AS avg_unit_cost
FROM product
GROUP BY product_category;

--4. Find all orders that were placed on or after August 1, 2022.
SELECT *
FROM order_table
WHERE order_date >= '2023-08-01';


--5. Count the number of payments made on April 14, 2023.
SELECT COUNT(*)
FROM payment
WHERE payment_date = '2023-04-14';

--6. Which customer_id had the highest orders placed in the order table?
SELECT customer_id, COUNT(*) AS order_count
FROM order_table
GROUP BY customer_id
ORDER BY order_count DESC
LIMIT 1;

--7. What is the total number of orders made by each customer id.
SELECT customer_id, COUNT(*) AS total_orders
FROM order_table
GROUP BY customer_id;

--8. How many orders were delivered between Jan and Feb 2023?
SELECT COUNT(*) AS num_orders
FROM order_table
WHERE delivery_status = 'delivered' 
  AND order_date >= '2023-01-01' 
  AND order_date < '2023-03-01';

--9. Add a credit_card table to the exercise1 DB and populate the data for all customers 
--(Ensure that it is linked to one of the other 4 tables). See table columns below;
	--card_number, customer_id, card_expiry_date, bank_name. 
	
--10. Retrieve all the information associated with the credit card that is next to expire from the “credit card" table?
SELECT *
FROM CreditCard
WHERE expiryDate = (
  SELECT MIN(expiryDate)
  FROM CreditCard
  WHERE expiryDate >= CURRENT_DATE
);


--10b. how many have expired?
SELECT COUNT(*)
FROM CreditCard
WHERE expiryDate < CURRENT_DATE;












