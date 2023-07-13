
EXCERCISE 8
Use exercise 1 DB

/*1. Identify the 10 least performing products and prepare a customer
survey with a question like; 
"On a scale of 1-10, how likely are you to recommend these products to a friend or colleague"? 
Use other groups as your customers. (For example, Group A will get customer feedback
from members of the other 4 groups)

 2. From the data collected in 1, analyze the NPS for each of the 10
least performing products and what is the percentage of passive respondents?*/


--Exercise 1DB has the following tables


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



--Survey table follows thus,



CREATE TABLE Surveyquestionnairedata (
    product_id int PRIMARY KEY,
    product_name VARCHAR,
    A int,
    B int,
    C int,
	D int,
	E int,
	F int,
	G int,
	H int,
	I int,
	J int,
	K int,
	L int,
	M int,
	N int,
	O int,
	P int,
	Q int,
	R int,
	S int,
	T int,
	U int,
	V int,
	W int,
	X int,
	Y int,
	Z int,
	A2 int,
    B2 int,
    C2 int,
	D2 int,
	E2 int,
	F2 int,
	G2 int,
	H2 int,
	I2 int,
	J2 int,
	K2 int,
	L2 int,
	M2 int,
	N2 int,
	O2 int,
	P2 int,
	Q2 int,
	R2 int,
	S2 int,
	T2 int,
	U2 int,
	V2 int,
	W2 int,
	X2 int,
	Y2 int,
	Z2 int,
	A3 int,
    B3 int,
    C3 int,
	D3 int,
	E3 int,
	F3 int,
	G3 int,
	H3 int,
	I3 int,
	J3 int,
	K3 int,
	L3 int,
	M3 int,
	N3 int,
	O3 int,
	P3 int,
	Q3 int,
	R3 int,
	S3 int,
	T3 int,
	U3 int,
	V3 int,
	W3 int,
	X3 int,
	Y3 int,
	Z3 int,
	A4 int,
    B4 int,
    C4 int,
	D4 int,
	E4 int,
	F4 int,
	G4 int,
	H4 int,
	I4 int,
	J4 int,
	K4 int,
	L4 int,
	M4 int,
	N4 int,
	O4 int,
	P4 int,
	Q4 int,
	R4 int,
	S4 int,
	T4 int,
	U4 int,
	V4 int,
	W4 int,
	X4 int,
	Y4 int,
	Z4 int	
)




CREATE TEMP TABLE temp_Surveyquestionnairedata (
    product_id int PRIMARY KEY,
    product_name VARCHAR,
    A int,
    B int,
    C int,
	D int,
	E int,
	F int,
	G int,
	H int,
	I int,
	J int,
	K int,
	L int,
	M int,
	N int,
	O int,
	P int,
	Q int,
	R int,
	S int,
	T int,
	U int,
	V int,
	W int,
	X int,
	Y int,
	Z int,
	A2 int,
    B2 int,
    C2 int,
	D2 int,
	E2 int,
	F2 int,
	G2 int,
	H2 int,
	I2 int,
	J2 int,
	K2 int,
	L2 int,
	M2 int,
	N2 int,
	O2 int,
	P2 int,
	Q2 int,
	R2 int,
	S2 int,
	T2 int,
	U2 int,
	V2 int,
	W2 int,
	X2 int,
	Y2 int,
	Z2 int,
	A3 int,
    B3 int,
    C3 int,
	D3 int,
	E3 int,
	F3 int,
	G3 int,
	H3 int,
	I3 int,
	J3 int,
	K3 int,
	L3 int,
	M3 int,
	N3 int,
	O3 int,
	P3 int,
	Q3 int,
	R3 int,
	S3 int,
	T3 int,
	U3 int,
	V3 int,
	W3 int,
	X3 int,
	Y3 int,
	Z3 int,
	A4 int,
    B4 int,
    C4 int,
	D4 int,
	E4 int,
	F4 int,
	G4 int,
	H4 int,
	I4 int,
	J4 int,
	K4 int,
	L4 int,
	M4 int,
	N4 int,
	O4 int,
	P4 int,
	Q4 int,
	R4 int,
	S4 int,
	T4 int,
	U4 int,
	V4 int,
	W4 int,
	X4 int,
	Y4 int,
	Z4 int	
);


