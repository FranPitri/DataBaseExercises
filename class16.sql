CREATE TABLE `employees` (
  `employeeNumber` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int(11) DEFAULT NULL,
  `jobTitle` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeNumber`)
);

INSERT INTO `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) VALUES 
(1002,'Murphy','Diane','x5800','dmurphy@classicmodelcars.com','1',NULL,'President'),
(1056,'Patterson','Mary','x4611','mpatterso@classicmodelcars.com','1',1002,'VP Sales'),
(1076,'Firrelli','Jeff','x9273','jfirrelli@classicmodelcars.com','1',1002,'VP Marketing');

CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

-- This trigger runs before an employee's table entry is updated
-- It adds an entry to employees_audit table with the same employee number, the last name previous to when it got updated /
-- and the date when it got updated.

DELIMITER $$
CREATE TRIGGER before_employee_update 
    BEFORE UPDATE ON employees
    FOR EACH ROW 
BEGIN
    INSERT INTO employees_audit
    SET action = 'update',
     employeeNumber = OLD.employeeNumber,
        lastname = OLD.lastname,
        changedat = NOW(); 
END$$
DELIMITER ;


UPDATE employees 
SET 
    lastName = 'Phan'
WHERE
    employeeNumber = 1056;

    
SELECT 
    *
FROM
    employees_audit;
    
-- EXCERCISES
    
-- 1

-- It throws an error because of the NOT NULL constraint we added on the email attribute when we created the table.
    
INSERT INTO `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) VALUES 
(1056,'Patterson','Mary','x4611',NULL,'1',1002,'VP Sales');

-- 2

UPDATE employees set employeeNumber = employeeNumber - 20;

-- This query doesn't work because it runs on cascade.
-- The distance between the last 2 entry's employeeNumber is exactly 20, /
-- so if it added 20 to the second entry, it's value would be the same than the 3rd column's entry 

UPDATE employees set employeeNumber = employeeNumber + 20;
