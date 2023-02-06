create table salesman
(salesman_id int primary key,
name varchar(20) not null,
city varchar(20) not null,
commission decimal(4,2) not null);

SELECT * FROM salesman


insert into salesman values(101,'Bhavya','Mumbai',0.15);
insert into salesman values(104,'Meet','Bengalore',0.13);
insert into salesman values(106,'Kishan','Kanpur',0.11);
insert into salesman values(108,'Dev','Noida',0.14);
insert into salesman values(110,'Raj','Mysore',0.13);
insert into salesman values(112,'Ajay','Mysore',0.12);

create table customer
(customer_id int primary key,
cust_name varchar(20) not null,
city varchar(20) not null,
grade int not null,
salesman_id int FOREIGN KEY REFERENCES salesman(salesman_id) not null);

SELECT * FROM customer

TRUNCATE TABLE customer

insert into customer values(300,'Jaydeep','Bengalore',100,101);
insert into customer values(301,'Bhargav','Mysore',100,101);
insert into customer values(305,'Ramya','Bengalore',300,104);
insert into customer values(308,'Raghu','Dharavad',400,104);
insert into customer values(309,'Rajesh','Hubli',200,108);
insert into customer values(312,'Ravi','Mangalore',500,106);
insert into customer values(456,'Rajdeep','Belagavi',300,110);

UPDATE customer SET city = 'Noida' WHERE
salesman_id = 108

UPDATE customer SET city = 'Kanpur' WHERE
salesman_id = 106

UPDATE customer SET city = 'Mysore' WHERE
salesman_id = 110

UPDATE customer SET city = 'Kanpur' WHERE
salesman_id = 104

create table orders
(ord_no int primary key,
purch_amt int not null,
ord_date date not null,
customer_id int FOREIGN KEY REFERENCES customer(customer_id) not null,
salesman_id int FOREIGN KEY REFERENCES salesman(salesman_id) not null);

SELECT * FROM orders


insert into orders values(20,10000,'2020-03-25',301,101);
insert into orders values(40,5000,'2020-03-25',305,104);
insert into orders values(60,9500,'2020-04-30',308,106);
insert into orders values(80,8700,'2020-07-01',309,108);
insert into orders values(100,1500,'2020-07-07',456,110);

SELECT * FROM salesman
SELECT * FROM customer
SELECT * FROM orders



/* Query-1: 
write a SQL query to find the salesperson and customer who reside in the same city.
Return Salesman, cust_name and city */

SELECT name , cust_name, salesman.city 
FROM salesman INNER JOIN customer ON salesman.salesman_id = customer.salesman_id
WHERE salesman.city = customer.city

/* Query-2: 
write a SQL query to find those orders where the order amount exists between 500
and 2000. Return ord_no, purch_amt, cust_name, city */

SELECT ord_no, purch_amt, cust_name, customer.city
FROM customer INNER JOIN orders ON customer.salesman_id = orders.salesman_id 
WHERE purch_amt BETWEEN 500 and 2000

/* Query-3: 
write a SQL query to find the salesperson(s) and the customer(s) he represents.
Return Customer Name, city, Salesman, commission */

SELECT cust_name as [Customer Name], salesman.city as [Salesman City], customer.city as [Customer City], commission
FROM salesman INNER JOIN customer ON salesman.salesman_id = customer.salesman_id

/* Query-4: 
write a SQL query to find salespeople who received commissions of more than 12
percent from the company. Return Customer Name, customer city, Salesman,
commission. */

SELECT cust_name as [Customer Name], customer.city as [Customer City], commission
FROM salesman INNER JOIN customer ON salesman.salesman_id = customer.salesman_id
WHERE commission > 0.12
ORDER BY commission

/* Query-5: 
write a SQL query to locate those salespeople who do not live in the same city where
their customers live and have received a commission of more than 12% from the
company. Return Customer Name, customer city, Salesman, salesman city,
commission */

SELECT cust_name as [Customer Name], customer.city as [Customer City], name, salesman.city as [Salesman City], commission
FROM salesman INNER JOIN customer ON salesman.salesman_id = customer.salesman_id
WHERE salesman.city <> customer.city and commission > 0.12

/* Query-6: 
write a SQL query to find the details of an order. Return ord_no, ord_date,
purch_amt, Customer Name, grade, Salesman, commission */

SELECT 
		ord_no, 
		ord_date, 
		purch_amt, 
		cust_name as [Customer Name], 
		grade, name as [Salesman], 
		commission
FROM salesman 
INNER JOIN customer ON salesman.salesman_id = customer.salesman_id
INNER JOIN orders ON salesman.salesman_id = orders.salesman_id


/* Query-7: 
Write a SQL statement to join the tables salesman, customer and orders so that the
same column of each table appears once and only the relational rows are returned.*/

SELECT 
		name,
		salesman.city,
		commission
		cust_name,
		customer.city,
		grade,
		ord_no,
		purch_amt,
		ord_date
FROM orders
INNER JOIN customer ON orders.customer_id = customer.customer_id
INNER JOIN salesman ON salesman.salesman_id = orders.salesman_id

/* Query-8: 
write a SQL query to display the customer name, customer city, grade, salesman,
salesman city. The results should be sorted by ascending customer_id.*/

SELECT cust_name as [Customer Name], customer.city as [Customer City], grade, name as [Salesman], salesman.city as [Salesman City]
FROM salesman 
INNER JOIN customer ON salesman.salesman_id = customer.salesman_id
ORDER BY customer_id

/* Query-9: 
write a SQL query to find those customers with a grade less than 300. Return
cust_name, customer city, grade, Salesman, salesmancity. The result should be
ordered by ascending customer_id.*/

