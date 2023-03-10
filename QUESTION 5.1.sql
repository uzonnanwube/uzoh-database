Select * from public. "Superstore"


5.1 In the year 2017, what was the total profit generated in California ?

SELECT SUM("Profit") as total_profit
FROM public. "Superstore"
WHERE "State" = 'California' AND EXTRACT(YEAR FROM "OrderDate") = 2017;

(You can also use the following query to see the total profit by month in California in 2017:)

SELECT EXTRACT(MONTH FROM "OrderDate") as month, SUM("Profit") as total_profit
FROM "Superstore"
WHERE "State" = 'California' AND EXTRACT(YEAR FROM "OrderDate") = 2017
GROUP BY month
ORDER BY month;


5.2 Which product sub-category sells the most in the Cities Roseville and Henderson?

select "Sub-Category", SUM("Sales")
FROM public."Superstore"
WHERE "City" IN ('Roseville','Henderson')
GROUP BY "Sub-Category"

SELECT "Sub-Category", SUM("Sales") as total_sales
FROM public."Superstore"
WHERE "City" IN ('Roseville', 'Henderson')
GROUP BY "Sub-Category"
order by total_sales DESC;


5.3 What is the average shipping time in the Region "South"

SELECT "ShipDate",  ('AverageShippingTime')
FROM public."Superstore"
WHERE 'Region' ='South'

SELECT AVG ("ShipDate") as AverageShippingTime
FROM PUBLIC. "Superstore"
WHERE Region='South'


5.4 What is the total sales by category?

SELECT "Category", SUM("Sales") as Total_Sales
FROM PUBLIC. "Superstore"
GROUP BY "Category"

(You can also use the following query to see the total sales by category and region:)



SELECT "Category", "Region", SUM("Sales") as total_sales
FROM PUBLIC. "Superstore"
GROUP BY "Category", "Region";


5.5 Which customer made the most purchase from 2014-2017 and how many orders has he made?

SELECT "CustomerName", COUNT(*) as num_orders
FROM public. "Superstore"
WHERE "OrderDate" >= '2014-01-01' AND "OrderDate" < '2018-01-01'
GROUP BY "CustomerName"
ORDER BY num_orders DESC
LIMIT 1;


5.6 Which product sub-category made the most profit in the WEST Region?

SELECT "Sub-Category", SUM("Profit") as total_profit
FROM public. "Superstore"
WHERE "Region" = 'WEST'
GROUP BY "Sub-Category"
ORDER BY total_profit DESC
LIMIT 1;


