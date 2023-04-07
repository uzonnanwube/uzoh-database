"1NF"

CREATE TABLE Customer (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50),
  customer_address VARCHAR(100),
  customer_email VARCHAR(50)
);

CREATE TABLE "Order" (
  customer_id INT,
  order_quantity INT,
  order_date DATE,
  price DECIMAL(10,2),
  restaurant_name VARCHAR(50),
  item_description VARCHAR(100),
  restaurant_address_line1 VARCHAR(100),
  restaurant_address_line2 VARCHAR(100),
  restaurant_city VARCHAR(50),
  restaurant_state VARCHAR(50),
  restaurant_zip_code VARCHAR(10),
  PRIMARY KEY (customer_id, order_date, restaurant_name, item_description),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);



"2NF"

CREATE TABLE Customer (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50),
  customer_address VARCHAR(100),
  customer_email VARCHAR(50)
);

CREATE TABLE Restaurant (
  restaurant_name VARCHAR(50) PRIMARY KEY,
  restaurant_address_line1 VARCHAR(100),
  restaurant_address_line2 VARCHAR(100),
  restaurant_city VARCHAR(50),
  restaurant_state VARCHAR(50),
  restaurant_zip_code VARCHAR(10)
);

CREATE TABLE Order (
  customer_id INT,
  order_quantity INT,
  order_date DATE,
  restaurant_name VARCHAR(50),
  item_description VARCHAR(100),
  price DECIMAL(10,2),
  PRIMARY KEY (customer_id, order_date, restaurant_name, item_description),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
  FOREIGN KEY (restaurant_name) REFERENCES Restaurant(restaurant_name)
);



"3NF"

CREATE TABLE Customer (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50),
  customer_address VARCHAR(100),
  customer_email VARCHAR(50)
);

CREATE TABLE Restaurant (
  restaurant_name VARCHAR(50) PRIMARY KEY,
  restaurant_address_line1 VARCHAR(100),
  restaurant_address_line2 VARCHAR(100),
  restaurant_city VARCHAR(50),
  restaurant_state VARCHAR(50),
  restaurant_zip_code VARCHAR(10)
);

CREATE TABLE Menu (
  restaurant_name VARCHAR(50),
  item_description VARCHAR(100),
  price DECIMAL(10,2),
  PRIMARY KEY (restaurant_name, item_description),
  FOREIGN KEY (restaurant_name) REFERENCES Restaurant(restaurant_name)
);

CREATE TABLE "Order" (
  customer_id INT,
  order_quantity INT,
  order_date DATE,
  restaurant_name VARCHAR(50),
  item_description VARCHAR(100),
  PRIMARY KEY (customer_id, order_date, restaurant_name, item_description),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
  FOREIGN KEY (restaurant_name, item_description) REFERENCES Menu(restaurant_name, item_description)
);



INSERT INTO Customer (customer_id, customer_name, customer_address, customer_email) 
VALUES (1, 'John Smith', '123 Main St', 'johnsmith@gmail.com'),
       (2, 'Jane Doe', '456 Park Ave', 'janedoe@gmail.com'),
       (3, 'Bob Johnson', '789 Elm St', 'bobjohnson@gmail.com'),
       (4, 'Okafor Ikechukwu', '083 John st', 'okaforikechukwu@gmail,com'),
       (5, 'Jeffery Godson', '92 Ikenga st', 'jefgodson@gmail.com'),
       (6, 'Jane Dan', '456 Main st', 'jandan@gmail.com');
	   
	   
INSERT INTO Restaurant (restaurant_name, restaurant_address_line1, restaurant_address_line2, restaurant_city, restaurant_state, restaurant_zip_code) 
VALUES 
('Italiano Pizza', '123 Main St', NULL, 'New York City', 'New York', '10001'),
('Breakfast Cafe', '456 Elm st', NULL, 'Boston City', 'Massachusetts', '2110'),
('Burger King', '336 Main St', NULL, 'New York City', 'New York', '13201'),
('Afro Kitchen', '076 Hamburg st', NULL, 'Hamburg City', 'Hamburg', '10032'),
('Afro Food', '123 Hamburg st', NULL, 'Hamburg city', 'Hamburg', '10041');


