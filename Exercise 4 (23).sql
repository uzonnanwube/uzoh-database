CREATE TABLE exercise4
(
    product_id integer NOT NULL,
    product_name character varying(500) COLLATE pg_catalog."default" NOT NULL,
    aisle_id smallint NOT NULL,
    department_id smallint NOT NULL,
    aisle character varying(50) COLLATE pg_catalog."default" NOT NULL,
    order_id integer NOT NULL,
    user_id integer NOT NULL,
    order_dow smallint NOT NULL,
    order_hour_of_day smallint NOT NULL,
    days_since_prior_order smallint,
    department character varying(50) COLLATE pg_catalog."default" NOT NULL
)


SET SCHEMA 'exercise4_normalization'

SELECT DISTINCT aisle_id
	           ,aisle
INTO aisle
FROM exercise4

ALTER TABLE aisle ADD
PRIMARY KEY (aisle_id)



SELECT DISTINCT department_id
	           ,department
INTO departments
FROM exercise4

ALTER TABLE departments ADD
PRIMARY KEY (department_id)



SELECT DISTINCT product_id	   
               ,product_name
INTO products
FROM exercise4

ALTER TABLE products
ADD PRIMARY KEY (product_id)



SELECT * FROM products;

SELECT order_id
	  ,user_id
	  ,order_dow
	  ,order_hour_of_day
	  ,days_since_prior_order
	  ,product_id
	  ,department_id
INTO orders
FROM exercise4 


ALTER TABLE orders ADD
PRIMARY KEY (order_id)

ALTER TABLE orders ADD
FOREIGN KEY (product_id) REFERENCES products(product_id) 

ALTER TABLE orders ADD
FOREIGN KEY (department_id) REFERENCES departments(department_id)



SELECT DISTINCT product_id
	  	 	   ,aisle_id
INTO warehouse
FROM exercise4 


ALTER TABLE warehouse ADD
FOREIGN KEY (product_id) REFERENCES products (product_id)

ALTER TABLE warehouse ADD
FOREIGN KEY (aisle_id) REFERENCES aisle(aisle_id)



-- Q & A

-- 1. On which day/s of the week are condoms mostly sold?

SELECT order_dow
	  ,COUNT(1) no_of_condoms_sold
FROM orders o
INNER JOIN products p
ON o.product_id=p.product_id
WHERE LOWER(p.product_name) LIKE '%condom%'
GROUP BY order_dow
ORDER BY no_of_condoms_sold DESC
LIMIT 3;



-- 2. At what time of the day is it mostly sold?

SELECT order_hour_of_day
	  ,COUNT(1) no_of_condoms_sold
FROM orders o
INNER JOIN products p
ON o.product_id=p.product_id
WHERE LOWER(p.product_name) LIKE '%condom%'
GROUP BY order_hour_of_day
ORDER BY no_of_condoms_sold DESC
LIMIT 1;



-- 3. What type of condoms do the customers prefer?

SELECT p.product_name
FROM orders o
INNER JOIN products p
ON o.product_id=p.product_id
WHERE LOWER(p.product_name) LIKE '%condom%'
GROUP BY p.product_name
ORDER BY COUNT(1) DESC
LIMIT 1;

SELECT * FROM products
WHERE LOWER(product_name) LIKE '%condom%'



-- 4. Which aisle contains most of the organic products?

SELECT a.aisle
	  ,COUNT (DISTINCT p.product_name) no_of_products
FROM orders o
INNER JOIN products p
ON o.product_id=p.product_id
INNER JOIN warehouse w
ON p.product_id=w.product_id
INNER JOIN aisle a
ON w.aisle_id=a.aisle_id
WHERE LOWER(p.product_name) LIKE '%organic%'
GROUP BY a.aisle
ORDER BY no_of_products DESC
LIMIT 1



-- 5. Which aisle/s can I find the non-alcoholic drinks?

SELECT a.aisle
FROM orders o
INNER JOIN products p ON o.product_id = p.product_id
INNER JOIN warehouse w ON p.product_id = w.product_id
INNER JOIN aisle a ON w.aisle_id = a.aisle_id
WHERE (LOWER(p.product_name) LIKE '%non-alcoholic%'
OR LOWER(p.product_name) LIKE '%non alcoholic%')
AND a.aisle <> 'red wines'
GROUP BY a.aisle;

