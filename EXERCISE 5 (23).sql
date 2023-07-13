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
);



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



CREATE TABLE order_date_status (
order_id int REFERENCES orders(order_id),
order_date date,
order_status VARCHAR(100)
)

CREATE TABLE product_cost_price (
product_id int REFERENCES products(product_id),
unit_price float,
unit_cost float)


ALTER TABLE order_date_status ADD FOREIGN KEY (order_id) REFERENCES orders (order_id);
ALTER TABLE product_cost_price ADD FOREIGN KEY (product_id) REFERENCES products (product_id);



-- Q & A

-- 1. How have the orders changed over time(monthly)?

WITH cte AS (
SELECT TO_CHAR(os.order_date,'YYYY MONTH') month_name
	  ,COUNT(1) current_month_orders
	  ,LAG(COUNT(1)) OVER(ORDER BY EXTRACT(YEAR FROM os.order_date)
						         ,EXTRACT(MONTH FROM os.order_date)) previous_month_orders
FROM orders o
INNER JOIN order_date_status os
ON o.order_id=os.order_id
GROUP BY TO_CHAR(os.order_date,'YYYY MONTH')
		,EXTRACT(YEAR FROM os.order_date)
	    ,EXTRACT(MONTH FROM os.order_date)
ORDER BY EXTRACT(YEAR FROM os.order_date)
	    ,EXTRACT(MONTH FROM os.order_date)
)
SELECT month_name
	  ,current_month_orders
	  ,previous_month_orders
	  ,CASE WHEN previous_month_orders IS NULL THEN 'NA'
	  	    ELSE CONCAT(ROUND((current_month_orders-previous_month_orders)*100/previous_month_orders,2),'%')
	        END perc_change
FROM cte




-- 2. Are there any weekly flucatuations in the size of orders?

WITH cte AS (
SELECT TO_CHAR(os.Order_date,'YYYY IW') week_no
	  ,COUNT(1) current_week_orders
	  ,LAG(COUNT(1)) OVER (ORDER BY TO_CHAR(os.Order_date,'YYYY IW')) previous_week_orders
FROM orders o
INNER JOIN order_date_status os
ON o.order_id=os.order_id
GROUP BY TO_CHAR(Order_date,'YYYY IW')
)
SELECT week_no
	  ,current_week_orders
	  ,previous_week_orders
	  ,CASE WHEN previous_week_orders IS NULL THEN 'NA'
	        ELSE CONCAT(ROUND((current_week_orders-previous_week_orders)*100.0/previous_week_orders,2),'%')
			END perc_change
FROM cte




-- 3. What is the average number of orders placed by day of the week?

WITH cte AS (
SELECT EXTRACT(WEEK FROM os.order_date) week_no
	  ,o.order_dow
	  ,COUNT(1) orders
FROM orders o
INNER JOIN order_date_status os
ON o.order_id=os.order_id
GROUP BY EXTRACT(WEEK FROM os.order_date),o.order_dow
)
SELECT CASE order_dow
        WHEN 0 THEN 'Sunday'
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        WHEN 6 THEN 'Saturday'
      END AS day_of_week
	 ,ROUND(AVG(orders),0) avg_no_of_orders
FROM cte 
GROUP BY order_dow
ORDER BY order_dow




--4.What is the hour of the day with the highest number of orders?

SELECT order_hour_of_day
	  ,COUNT(1) no_of_orders
FROM orders
GROUP BY order_hour_of_day
ORDER BY no_of_orders DESC
LIMIT 1




--5.Which department has the highest average spend per customer?

SELECT d.department
	  ,CONCAT('$', CAST(SUM(p.unit_price)/COUNT(1) AS DECIMAL(15,2))) avg_spendings
FROM orders o
INNER JOIN product_cost_price p
ON o.product_id=p.product_id
INNER JOIN departments d
ON o.department_id=d.department_id
GROUP BY d.department
ORDER BY avg_spendings DESC
LIMIT 1




-- 6.Which product generated more profit?

SELECT p.product_name
	  , CONCAT('$', CAST(SUM(unit_price)-SUM(unit_cost) AS DECIMAL(15,2))) AS profit
FROM orders o
INNER JOIN products p
ON o.product_id=p.product_id
INNER JOIN product_cost_price pc
ON p.product_id=pc.product_id
GROUP BY p.product_name
ORDER BY SUM(unit_price)-SUM(unit_cost) DESC
LIMIT 1


 --7. What are the 3 aisles with the most orders, and which departments do those orders belong to?

SELECT a.aisle
	  ,d.department
	  ,COUNT(1) orders
FROM orders o
INNER JOIN products p
ON o.product_id=p.product_id
INNER JOIN warehouse w
ON p.product_id=w.product_id
INNER JOIN aisle a
ON w.aisle_id=a.aisle_id
INNER JOIN departments d
ON o.department_id=d.department_id
GROUP BY a.aisle,d.department
ORDER BY orders DESC
LIMIT 3




-- 8.Which 3 users generated the highest revenue and how many aisles did they order from?

SELECT o.user_id
	  , CONCAT('$', CAST(SUM(pc.unit_price) AS DECIMAL(15,2))) AS revenue
	  , COUNT(DISTINCT w.aisle_id) AS no_of_aisles
FROM orders o
INNER JOIN product_cost_price pc
ON o.product_id=pc.product_id
INNER JOIN warehouse w
ON pc.product_id=w.product_id
GROUP BY o.user_id
ORDER BY SUM(pc.unit_price) DESC
LIMIT 3

						
-- 9. Using the Instacart db, what is the average number of days between orders 
--for users who have made at least 10 orders?

SELECT CONCAT(ROUND(AVG(days_since_prior_order)), ' DAYS') AS avg_days_between_orders
FROM (
  SELECT user_id, days_since_prior_order
  FROM orders
  WHERE user_id IN (
    SELECT user_id
    FROM orders
    GROUP BY user_id
    HAVING COUNT(DISTINCT order_id) >= 10
  )
  GROUP BY user_id, days_since_prior_order
) t;


/*In the given query, t is an alias for the derived table 
obtained from the subquery. The subquery is used to filter 
the results and only consider the users who have made at 
least 10 orders. The resulting table is then aliased as t. 
The outer query then calculates the average of the days_
since_prior_order column for the filtered set of users.*\


-- 10 find customers who have made more than 10 orders?

SELECT user_id, COUNT(DISTINCT order_id) as num_orders
 FROM orders
GROUP BY user_id
HAVING COUNT(DISTINCT order_id) >= 10;