INSERT INTO Menu (restaurant_name, item_description, price) 
VALUES 
('Italiano Pizza', 'Tuner Fish Pizza', 25.50),
('Italiano Pizza', 'Margherita Pizza', 25.50),
('Italiano Pizza', 'Mushroom Pizza', 25.50),
('Italiano Pizza', 'Margherita Pizza', 25.50),
('Breakfast Cafe', 'Black Coffee', 26.99),
('Breakfast Cafe', 'Sausage', 26.99),
('Breakfast Cafe', 'Macaroni', 10.99), 
('Breakfast Cafe', 'Oxtail', 10.99),
('Breakfast Cafe', 'Custard', 10.99),	
('Breakfast Cafe', 'Beans', 10.99),	
('Burger King', 'Burger', 35.78),	
('Burger King', 'Cola', 35.78),
('Burger King', 'Chicken', 35.78),	
('Burger King', 'Cheese burger', 24.65),	
('Burger King', 'Fanta', 24.65),	
('Burger King', 'Chicken', 24.65),	
('Afro Kitchen', 'Abacha', 45.00),	
('Afro Kitchen', 'Nkwobi', 45.00),
('Afro Kitchen', 'Oha soup', 45.00),	
('Afro Food', 'Ugba', 50.00);

	 
		
INSERT INTO "Order" (customer_id, order_quantity, order_date, restaurant_name, item_description)
VALUES (1, 2, '2022-07-02 00:00', 'Italiano Pizza', 'Tuner Fish pizza'),
       (1, 2, '2023-02-16 00:00', 'Italiano Pizza', 'Mushroom pizza, Margherita'),
       (2, 2, '2022-11-29 00:00', 'Breakfast Cafe', 'Black Coffee, Sausage'),
       (2, 2, '2022-09-22 00:00', 'Breakfast Cafe', 'Macaroni, Black Coffee'),
       (2, 1, '2023-02-27 00:00', 'Breakfast Cafe', 'Oxtail'),
       (2, 2, '2022-12-20 00:00', 'Breakfast Cafe', 'Custard, Beans'),
       (3, 3, '2022-11-12 00:00', 'Burger King', 'Burger, Cola, Chicken'),
       (3, 3, '2022-06-16 00:00', 'Burger King', 'Cheeseburger, Fanta, Chicken'),
       (4, 3, '2022-05-03 00:00', 'Afro Kitchen', 'Abacha, Nkwobi, Oha'),
       (5, 2, '2022-05-03 00:00', 'Afro Foods', 'Ugba'),
       (6, 1, '2022-02-21 00:00', 'Italiano Pizza', 'Margherita Pizza');

	