COPY temp_Surveyquestionnairedata(product_id, product_name, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
								   A2, B2, C2, D2, E2, F2, G2, H2, I2, J2, K2, L2, M2, N2, O2, P2, Q2, R2, S2, T2, U2, V2, W2, X2, Y2, Z2,
								   A3, B3, C3, D3, E3, F3, G3, H3, I3, J3, K3, L3, M3, N3, O3, P3, Q3, R3, S3, T3, U3, V3, W3, X3, Y3, Z3,
								   A4, B4, C4, D4, E4, F4, G4, H4, I4, J4, K4, L4, M4, N4, O4, P4, Q4, R4, S4, T4, U4, V4, W4, X4, Y4, Z4)
    							  
FROM 'C:\Users\uzonnanwube\Downloads\Surveyquestionnairedata.csv'
DELIMITER ',' CSV HEADER;


update Surveyquestionnairedata as  s
set product_name = s.product_name, A = s.A, B = s.B, C = s.C, E = s.E, F = s.F, G = s.G, H = s.H, I = s.I, J = s.J, K = s.K, L = s.L, M = s.M, N = s.N, O =s.O, P = s.P, Q = s.Q, R = s.R, S = s.S, T = s.T, U = s.U, V = s.V, W = s.W, X = s.X, Y = s.Y, Z = s.Z,
								   A2 = s.A2, B2 = s.B2, C2 = s.C2, D2 = s.D2, E2 = s.E2, F2 = s.F2, G2 = s.G2, H2 = s.H2, I2 = s.I2, J2 = s.J2, K2 = s.K2, L2 = s.L2, M2 = s.M2, N2 = s.N2, O2 = s.O2, P2 = s.P2, Q2 = s.Q2, R2 = s.R2, S2 = s.S2, T2 = s.T2, U2 = s.U2, V2 = s.V2, W2 = s.W2, X2 = s.X2, Y2 = s.Y2, Z2 = s.Z2,
								   A3 = s.A3, B3 = s.B3, C3 = s.C3, D3 = s.D3, E3 = s.E3, F3 = s.F3, G3 = s.G3, H3 = s.H3, I3 = s.I3, J3 = s.J3, K3 = s.K3, L3 = s.L3, M3 = s.M3, N3 = s.N3, O3 = s.O3, P3 = s.P3, Q3 = s.Q3, R3 = s.R3, S3 = s.S3, T3 = s.T3, U3 = s.U3, V3 = s.V3, W3 = s.W3, X3 = s.X3, Y3 = s.Y3, Z2 = s.Z2,
								   A4 = s.A4, B4 = s.B4, C4 = s.C4, D4 = s.D4, E4 = s.E4, F4 = s.F4, G4 = s.G4, H4 = s.H4, I4 = s.I4, J4 = s.J4, K4 = s.K4, L4 = s.L4, M4 = s,M4, N4 = s.N4, O4 = s.O4, P4 = s.P4, Q4 = s.Q4, R4 = s.R4, S4 = s.S4, T4 = s.T4, U4 = s.U4, V4 = s.V4, W4 = s.W4, X4 = s.X2, Y4 = s.Y4, Z4 = s.Z4)
from temp_Surveyquestionnairedata as s
where s.product_id = s.product_id;





--1a. Identify the 10 least performing products 

SELECT o.product_id, p.product_name, SUM(quantity) AS total_quantity, 
SUM(quantity * p.unit_price) AS total_salesUSD
FROM orders o
JOIN product p ON o.product_id = p.product_id
GROUP BY o.product_id, p.product_name
ORDER BY total_salesUSD ASC
limit 10;



/*From the data collected in 1, analyze the NPS for each of the 10
least performing products and what is the percentage of passive respondents?*/

--2: Calculate NPS and percentage of passive respondents for each of the 10 least performing products

