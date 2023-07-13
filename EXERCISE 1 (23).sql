/*Exercise 1
Customer table: customer_id(primary key), customer_name, email, phone.

Order table : order_id (primary key), customer_id (foreign key), 
order_date, product _id (foreign key), quantity, delivery _status.

Product table: product_id(primary key), product _name, description, 
product _category, unit_price.

Payment table: payment _id(primary key), order_id, order _id,
(foreign key), payment _date.

--TIP
Product Table (Example of an electronic store data)
1. ‘iPhone 13’  ‘Apple smartphone’  ‘Mobile Phone’ 1099.99
2.  ‘Galaxy S21’  ‘Samsung smartphone’  ‘Mobile phone’  899.99
3. ‘Pixel 6’  Goggle smartphone’  ‘Mobile phone’  799.99
4. ‘MacBook Pro’ ‘Apple laptop M3 chip’ ‘Laptop’  2199.99
5.  ‘ Thinkpad X1 carbon’  ‘lenevo laptop 16gb RAM 1TB’ ‘Laptop’ 1899.99
6 ...

Order_table (delivery _status) column.
* ‘Shipped’
* ‘processing’
* ‘Delivered’

Note 
* The customer’s table will have 100 rows of unique customers and not 
less than 40% have made purchases.
* Feel free to choose any type of store such as electronics, groceries, 
or fashion store, or even  create a general database similar to Amazon’s 
that offers a wide range of products.*/


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



DROP TABLE creditcard cascade

ALTER TABLE product
ADD COLUMN unit_cost DECIMAL(10,2);

UPDATE product
SET unit_cost = unit_price * 0.95;

UPDATE product
SET unit_price = unit_cost + (unit_price - unit_cost)/1.05;





