CREATE TABLE Department(
dept_id INT IDENTITY(1,1)PRIMARY KEY,
dept_name NVARCHAR(50) NOT NULL,
);

INSERT INTO Department 
VALUES
	('Finance'),
	('Managment'),
	('HR'),
	('Devlopement'),
	('Design');

SELECT * FROM Department

CREATE TABLE Employee(
emp_id INT IDENTITY(1,1) PRIMARY KEY,
dept_id INT foreign key references Department(dept_id),
mngr_id INT,
emp_name NVARCHAR(50),
salary INT);

INSERT INTO Employee 
VALUES
	(1,1,'Dev',35000),
	(2,2,'Vibhuti',450000),
	(1,2,'Jay',20000),
	(2,3,'Kevin',40000),
	(3,4,'Pinal',65000),
	(4,5,'Keyur',60000),
	(5,7,'Ankita',50000),
	(3,6,'Neet',55000),
	(5,3,'Arpit',52000),
	(4,7,'Meet',42000);

INSERT INTO Employee
VALUES
	(4,7,'Ajay',41000)

SELECT * FROM Employee
SELECT * FROM Department

/* Query-1: 
write a SQL query to find Employees who have the biggest salary in their Department. */

SELECT Employee.emp_id, Employee.emp_name, Employee.dept_id, Department.dept_name, Employee.salary
FROM Employee 
INNER JOIN Department  ON Employee.dept_id = Department.dept_id
WHERE salary IN (
	SELECT MAX(salary) AS [Max. salary] FROM Employee
	GROUP BY dept_id
)

/* Query-2: 
write a SQL query to find Departments that have less than 3 people in it. */

SELECT Department.dept_name
  FROM Employee
     INNER JOIN Department
       ON Employee.dept_id = Department.dept_id
        GROUP BY Department.dept_name
          HAVING COUNT(*) < 3

/* Query-3: 
write a SQL query to find All Department along with the number of people there. */
  
  SELECT 
		Department.dept_id,Department.dept_name, 
		COUNT(*) AS [Total People]
  FROM Employee INNER JOIN Department ON Employee.dept_id = Department.dept_id
  GROUP BY Department.dept_id,Department.dept_name

/* Query-4: 
write a SQL query to find All Department along with the total salary there. */

SELECT 
		Department.dept_id,Department.dept_name, 
		SUM(salary) AS [Total Salary]
FROM Employee INNER JOIN Department ON Employee.dept_id = Department.dept_id
GROUP BY Department.dept_id,Department.dept_name