SELECT lpp.product_id, lpp.product_name,
       ((COUNT(CASE WHEN A >= 9 THEN 1 END) - COUNT(CASE WHEN A <= 6 THEN 1 END) +
         COUNT(CASE WHEN B >= 9 THEN 1 END) - COUNT(CASE WHEN B <= 6 THEN 1 END) +
         COUNT(CASE WHEN C >= 9 THEN 1 END) - COUNT(CASE WHEN C <= 6 THEN 1 END) +
         COUNT(CASE WHEN D >= 9 THEN 1 END) - COUNT(CASE WHEN D <= 6 THEN 1 END) +
         -- Continue this pattern for columns E to Z4
         COUNT(CASE WHEN Z4 >= 9 THEN 1 END) - COUNT(CASE WHEN Z4 <= 6 THEN 1 END)) * 100 / 
         (COUNT(A) + COUNT(B) + COUNT(C) + COUNT(D) + -- Continue this pattern for columns E to Z4
         COUNT(Z4))) AS nps,
       CONCAT(((COUNT(CASE WHEN A = 7 OR A = 8 THEN 1 END) +
         COUNT(CASE WHEN B = 7 OR B = 8 THEN 1 END) +
         COUNT(CASE WHEN C = 7 OR C = 8 THEN 1 END) +
         COUNT(CASE WHEN D = 7 OR D = 8 THEN 1 END) +
         -- Continue this pattern for columns E to Z4
         COUNT(CASE WHEN Z4 = 7 OR Z4 = 8 THEN 1 END)) * 100 / 
         (COUNT(A) + COUNT(B) + COUNT(C) + COUNT(D) + -- Continue this pattern for columns E to Z4
         COUNT(Z4))), '%') AS passive_percentage
FROM (
  -- Filter the least performing products
  SELECT product_id, product_name
  FROM surveyquestionnairedata
  ORDER BY (A + B + C + D + E + F + G + H + I + J + K + L + M + N + O + P + Q +
            R + S + T + U + V + W + X + Y + Z + A2 + B2 + C2 + D2 + E2 + F2 +
            G2 + H2 + I2 + J2 + K2 + L2 + M2 + N2 + O2 + P2 + Q2 + R2 + S2 +
            T2 + U2 + V2 + W2 + X2 + Y2 + Z2 + A3 + B3 + C3 + D3 + E3 + F3 +
            G3 + H3 + I3 + J3 + K3 + L3 + M3 + N3 + O3 + P3 + Q3 + R3 + S3 +
            T3 + U3 + V3 + W3 + X3 + Y3 + Z3 + A4 + B4 + C4 + D4 + E4 + F4 +
            G4 + H4 + I4 + J4 + K4 + L4 + M4 + N4 + O4 + P4 + Q4 + R4 + S4 +
            T4 + U4 + V4 + W4 + X4 + Y4 + Z4) ASC
  LIMIT 10
) AS lpp
JOIN surveyquestionnairedata sd ON sd.product_id = lpp.product_id
GROUP BY lpp.product_id, lpp.product_name;




/* An NPS (Net Promoter Score) of 40 indicates a positive sentiment among respondents.
 NPS ranges from -100 to +100 and is used to measure customer satisfaction and loyalty. 
 A score above 0 is generally considered positive, and higher scores indicate higher 
 customer satisfaction and loyalty. Therefore, an NPS of 40 suggests that the majority 
 of respondents have a positive perception of the product or service.

 A passive percentage of 20% means that 20% of the respondents fall into the "passive" 
category. In the context of NPS, "passives" are customers who are moderately satisfied 
but not strongly loyal or likely to promote the product or service. They may be somewhat 
indifferent or ambivalent. Typically, passives have ratings of 7 or 8 on a scale of 0 to 10

Overall, an NPS of 40 with a passive percentage of 20% suggests a generally positive 
sentiment among respondents, but there is still room for improvement in increasing 
customer loyalty and advocacy




/*The three categories of people encountered while carrying out the survey includes;

*PROMOTERS: Customers who rate the product 9-10. These customers are 
 considered LOYAL enthusiasts who are likely to continue using the product and 
 recommend it to others.

*PASSIVES: Customers who rate the product 7-8. These customers are considered 
 SATISFIED but not necessarily loyal. They may be open to alternatives and may 
 switch to a competitor if a better option becomes available.

*DETRACTORS: Customers who rate the product 1-6. These customers are 
 considered UNHAPPY and may even discourage others from using the product.


