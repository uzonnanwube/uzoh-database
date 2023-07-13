/*In the excercise1, add unit cost column to the product table and update 
the table and insert into the unit cost 95% of the uni price.*/

/* Normalize the table; exercise2.cab to meet the 1NF, 2NF, 3NF. 
Create the table relationship in Postgres and insert the data accordingly 
Note: The price in the “price” field is the unit price for each item sold in a restaurant.
For example, Italiano pizza ( mushroom pizza, margherita izza). Mushroom 
pizza item is sold at 25.5 and Magherita pizza is also 25.5.*/



CREATE TABLE Product (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(50),
  description TEXT,
  product_category VARCHAR(50),
  unit_price DECIMAL(10,2)
);


-- Add unit_cost column to the product table
ALTER TABLE product
ADD COLUMN unit_cost DECIMAL(10,2);

-- Update the unit_cost column with 95% of the unit_price
UPDATE product
SET unit_cost = unit_price * 0.95;



CREATE TABLE Customers (
  customer_id SERIAL PRIMARY KEY,
  customer_name VARCHAR(255) NOT NULL,
  customer_address TEXT NOT NULL,
  customer_email VARCHAR(255) NOT NULL
);



CREATE TABLE Restaurants (
  restaurant_id SERIAL PRIMARY KEY,
  restaurant_name VARCHAR(255) NOT NULL,
  restaurant_address_line1 TEXT NOT NULL,
  restaurant_address_line2 TEXT,
  restaurant_city VARCHAR(255) NOT NULL,
  restaurant_state VARCHAR(255) NOT NULL,
  restaurant_zip_code VARCHAR(10) NOT NULL
);


SELECT * FROM ORDERS
CREATE TABLE Orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INTEGER REFERENCES Customers(customer_id),
  restaurant_id INTEGER REFERENCES Restaurants(restaurant_id),
  order_quantity INTEGER NOT NULL,
  order_date DATE NOT NULL,
  price NUMERIC(10,2) NOT NULL,
  item_description TEXT NOT NULL
);





