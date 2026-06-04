CREATE DATABASE company_triggers;
USE company_triggers;

CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(50),
    monthly_salary DECIMAL(10,2)
);

CREATE TABLE activity_log (
    log_no INT AUTO_INCREMENT PRIMARY KEY,
    staff_id INT,
    activity VARCHAR(100),
    entry_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO staff VALUES
(101,'Rohan',45000),
(102,'Sneha',55000),
(103,'Arjun',40000),
(104,'Pooja',65000);



-- 1. Log New Staff Entry
DELIMITER //

CREATE TRIGGER trg_staff_insert
AFTER INSERT ON staff
FOR EACH ROW
BEGIN
    INSERT INTO activity_log(staff_id,activity)
    VALUES(NEW.staff_id,'New Staff Registered');
END//

DELIMITER ;

INSERT INTO staff VALUES(105,'Kunal',50000);



-- 2. Log Staff Removal
DELIMITER //

CREATE TRIGGER trg_staff_delete
AFTER DELETE ON staff
FOR EACH ROW
BEGIN
    INSERT INTO activity_log(staff_id,activity)
    VALUES(OLD.staff_id,'Staff Record Removed');
END//

DELIMITER ;

DELETE FROM staff WHERE staff_id=101;



-- 3. Track Salary Updates
DELIMITER //

CREATE TRIGGER trg_salary_update_log
AFTER UPDATE ON staff
FOR EACH ROW
BEGIN
    IF OLD.monthly_salary <> NEW.monthly_salary THEN
        INSERT INTO activity_log(staff_id,activity)
        VALUES(NEW.staff_id,'Salary Modified');
    END IF;
END//

DELIMITER ;

UPDATE staff
SET monthly_salary=60000
WHERE staff_id=102;



-- 4. Prevent Invalid Salary
DELIMITER //

CREATE TRIGGER trg_check_salary
BEFORE INSERT ON staff
FOR EACH ROW
BEGIN
    IF NEW.monthly_salary < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Salary must be positive';
    END IF;
END//

DELIMITER ;



-- 5. Add 5% Joining Increment
DELIMITER //

CREATE TRIGGER trg_joining_increment
BEFORE INSERT ON staff
FOR EACH ROW
BEGIN
    SET NEW.monthly_salary = NEW.monthly_salary * 1.05;
END//

DELIMITER ;

INSERT INTO staff VALUES(106,'Nitin',40000);



-- 6. Save Salary History
DELIMITER //

CREATE TRIGGER trg_salary_history
AFTER UPDATE ON staff
FOR EACH ROW
BEGIN
    IF OLD.monthly_salary <> NEW.monthly_salary THEN
        INSERT INTO activity_log(staff_id,activity)
        VALUES(
            NEW.staff_id,
            CONCAT('Salary Updated: ',OLD.monthly_salary,
                   ' -> ',NEW.monthly_salary)
        );
    END IF;
END//

DELIMITER ;



-- 7. Capitalize Staff Name
DELIMITER //

CREATE TRIGGER trg_upper_name
BEFORE INSERT ON staff
FOR EACH ROW
BEGIN
    SET NEW.staff_name = UPPER(NEW.staff_name);
END//

DELIMITER ;

INSERT INTO staff VALUES(107,'vikas',35000);



-- 8. Restrict Salary Decrease
DELIMITER //

CREATE TRIGGER trg_no_salary_cut
BEFORE UPDATE ON staff
FOR EACH ROW
BEGIN
    IF NEW.monthly_salary < OLD.monthly_salary THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Salary reduction prohibited';
    END IF;
END//

DELIMITER ;



-- 9. Record Name Changes
DELIMITER //

CREATE TRIGGER trg_name_update
AFTER UPDATE ON staff
FOR EACH ROW
BEGIN
    IF OLD.staff_name <> NEW.staff_name THEN
        INSERT INTO activity_log(staff_id,activity)
        VALUES(NEW.staff_id,'Staff Name Updated');
    END IF;
END//

DELIMITER ;

UPDATE staff
SET staff_name='Meera'
WHERE staff_id=104;



-- 10. Prevent Blank Names
DELIMITER //

CREATE TRIGGER trg_name_validation
BEFORE INSERT ON staff
FOR EACH ROW
BEGIN
    IF NEW.staff_name='' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Name cannot be blank';
    END IF;
END//

DELIMITER ;



-- 11. Log Premium Salary Staff
DELIMITER //

CREATE TRIGGER trg_high_income_staff
AFTER INSERT ON staff
FOR EACH ROW
BEGIN
    IF NEW.monthly_salary > 90000 THEN
        INSERT INTO activity_log(staff_id,activity)
        VALUES(NEW.staff_id,'Premium Salary Staff Added');
    END IF;
END//

DELIMITER ;

INSERT INTO staff VALUES(108,'Aakash',100000);



-- 12. Set Default Salary
DELIMITER //

CREATE TRIGGER trg_default_pay
BEFORE INSERT ON staff
FOR EACH ROW
BEGIN
    IF NEW.monthly_salary IS NULL THEN
        SET NEW.monthly_salary=30000;
    END IF;
END//

DELIMITER ;

INSERT INTO staff(staff_id,staff_name)
VALUES(109,'Ritika');



-- 13. Prevent Duplicate Staff Names
DELIMITER //

CREATE TRIGGER trg_unique_staff_name
BEFORE INSERT ON staff
FOR EACH ROW
BEGIN
    IF EXISTS(
        SELECT 1
        FROM staff
        WHERE staff_name=NEW.staff_name
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Duplicate staff name not allowed';
    END IF;
END//

DELIMITER ;



-- 14. Welcome Log Entry
DELIMITER //

CREATE TRIGGER trg_welcome_note
AFTER INSERT ON staff
FOR EACH ROW
BEGIN
    INSERT INTO activity_log(staff_id,activity)
    VALUES(NEW.staff_id,'Welcome To The Company');
END//

DELIMITER ;

INSERT INTO staff VALUES(110,'Deepak',42000);



-- 15. Bonus On Salary Revision
DELIMITER //

CREATE TRIGGER trg_salary_bonus
BEFORE UPDATE ON staff
FOR EACH ROW
BEGIN
    IF OLD.monthly_salary <> NEW.monthly_salary THEN
        SET NEW.monthly_salary = NEW.monthly_salary + 500;
    END IF;
END//

DELIMITER ;

UPDATE staff
SET monthly_salary=70000
WHERE staff_id=102;