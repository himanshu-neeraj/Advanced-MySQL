CREATE DATABASE companyofai_db;
USE companyofai_db;



CREATE TABLE employee(
id INT PRIMARY KEY,
name VARCHAR(50),
department VARCHAR(50),
salary INT
);


INSERT INTO employee VALUES
(1,'Alice','HR',30000),
(2,'Bob','IT',45000),
(3,'Charlie','Finance',50000),
(4,'David','IT',40000),
(5,'Emma','HR',35000);


SELECT * FROM employee;


-- Q1:
-- Create a function to add two numbers

DELIMITER //

CREATE FUNCTION add_numbers(
a INT,
b INT
)

RETURNS INT

DETERMINISTIC

BEGIN

RETURN a+b;

END //

DELIMITER ;

SELECT add_numbers(10,20);



--------------------------------------------------


-- Q2:
-- Create function to calculate square of a number

DELIMITER //

CREATE FUNCTION square_num(
n INT
)

RETURNS INT

DETERMINISTIC

BEGIN

RETURN n*n;

END //

DELIMITER ;

SELECT square_num(5);



--------------------------------------------------


-- Q3:
-- Create function to calculate annual salary

DELIMITER //

CREATE FUNCTION annual_salary(
monthly_salary INT
)

RETURNS INT

DETERMINISTIC

BEGIN

RETURN monthly_salary*12;

END //

DELIMITER ;

SELECT annual_salary(30000);



--------------------------------------------------


-- Q4:
-- Create function to return highest salary

DELIMITER //

CREATE FUNCTION highest_salary()

RETURNS INT

DETERMINISTIC

BEGIN

DECLARE max_salary INT;

SELECT MAX(salary)
INTO max_salary
FROM employee;

RETURN max_salary;

END //

DELIMITER ;

SELECT highest_salary();



--------------------------------------------------


-- Q5:
-- Create function to count total employees

DELIMITER //

CREATE FUNCTION total_employee()

RETURNS INT

DETERMINISTIC

BEGIN

DECLARE emp_count INT;

SELECT COUNT(*)
INTO emp_count

FROM employee;

RETURN emp_count;

END //

DELIMITER ;

SELECT total_employee();


-- Q6:
-- Create function to return employee salary by ID

DELIMITER //

CREATE FUNCTION employee_salary(
emp_id INT
)

RETURNS INT

DETERMINISTIC

BEGIN

DECLARE emp_salary INT;

SELECT salary
INTO emp_salary

FROM employee

WHERE id=emp_id;

RETURN emp_salary;

END //

DELIMITER ;

SELECT employee_salary(2);



--------------------------------------------------


-- Q7:
-- Create function to return department of employee

DELIMITER //

CREATE FUNCTION employee_department(
emp_id INT
)

RETURNS VARCHAR(50)

DETERMINISTIC

BEGIN

DECLARE dept VARCHAR(50);

SELECT department
INTO dept

FROM employee

WHERE id=emp_id;

RETURN dept;

END //

DELIMITER ;

SELECT employee_department(3);



--------------------------------------------------


-- Q8:
-- Create function to check salary level

DELIMITER //

CREATE FUNCTION salary_status(
salary_amount INT
)

RETURNS VARCHAR(20)

DETERMINISTIC

BEGIN

DECLARE result VARCHAR(20);

IF salary_amount > 40000 THEN
SET result='High Salary';

ELSE
SET result='Low Salary';

END IF;

RETURN result;

END //

DELIMITER ;

SELECT salary_status(50000);



--------------------------------------------------


-- Q9:
-- Create function to calculate bonus (10%)

DELIMITER //

CREATE FUNCTION employee_bonus(
salary_amount INT
)

RETURNS INT

DETERMINISTIC

BEGIN

RETURN salary_amount*0.10;

END //

DELIMITER ;

SELECT employee_bonus(40000);



--------------------------------------------------


-- Q10:
-- Create function to return average salary

DELIMITER //

CREATE FUNCTION average_salary()

RETURNS INT

DETERMINISTIC

BEGIN

DECLARE avg_sal INT;

SELECT AVG(salary)
INTO avg_sal

FROM employee;

RETURN avg_sal;

END //

DELIMITER ;

SELECT average_salary();
