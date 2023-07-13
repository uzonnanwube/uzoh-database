 -- Exercise (7)
/* Analyze the data in Exercise 1 DB, identify 5 KPIs and provide five Insights and 
Recommendations that can drive business growth, based on the insights you uncovered.
Note:the exercise1 DB contains the followiwing tables;

CREATE TABLE creditcard (
    card_number VARCHAR(50),
    customer_id BIGINT,
    card_expiry DATE,
    bank_name VARCHAR(50)
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  product_id INT,
  quantity INT,
  delivery_status VARCHAR(50),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
  FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Payment (
  payment_id INT PRIMARY KEY,
  order_id INT,
  payment_date DATE,
  FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Product (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(50),
  description TEXT,
  product_category VARCHAR(50),
  unit_price DECIMAL(10,2)
);

CREATE TABLE Customer (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50),
  email VARCHAR(50),
  phone VARCHAR(20)
);

ALTER TABLE product
ADD COLUMN unit_cost DECIMAL(10,2);

UPDATE product
SET unit_cost = unit_price * 0.95;

UPDATE product
SET unit_price = unit_cost + (unit_price - unit_cost)/1.05;



/* Here are five KPIs that could be useful for analyzing the performance of the business

--1 SALES GROWTH RATE: This KPI measures the rate at which the company's sales are growing over time.

--2 CUSTOMER ACQUISITION RATE: This KPI measures the rate at which the company is acquiring new customers.

--3 CUSTOMER RETENTION RATE: This KPI measures the rate at which the company is retaining its existing customers.

--4 AVERAGE ORDER VALUES: This KPI measures the average value of orders placed by customers.

--5 GROSS PROFIT MARGIN: This KPI measures the percentage of sales revenue that is left after deducting the 
--cost of goods sold.

--Five insights and recommendations that can help drive business growth based on the data in these tables */


INSIGHT 1: To show the top 25 best performing products, sorted by total sales in descending order: */

SELECT o.product_id, p.product_name, SUM(quantity) AS total_quantity, 
SUM(quantity * p.unit_price) AS total_salesUSD
FROM orders o
JOIN product p ON o.product_id = p.product_id
GROUP BY o.product_id, p.product_name
ORDER BY total_salesUSD DESC
limit 25;


SELECT 
    p.product_id, 
    p.product_name, 
    SUM(o.quantity) AS total_quantity,
    SUM(o.quantity * p.unit_price) AS total_sales
FROM 
    product p
JOIN 
    orders o ON p.product_id = o.product_id
WHERE 
    p.product_id IN (2001, 2034, 2050)
GROUP BY 
    p.product_id, p.product_name
ORDER BY 
    p.product_id;

--Recommendation 1: the company should pay close attention to products performing the best,
--in order to enable them have quick turnovers, and also reduce the quantity of the least 
--performing products to avoid having excess out of fashion stocks.



--INSIGHT 2: TO check the percentage growth rate in sales overtime. 

WITH monthly_sales AS (
  SELECT o.product_id, p.product_name, SUM(quantity * p.unit_price) AS total_sales,
         DATE_TRUNC('month', o.order_date) AS month
  FROM orders o
  JOIN product p ON o.product_id = p.product_id
  GROUP BY o.product_id, p.product_name, month
), 
previous_month_sales AS (
  SELECT product_id, product_name, CONCAT('$', total_sales) AS previous_month_sales, 
         DATE_TRUNC('month', DATE_TRUNC('month', month) - INTERVAL '1 month') AS previous_month_month
  FROM monthly_sales
),
current_month_sales AS (
  SELECT product_id, product_name, CONCAT('$', total_sales) AS current_month_sales, month
  FROM monthly_sales
)
SELECT c.product_id, c.product_name, 
       c.current_month_sales, p.previous_month_sales,
       CONCAT('$', ROUND(((
           CAST(REPLACE(c.current_month_sales, '$', '') AS numeric) - 
           CAST(REPLACE(p.previous_month_sales, '$', '') AS numeric)) / 
           CAST(REPLACE(p.previous_month_sales, '$', '') AS numeric)) * 100, 2), '%') 
       AS growth_rate,
       c.month AS month
FROM current_month_sales c
JOIN previous_month_sales p ON c.product_id = p.product_id
ORDER BY growth_rate DESC;

/* It is likely that the product with product_id 2008 has sales in multiple months. 
Since the query calculates the growth rate between the current month and the previous 
month, if the product had sales in both months, it would appear twice in 
the output table, once for each month.

For example, if the product with product_id 2008 had sales in both March and April, 
the query would calculate the growth rate between April and March, and the output table 
would have two rows for the product with the same product_id and 
product_name, but different current_month_sales, previous_month_sales, and growth_rate values.

If you want to see only one row per product, you could modify the query to aggregate the 
sales data by product over a longer time period, such as a quarter or a year, instead 
of just one month. This would give you a longer-term view of 
the product's sales performance and growth rate. */