SELECT cust_name as [Customer Name], customer.city as [Customer City], grade, name as [Salesman], salesman.city as [Salesman City]
FROM salesman 
INNER JOIN customer ON salesman.salesman_id = customer.salesman_id
WHERE grade < 300
ORDER BY customer_id

/* Query-10: 
Write a SQL statement to make a report with customer name, city, order number,
order date, and order amount in ascending order according to the order date to
determine whether any of the existing customers have placed an order or not. */

SELECT 
	cust_name as [Customer Name], 
	customer.city as [Customer City], 
	ord_no as [Order No], 
	ord_date as [Order Date],
	purch_amt as [Order Amount]
FROM customer 
LEFT JOIN orders ON customer.customer_id = orders.customer_id
ORDER BY ord_date

SELECT 
	cust_name as [Customer Name], 
	customer.city as [Customer City], 
	ord_no as [Order No], 
	ord_date as [Order Date],
	purch_amt as [Order Amount]
FROM customer 
INNER JOIN orders ON customer.salesman_id = orders.salesman_id
ORDER BY ord_date

/* Query-11: 
Write a SQL statement to generate a report with customer name, city, order number,
order date, order amount, salesperson name, and commission to determine if any of
the existing customers have not placed orders or if they have placed orders through
their salesman or by themselves. */

SELECT 
		ord_no, 
		ord_date, 
		purch_amt, 
		cust_name as [Customer Name], 
		salesman.name as Salesman, 
		commission
FROM customer 
LEFT JOIN orders ON customer.customer_id = orders.customer_id
LEFT JOIN salesman ON salesman.salesman_id = orders.salesman_id 

/* Query-12: 
Write a SQL statement to generate a list in ascending order of salespersons who
work either for one or more customers or have not yet joined any of the customers. */

SELECT 
		name as Salesman,
		cust_name as [Customer Name]
FROM salesman
LEFT JOIN customer ON salesman.salesman_id = customer.salesman_id
ORDER BY salesman

/* Query-13: 
write a SQL query to list all salespersons along with customer name, city, grade,
order number, date, and amount. */

SELECT 
	name as Salesman,
	cust_name as [Customer Name], 
	customer.city as [Customer City], 
	grade,
	ord_no as [Order No], 
	ord_date as [Order Date],
	purch_amt as [Order Amount]
FROM salesman 
INNER JOIN customer ON salesman.salesman_id = customer.salesman_id
INNER JOIN orders ON orders.customer_id = customer.customer_id

/* Query-14: 
Write a SQL statement to make a list for the salesmen who either work for one or
more customers or yet to join any of the customers. The customer may have placed,
either one or more orders on or above order amount 2000 and must have a grade, or
he may not have placed any order to the associated supplier. */

SELECT 
	cust_name,
	customer.city,
	grade, 
	name AS Salesman, 
	ord_no,
	ord_date,
	purch_amt 
FROM customer 
RIGHT OUTER JOIN salesman
ON salesman.salesman_id=customer.salesman_id 
LEFT OUTER JOIN orders 
ON orders.customer_id = customer.customer_id 
WHERE purch_amt>=2000 
AND grade IS NOT NULL;

/* Query-15: 
Write a SQL statement to generate a list of all the salesmen who either work for one
or more customers or have yet to join any of them. The customer may have placed
one or more orders at or above order amount 2000, and must have a grade, or he
may not have placed any orders to the associated supplier. */

SELECT 
	cust_name,
	customer.city,
	grade, 
	name AS Salesman, 
	ord_no,
	ord_date,
	purch_amt 
FROM customer 
RIGHT OUTER JOIN salesman
ON salesman.salesman_id=customer.salesman_id 
LEFT OUTER JOIN orders 
ON orders.customer_id = customer.customer_id 
WHERE purch_amt>=2000 
AND grade IS NOT NULL;

/* Query-16: 
Write a SQL statement to generate a report with the customer name, city, order no.
order date, purchase amount for only those customers on the list who must have a
grade and placed one or more orders or which order(s) have been placed by the
customer who neither is on the list nor has a grade. */

SELECT 
	cust_name,
	customer.city, 
	ord_no,
	ord_date,
	purch_amt AS [Order Amount] 
FROM customer 
FULL OUTER JOIN orders  
ON customer.customer_id = orders.customer_id 
WHERE grade IS NOT NULL;

/* Query-17: 
Write a SQL query to combine each row of the salesman table with each row of the
customer table */

SELECT * FROM salesman CROSS JOIN customer

/* Query-18: 
Write a SQL statement to create a Cartesian product between salesperson and
customer, i.e. each salesperson will appear for all customers and vice versa for that
salesperson who belongs to that city. */

SELECT * FROM salesman CROSS JOIN customer
WHERE salesman.city = customer.city

/* Query-19: 
Write a SQL statement to create a Cartesian product between salesperson and
customer, i.e. each salesperson will appear for every customer and vice versa for
those salesmen who belong to a city and customers who require a grade. */

SELECT * 
FROM salesman 
CROSS JOIN  customer 
WHERE salesman.city IS NOT NULL 
AND grade IS NOT NULL;

/* Query-20: 
Write a SQL statement to make a Cartesian product between salesman and
customer i.e. each salesman will appear for all customers and vice versa for those
salesmen who must belong to a city which is not the same as his customer and the
customers should have their own grade. */

SELECT * 
FROM salesman 
CROSS JOIN customer 
WHERE salesman.city IS NOT NULL 
AND  salesman.city <> customer.city;
