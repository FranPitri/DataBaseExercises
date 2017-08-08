DELIMITER //
 CREATE PROCEDURE GetAllProducts()
   BEGIN
   SELECT *  FROM products;
   END //
 DELIMITER ;

CALL GetAllProducts();

-- 

DELIMITER //
CREATE PROCEDURE GetOfficeByCountry(IN countryName VARCHAR(255))
    BEGIN
        SELECT * 
        FROM offices
        WHERE country = countryName;
    END //
DELIMITER ;

CALL GetOfficeByCountry('Australia');

-- 

DELIMITER $$
CREATE PROCEDURE CountOrderByStatus(
        IN orderStatus VARCHAR(25),
        OUT total INT)
BEGIN
    SELECT count(orderNumber)
    INTO total
    FROM orders
    WHERE status = orderStatus;
END$$
DELIMITER ;

CALL CountOrderByStatus('Shipped',@total);
SELECT @total;

CALL CountOrderByStatus('in process',@total);
SELECT @total AS  total_in_process;

-- 

DELIMITER $$
CREATE PROCEDURE set_counter(INOUT count INT(4),IN inc INT(4))
BEGIN
    SET count = count + inc;
END$$
DELIMITER ;

SET @counter = 1;
CALL set_counter(@counter,1); -- 2
CALL set_counter(@counter,1); -- 3
CALL set_counter(@counter,5); -- 8
SELECT @counter; -- 8