--Recommendation 2: More attention should be paid to the product with higher and lower growth rate
--in order to improve sales.

  
  
/*INSIGHT 3: To check the company's customer retention rate, and know whether they're performing 
up to industry standards*/ 

  
WITH customer_orders AS (
  SELECT customer_id, MIN(order_date) AS first_order_date, MAX(order_date) AS last_order_date
  FROM orders
  GROUP BY customer_id
)
SELECT COUNT(*) AS total_customers,
       COUNT(DISTINCT o.customer_id) AS retained_customers,
       (COUNT(DISTINCT o.customer_id) * 100.0 / COUNT(*))::decimal(10,2) || '%' AS retention_rate
FROM customer_orders c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date > DATE_TRUNC('year', c.first_order_date)
  AND o.order_date <= DATE_TRUNC('year', c.last_order_date) + INTERVAL '1 year';

/*Recommendation 3: The company should focus on improving customer experience and providing exceptional 
customer service to retain its existing customers*/



/*--INSIGHT 4: TO check the company's customer acquisition rate and calculate which product 
--categories are popular among customers in a given month*/

SELECT 
    DATE_TRUNC('month', order_date) AS month,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    COUNT(DISTINCT CASE WHEN p.product_category = 'Summer wear' THEN o.customer_id ELSE NULL END) AS summerwear_customers,
    COUNT(DISTINCT CASE WHEN p.product_category = 'Accessories' THEN o.customer_id ELSE NULL END) AS accessories_customers,
    COUNT(DISTINCT CASE WHEN p.product_category = 'Winter wear' THEN o.customer_id ELSE NULL END) AS winterwear_customers,
    COUNT(DISTINCT CASE WHEN p.product_category = 'Foot wear' THEN o.customer_id ELSE NULL END) AS footwear_customers,
	COUNT(DISTINCT CASE WHEN p.product_category = 'Caps' THEN o.customer_id ELSE NULL END) AS cap_customers,
    COUNT(DISTINCT CASE WHEN p.product_category = 'Underwear' THEN o.customer_id ELSE NULL END) AS underwear_customers,
    COUNT(DISTINCT CASE WHEN p.product_category = 'Casual wear' THEN o.customer_id ELSE NULL END) AS casualwear_customers,
    COUNT(DISTINCT CASE WHEN p.product_category = 'Sports wear' THEN o.customer_id ELSE NULL END) AS sportswear_customers,
	COUNT(DISTINCT CASE WHEN p.product_category = 'Luggage' THEN o.customer_id ELSE NULL END) AS luggage_customers,
    COUNT(DISTINCT CASE WHEN p.product_category = 'Cooperate wear' THEN o.customer_id ELSE NULL END) AS cooperate_customers,
    COUNT(DISTINCT CASE WHEN p.product_category = 'Bath towel' THEN o.customer_id ELSE NULL END) AS bathtowel_customers,
    COUNT(DISTINCT CASE WHEN p.product_category = 'Hankerchief' THEN o.customer_id ELSE NULL END) AS handkerchief_customers
FROM orders o
JOIN product p ON o.product_id = p.product_id
GROUP BY 1
ORDER BY 1;

/* Recommendation 4: The company should identify the reasons for this decline and take steps to 
improve customer acquisition, such as running targeted marketing campaigns haven't seen trends 
in customer purchasing behavior across different months and product categories, to identify 
opportunities for growth and improvement. 
The consistent decrease in the number of customers purchasing some particular products category
over time,is a sign that there's need to re-evaluate product offerings or marketing 
strategies for that category. */



/* INSIGHT 5: To check the average order value made in the store, and help determine 
how  the business had faired over time, whether it's increasing or decreasing over time.*/

SELECT CONCAT('$', ROUND(AVG(quantity * unit_price), 2)) AS avg_order_value
FROM orders
JOIN product ON orders.product_id = product.product_id;

/*Recommendation 5: The company should introduce new products or product bundles to encourage 
customers to make larger purchases; customer survey questionaire may also come in handy at this point.*/



--INSIGHT 6: The gross profit margin has been declining due to increasing costs of goods sold. 

SELECT 
    (SUM(o.quantity * (p.unit_price - p.unit_cost)) / SUM(o.quantity * p.unit_price) * 100)
	::numeric(10,2) || '%' 
	AS gross_profit_margin
FROM orders o
JOIN product p ON o.product_id = p.product_id;

/*Recommendation 6: The company should explore ways to reduce costs, such as negotiating better deals with 
suppliers or finding more cost-effective ways to produce and distribute its products.*/





