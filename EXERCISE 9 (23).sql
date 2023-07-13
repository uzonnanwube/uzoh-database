CREATE TABLE Customer (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50),
  email VARCHAR(50),
  phone VARCHAR(20)
);

CREATE TABLE Product (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(50),
  description TEXT,
  product_category VARCHAR(50),
  unit_price DECIMAL(10,2)
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

CREATE TABLE creditcard (
    card_number VARCHAR(50),
    customer_id BIGINT,
    card_expiry DATE,
    bank_name VARCHAR(50)
);


select * from product;

DROP TABLE creditcard cascade

ALTER TABLE product
ADD COLUMN unit_cost DECIMAL(10,2);

UPDATE product
SET unit_cost = unit_price * 0.95;

UPDATE product
SET unit_price = unit_cost + (unit_price - unit_cost)/1.05;


/*In the Exercise 1 db, add the following dummy data points to the customers' table: dob, 
gender, country, and city. 
Carry out customers segmentation analysis and use these segments ( at least 6 segments) 
to develop targeted marketing campaigns. 
Note: Ensure that your database is rich enough and contains nothing less than 500 orders
and 200 unique customers*/


CREATE TEMP TABLE temp_customer (
    customer_id int PRIMARY KEY,
    dob DATE,
    gender VARCHAR(10),
    country VARCHAR(50),
    city VARCHAR(50)
);

COPY temp_customer(customer_id, dob, gender, country, city)
FROM 'C:/Users/uzonnanwube/Downloads/EXERCISE 9 table.csv'
DELIMITER ',' CSV HEADER;


update customer as c
set dob = t.dob, gender = t.gender, country = t.country, city = t.city
from temp_customer as t
where c.customer_id = t.customer_id;

SELECT * from temp_customer;


ALTER TABLE customer 
ADD COLUMN dob DATE, 
ADD COLUMN gender VARCHAR(10), 
ADD COLUMN country VARCHAR(50), 
ADD COLUMN city VARCHAR(50);


SELECT * from customer;




--To carry out customers segmentation analysis and use the segments  
--to develop targeted marketing campaigns. 


--.1. DEMOGRAPHIC SEGMENT: AGE-BASED
--Divide customers based on age groups(e.g., Gen Y or millennials btw 25-40 , 
--Gen X btw 41-56, baby boomers btw 57-75).

-- The targeted marketing campaign: Marketing Campaign Idea would be to Create 
--age-specific advertisements highlighting product benefits that resonate with 
--each age group's preferences and needs.

-- Categorize customers into age segments
SELECT cs.customer_id, cs.customer_name, cs.email, cs.phone, cs.dob, cs.gender, cs.country, cs.city, cs.age,
       CASE
           WHEN cs.age <= 25 THEN '18-25'
           WHEN cs.age <= 35 THEN '26-35'
           WHEN cs.age <= 45 THEN '36-45'
           WHEN cs.age <= 55 THEN '46-55'
           ELSE '56+'
       END AS age_segment
FROM customer_segmentation cs;



-- .2.GEOGRAPHIC SEGMENT: Urban vs. Rural
-- This Segments customers based on their location, distinguishing between urban and rural areas.

--The Marketing Campaign Idea would be to develop separate campaigns for urban and rural audiences, 
--emphasizing relevant aspects such as convenience, accessibility, or local community engagement.

-- Categorize customers into urban and rural segments based on city
SELECT customer_id, customer_name, email, phone, dob, gender, country, city,
       CASE
           WHEN city IN ('CityA', 'CityB', 'CityC') THEN 'Urban'
           ELSE 'Rural'
       END AS geographic_segment
FROM customer;



--.3.BEHAVIORAL SEGMENT: Loyalty-Based

--This Segments customers based on their loyalty to the brand and purchasing patterns.
--The Marketing Campaign Idea would be to Develop loyalty programs and exclusive offers 
--for loyal customers,(i.e *promoters and *passsive customers) rewarding them for their  
--continued support and encouraging repeat purchases.
--(0 as no loyalty, 1-2 as low loyalty, 3-5 as medium loyalty, 6-10 as high Customer loyalty)

-- Merge customer data with loyalty information

SELECT c.customer_id, c.customer_name, c.email, c.phone, c.dob, c.gender, c.country, c.city,
       COALESCE(l.loyalty, 0) AS loyalty,
       CASE
           WHEN COALESCE(l.loyalty, 0) BETWEEN 1 AND 2 THEN 'Low'
           WHEN COALESCE(l.loyalty, 0) BETWEEN 3 AND 5 THEN 'Medium'
           WHEN COALESCE(l.loyalty, 0) > 5 THEN 'High'
           ELSE NULL
       END AS loyalty_segment
FROM customer c
LEFT JOIN customer_loyalty l ON c.customer_id = l.customer_id;


SELECT *
FROM (
  SELECT *,
    ROW_NUMBER() OVER () AS row_num
  FROM (
    SELECT c.customer_id, c.customer_name, c.email, c.phone, c.dob, c.gender, c.country, c.city,
           COALESCE(l.loyalty, 0) AS loyalty,
           CASE
               WHEN COALESCE(l.loyalty, 0) BETWEEN 1 AND 2 THEN 'Low'
               WHEN COALESCE(l.loyalty, 0) BETWEEN 3 AND 5 THEN 'Medium'
               WHEN COALESCE(l.loyalty, 0) > 5 THEN 'High'
               ELSE NULL
           END AS loyalty_segment
    FROM customer c
    LEFT JOIN customer_loyalty l ON c.customer_id = l.customer_id
  ) subquery
) result
WHERE row_num BETWEEN 1 AND 100;


--PURCHASING PATTERN OF CUSTOMERS BASED ON LOYALTY
-- Calculate customer loyalty by counting the number of orders per customer
SELECT customer_id, COUNT(*) AS loyalty
FROM orders
GROUP BY customer_id;

select * from customer_loyalty;


--.4.BEHAVIORAL SEGMENT: OCCASION-BASED
--This Segments customers based on occasions or events that influence their 
--purchasing behavior (e.g., holidays, birthdays, anniversaries).

--The Marketing Campaign Idea would be to Create targeted campaigns and personalized 
--offers to coincide with specific occasions, encouraging customers to celebrate with
-- your brand and make special purchases.
-- Categorize customers who made purchases during December, Easter, other festive periods, holidays, and birthdays

SELECT c.customer_id, c.customer_name, c.email, c.phone, c.dob, c.gender, c.country, c.city, o.order_date
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
WHERE (o.order_date::date >= '2023-12-01' AND o.order_date::date <= '2023-12-31') -- December
   OR (EXTRACT(MONTH FROM o.order_date) = 4 AND EXTRACT(DAY FROM o.order_date) >= 1 
	   AND EXTRACT(DAY FROM o.order_date) <= 7) -- Easter
   OR (EXTRACT(MONTH FROM o.order_date) = 12 AND EXTRACT(DAY FROM o.order_date) >= 20) -- Other festive periods
   OR (EXTRACT(MONTH FROM o.order_date) = EXTRACT(MONTH FROM c.dob) AND EXTRACT(DAY FROM o.order_date) = EXTRACT
	   (DAY FROM c.dob)) -- Birthdays
   OR (o.order_date::date IN ('2023-01-01', '2023-07-04', '2023-12-25')); 
   
   
   
--.5.CHURNED CUSTOMERS(INACTIVE CUSTOMERS )BASED ON LACK OF RECENT PURCHASES.
--Identify churned customers based on lack of recent purchases:

--The Marketing Campaign Idea would be to reach out to these customers who have not made
--any recent purchases within a specified timeframe either through calls or messages to
--know what informed their decision of discontinuing with the products in recent time.
--(The term "churned customers" usually implies a permanent disengagement from a business). 

SELECT customer_id, MAX(order_date) AS last_purchase_date
FROM orders
GROUP BY customer_id
HAVING MAX(order_date) < CURRENT_DATE - INTERVAL '3 months';





--.6.REPEAT CUSTOMERS

--The Marketing Campaign Idea would be to reach out to these customers who have
--made multiple purchases repeatedly so that they can continue patronising the businesses.

SELECT customer_id, COUNT(DISTINCT order_id) AS repeat_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(DISTINCT order_id) > 1;






























































