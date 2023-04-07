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




DROP TABLE creditcard cascade

ALTER TABLE product
ADD COLUMN unit_cost DECIMAL(10,2);

UPDATE product
SET unit_cost = unit_price * 0.95;

UPDATE product
SET unit_price = unit_cost + (unit_price - unit_cost)/1.05;





EXCERCISE THREE (CONTINUATION)

1:) Find the highest and lowest priced products along with their prices?


SELECT product_name, unit_price 
FROM products 
WHERE unit_price = (SELECT MAX(unit_price) FROM products) 
   OR unit_price = (SELECT MIN(unit_price) FROM products);



2:) Find the total number of orders in each month in the year 2022?


SELECT 
    EXTRACT(MONTH FROM order_date) AS month, 
    COUNT(*) AS total_orders
FROM 
    "Order"
WHERE 
    EXTRACT(YEAR FROM order_date) = 2022
GROUP BY 
    EXTRACT(MONTH FROM order_date);


3:) Find the average unit price and unit cost (2 decimals) for each product category?


SELECT 
    product_category, 
    CAST(AVG(unit_price) AS NUMERIC(10,2)) AS avg_unit_price, 
    CAST(AVG(unit_cost) AS NUMERIC(10,2)) AS avg_unit_cost
FROM 
    products 
GROUP BY 
    product_category;


4:) Find all orders that were placed on or after August 1,2022?

SELECT order_id, order_date
FROM "Order"
where order_date >= '2022-08-01';



5:) Count the number of payments made on April 14,2023


SELECT COUNT(*) AS num_payment
FROM payment
WHERE payment_date = '2023-04-14';


6;) Which customer_id had the highest orders placed in the order table?

SELECT 
    customer_id, 
    COUNT(*) AS num_orders
FROM 
    "Order"
GROUP BY 
    customer_id
ORDER BY 
    num_orders DESC
LIMIT 1;



7:) What is the total number of order made by each customer_id?

SELECT 
    customer_id, 
    COUNT(*) AS num_orders
FROM 
    "Order"
GROUP BY 
    customer_id;
 


8:) How many orders were delivered between January and February 2023?

SELECT COUNT(1) AS no_of_orders
FROM "Order"
WHERE DATE_PART('YEAR', order_date) = 2023
  AND DATE_PART('MONTH', order_date) BETWEEN 1 AND 2;
 
	 



9:) Add a credit card table to the exercise 1 database and populate the data for all the customers.
(Ensure that it is linked to one of the other four tables)see the table column below,
Card_number, Customer_id, Card_expiry_date, bank_name.


CREATE TABLE CreditCard (
    Card_number VARCHAR(50) PRIMARY KEY,
    customer_id bigint,
    card_expiry DATE,
    bank_name VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(Customer_id)
);

SELECT * FROM creditcard;


10:)(a) Retrieve all the information associated with the 
creditcard that is next to expire from the "Creditcard"


SELECT Card_number
      ,customer_id
      ,card_expiry
      ,bank_name
FROM Creditcard
WHERE Card_expiry >= CURRENT_DATE
ORDER BY Card_expiry ASC


SELECT Card_number
      ,customer_id
      ,card_expiry
      ,bank_name
	  ,DENSE_RANK () OVER (PARTITION BY card_expiry
	                      ORDER BY card_expiry ASC)
FROM Creditcard
WHERE Card_expiry >= CURRENT_DATE
ORDER BY Card_expiry ASC


SELECT *
FROM Creditcard
WHERE card_expiry = (
    SELECT MIN(card_expiry)
    FROM Creditcard
    WHERE card_expiry > NOW()
);


(b) How many have expired?

SELECT COUNT(*) AS num_expired
FROM Creditcard
WHERE card_expiry < NOW();


SELECT card_number
      ,customer_id
      ,card_expiry
	  ,bank_name
FROM creditcard
WHERE card_expiry<=CURRENT_DATE


SELECT COUNT(DISTINCT customer_id) AS num_customers_with_expired_cards
FROM Creditcard
WHERE card_expiry < NOW();


SELECT *
FROM Creditcard
WHERE card_expiry >= '2020-01-01' AND card_expiry <= '2020-12-31';