INSERT INTO "Order" (customer_id, order_quantity, order_date, Price, restaurant_name, item_description, Restaurant_address_line1, Restaurant_address_line2,Restaurant_city, Restaurant_state, Restaurant_zip_code)
VALUES ((1, 2, '2022-07-02 00:00', 25.50, 'Italiano Pizza', 'Tuner Fish pizza', '123 Main st', NULL, 'New York City', 'New York', '10001'),
       (1, 2, '2023-02-16 00:00', 25.50, 'Italiano Pizza', 'Mushroom pizza, Margherita', '123 Main st', NULL,'New York City', 'New York', '10001'),
       (2, 2, '2022-11-29 00:00', 26.99, 'Breakfast Cafe', 'Black Coffee, Sausage', '456 Elm st', NULL, 'Boston City', 'Massachusetts', '2110'),
       (2, 2, '2022-09-22 00:00', 26.99, 'Breakfast Cafe', 'Macaroni, Black Coffee', '456 Elm st', NULL, 'Boston City', 'Massachusetts', '2110'),
       (2, 1, '2023-02-27 00:00', 10.99, 'Breakfast Cafe', 'Oxtail', '456 Elm st', NULL, 'Boston City', 'Massachusetts', '2110' ),
       (2, 2, '2022-12-20 00:00', 10.99, 'Breakfast Cafe', 'Custard, Beans', '456 Elm st', NULL, 'Boston City', 'Massachusetts', '2110'),
       (3, 3, '2022-11-12 00:00', 35.78, 'Burger King', 'Burger, Cola, Chicken', '336 Main st', NULL, 'New York City', 'New York', '13201'),
       (3, 3, '2022-06-16 00:00', 24.65, 'Burger King', 'Cheeseburger, Fanta, Chicken','336 Main st', NULL, 'New York City', 'New York', '13201' ),
	   (4, 3, '2022-05-03 00:00', 45.00, 'Afro Kitchen', 'Abacha, Nkwobi, Oha', '076 Hamburg st', NULL, 'Hamburg City', 'Hamburg', '10032') ,
	   (5, 2, '2022-05-03 00:00', 50.00, 'Afro Foods', 'Ugba', '123 Main st', NULL, 'Hamburg City', 'Hamburg', '10041'),
       (6, 1, '2022-02-21 00:00', 25.00, 'Italiano Pizza', 'Margherita Pizza', '123 Main st', NULL, 'New York City', 'New York','10001');
	   


INSERT INTO "Order" (customer_id, order_quantity, order_date, price, restaurant_name, item_description, Restaurant_address_line1, Restaurant_address_line2, Restaurant_city, Restaurant_state, Restaurant_zip_code)
VALUES ((1, 2, '2022-07-02 00:00', 25.50, 'Italiano Pizza', 'Tuner Fish pizza', '123 Main st', NULL, 'New York City', 'New York', '10001'),
       (1, 2, '2023-02-16 00:00', 25.50, 'Italiano Pizza', 'Mushroom pizza, Margherita', '123 Main st', NULL,'New York City', 'New York', '10001'),
       (2, 2, '2022-11-29 00:00', 26.99, 'Breakfast Cafe', 'Black Coffee, Sausage', '456 Elm st', NULL, 'Boston City', 'Massachusetts', '2110'),
       (2, 2, '2022-09-22 00:00', 26.99, 'Breakfast Cafe', 'Macaroni, Black Coffee', '456 Elm st', NULL, 'Boston City', 'Massachusetts', '2110'),
       (2, 1, '2023-02-27 00:00', 10.99, 'Breakfast Cafe', 'Oxtail', '456 Elm st', NULL, 'Boston City', 'Massachusetts', '2110' ),
       (2, 2, '2022-12-20 00:00', 10.99, 'Breakfast Cafe', 'Custard, Beans', '456 Elm st', NULL, 'Boston City', 'Massachusetts', '2110'),
       (3, 3, '2022-11-12 00:00', 35.78, 'Burger King', 'Burger, Cola, Chicken', '336 Main st', NULL, 'New York City', 'New York', '13201'),
       (3, 3, '2022-06-16 00:00', 24.65, 'Burger King', 'Cheeseburger, Fanta, Chicken','336 Main st', NULL, 'New York City', 'New York', '13201' ),
	   (4, 3, '2022-05-03 00:00', 45.00, 'Afro Kitchen', 'Abacha, Nkwobi, Oha', '076 Hamburg st', NULL, 'Hamburg City', 'Hamburg', '10032') ,
	   (5, 2, '2022-05-03 00:00', 50.00, 'Afro Foods', 'Ugba', '123 Main st', NULL, 'Hamburg City', 'Hamburg', '10041'),
       (6, 1, '2022-02-21 00:00', 25.00, 'Italiano Pizza', 'Margherita Pizza', '123 Main st', NULL, 'New York City', 'New York','10001'));

drop table "Order" cascade


