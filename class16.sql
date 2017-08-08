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
-- The distance between the last 2 entrys' employeeNumber is exactly 20, /
-- so if it added 20 to the second entry, its value would be the same than the 3rd column's entry 

UPDATE employees set employeeNumber = employeeNumber + 20;

-- 3

ALTER TABLE employees
ADD age TINYINT UNSIGNED DEFAULT 69;

ALTER TABLE employees
   ADD CONSTRAINT age CHECK(age >= 16 AND age <= 70);
   
-- 5
   
ALTER TABLE employees
	ADD COLUMN lastUpdate DATETIME;

	
ALTER TABLE employees
	ADD COLUMN lastUpdateUser VARCHAR(255);	

-- I chose to create a procedure which updates the given employee's data and to call it in both triggers 
	
DROP PROCEDURE IF EXISTS classsixteen.UpdateEmployeeLastUpdate ;

DELIMITER $$
$$
CREATE PROCEDURE UpdateEmployeeLastUpdate(IN employee_id INT)
BEGIN
	UPDATE employees
	    SET lastUpdate = NOW(),
	    lastUpdateUser = CURRENT_USER()
    WHERE employees.employeeNumber = employee_id;
END $$
DELIMITER ;

	
DELIMITER $$
CREATE TRIGGER after_employee_update 
    AFTER UPDATE ON employees
    FOR EACH ROW 
BEGIN
    CALL UpdateEmployeeLastUpdate(NEW.employeeNumber);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER after_employee_insert 
    AFTER INSERT ON employees
    FOR EACH ROW 
BEGIN
    CALL UpdateEmployeeLastUpdate(NEW.employeeNumber);
END$$
DELIMITER ;

-- This is actually generating an endless loop since the store procedure calls the trigger again.
-- Soooo FIXME i guess.

update employees set lastName = 'Phanny' where employeeNumber = 1016;

-- 6

-- ins_film Inserts a new film_text entry, with the same values as the added film.

BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
END

-- upd_film Updates the corresponding existing film_text entry for the updated film. 

BEGIN
	IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
	THEN
	    UPDATE film_text
	        SET title=new.title,
	            description=new.description,
	            film_id=new.film_id
	    WHERE film_id=old.film_id;
	END IF;
END

-- del_film Deletes the corresponding existing film_text entry for the deleted film. 

BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
END