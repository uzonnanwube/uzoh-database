Select * from public. "Superstore"

Exercise 6
6.1 What is the profit ratio of each sub-category product and which one has the highest?

SELECT "Sub-Category", sum("Profit")/sum("Sales") as profit_ratio
FROM PUBLIC."Superstore" GROUP BY "Sub-Category"
ORDER BY profit_ratio DESC;

(Note that this query will return a row for each sub-category,
even if the sub-category has a profit ratio of zero or a null value. 
If you only want to see sub-categories with a non-zero profit ratio, 
you can add a WHERE clause to the query to filter out sub-categories 
with a zero or null value for the profit_ratio column:)

SELECT "Sub-Category", sum("Profit")/sum("Sales") as profit_ratio
FROM PUBLIC. "Superstore" WHERE ("Profit") IS NOT NULL 
AND ("Profit") > 0 GROUP BY "Sub-Category" 
ORDER BY profit_ratio DESC;


6.2 Considering the product sub-category sales in Texas, 
which 3 would you advise your manager to put in more resources on ads and why?

SELECT "Sub-Category", sum("Sales") as total_sales 
FROM PUBLIC. "Superstore" WHERE "State" = 'Texas' GROUP BY "Sub-Category" 
ORDER BY total_sales DESC LIMIT 3;

(Alternatively, if you want to consider both sales and profit 
 when making your recommendation, you can use the following query:)

SELECT "Sub-Category", sum("Sales") as total_sales, sum("Profit") as total_profit 
FROM "Superstore" WHERE "State" = 'Texas' GROUP BY "Sub-Category" 
ORDER BY total_profit DESC LIMIT 3;

6.3 Which shipping mode is most preferred by customers living in Philadelphia? 

SELECT "ShipMode", count(*) as num_orders 
FROM "Superstore" WHERE "City" = 'Philadelphia' GROUP BY "ShipMode" 
ORDER BY num_orders DESC LIMIT 1;

(Alternatively, if you want to consider the total sales or profit 
generated by each shipping mode, you can modify the query as follows:
To consider total sales:)

SELECT "ShipMode", sum("Sales") as total_sales 
FROM "Superstore" WHERE "City" = 'Philadelphia' GROUP BY "ShipMode" 
ORDER BY total_sales DESC LIMIT 1;

(To consider total profit:)

SELECT "ShipMode", sum("Profit") as total_profit 
FROM "Superstore" WHERE "City" = 'Philadelphia' GROUP BY "ShipMode" 
ORDER BY total_profit DESC LIMIT 1;


6.4 Which Product Segment do people buy the most in the city of Houston?   

SELECT "Segment", sum("Quantity") as total_quantity 
FROM "Superstore" WHERE "City" = 'Houston' GROUP BY "Segment" 
ORDER BY total_quantity DESC LIMIT 1;

(Alternatively, if you want to consider the total sales or 
profit generated by each product segment, you can modify the query as follows:
To consider total sales)

SELECT "Segment", sum("Sales") as total_sales 
FROM "Superstore" WHERE "City" = 'Houston' GROUP BY "Segment" 
ORDER BY total_sales DESC LIMIT 1;

(To consider total profit:)

SELECT "Segment", sum("Profit") as total_profit 
FROM "Superstore" WHERE "City" = 'Houston' GROUP BY "Segment" 
ORDER BY total_profit DESC LIMIT 1;


6.5 Which shipping mode has the lowest average shipping time?   

SELECT "ShipMode",  ("ShipDate") as "ShipDate"
FROM "Superstore" GROUP BY "ShipMode" ORDER BY "ShipDate" ASC;

SELECT "ShipMode", AVG  "ShipMode"  
FROM "Superstore" WHERE 'ShipTime' IS NOT NULL GROUP BY "ShipMode" 
ORDER BY AVG  "ShipMode" ASC;


6.6 How many Customers does the company have?              

SELECT COUNT(DISTINCT "CustomerID") FROM "Superstore";


SELECT COUNT(DISTINCT "CustomerName") FROM "Superstore";












