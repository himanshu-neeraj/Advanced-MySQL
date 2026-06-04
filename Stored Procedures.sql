CREATE DATABASE companyofaaft_db;
USE companyofaaft_db;

CREATE TABLE employee (
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

-- Q1: Create procedure to display all employees

DELIMITER //

CREATE PROCEDURE show_all_employees()
BEGIN
    SELECT * FROM employee;
END //

DELIMITER ;

CALL show_all_employees();


-------------------------------------------------

-- Q2: Create procedure to display employee by ID

DELIMITER //

CREATE PROCEDURE employee_by_id(
IN emp_id INT
)

BEGIN
    SELECT *
    FROM employee
    WHERE id = emp_id;
END //

DELIMITER ;

CALL employee_by_id(2);


-------------------------------------------------

-- Q3: Create procedure to count total employees

DELIMITER //

CREATE PROCEDURE total_employees()

BEGIN
    SELECT COUNT(*) AS total_employee
    FROM employee;
END //

DELIMITER ;

CALL total_employees();


-------------------------------------------------

-- Q4: Create procedure to display employees by department

DELIMITER //

CREATE PROCEDURE employee_department(
IN dept_name VARCHAR(50)
)

BEGIN
    SELECT *
    FROM employee
    WHERE department = dept_name;
END //

DELIMITER ;

CALL employee_department('IT');


-------------------------------------------------

-- Q5: Create procedure to show employees
-- whose salary is greater than given amount

DELIMITER //

CREATE PROCEDURE salary_above(
IN amount INT
)

BEGIN
    SELECT *
    FROM employee
    WHERE salary > amount;
END //

DELIMITER ;

CALL salary_above(40000);

-- Q6: Create procedure to insert new employee

DELIMITER //

CREATE PROCEDURE add_employee(

IN emp_id INT,
IN emp_name VARCHAR(50),
IN dept VARCHAR(50),
IN emp_salary INT

)

BEGIN

INSERT INTO employee
VALUES(
emp_id,
emp_name,
dept,
emp_salary
);

END //

DELIMITER ;

CALL add_employee(
6,
'John',
'Marketing',
38000
);


-------------------------------------------------

-- Q7: Create procedure to update employee salary

DELIMITER //

CREATE PROCEDURE update_salary(

IN emp_id INT,
IN new_salary INT

)

BEGIN

UPDATE employee
SET salary = new_salary
WHERE id = emp_id;

END //

DELIMITER ;

CALL update_salary(
1,
40000
);


-------------------------------------------------

-- Q8: Create procedure to delete employee

DELIMITER //

CREATE PROCEDURE delete_employee(
IN emp_id INT
)

BEGIN

DELETE FROM employee
WHERE id = emp_id;

END //

DELIMITER ;

CALL delete_employee(5);


-------------------------------------------------

-- Q9: Create procedure to find average salary

DELIMITER //

CREATE PROCEDURE average_salary()

BEGIN

SELECT AVG(salary)
AS average_salary

FROM employee;

END //

DELIMITER ;

CALL average_salary();


-------------------------------------------------

-- Q10: Create procedure to show employee
-- with highest salary

DELIMITER //

CREATE PROCEDURE highest_salary()

BEGIN

SELECT *
FROM employee

WHERE salary =
(
SELECT MAX(salary)
FROM employee
);

END //

DELIMITER ;

CALL highest_salary();


-------------------------------------------------


-- Show all procedures

SHOW PROCEDURE STATUS;