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

-- 18_1

DELIMITER $$

CREATE PROCEDURE get_order_by_cust(
    IN cust_no INT,
    OUT shipped INT,
    OUT canceled INT,
    OUT resolved INT,
    OUT disputed INT)
BEGIN
        -- shipped
        SELECT
            count(*) INTO shipped
        FROM
            orders
        WHERE
            customerNumber = cust_no
                AND status = 'Shipped';

        -- canceled
        SELECT
            count(*) INTO canceled
        FROM
            orders
        WHERE
            customerNumber = cust_no
                AND status = 'Canceled';

        -- resolved
        SELECT
            count(*) INTO resolved
        FROM
            orders
        WHERE
            customerNumber = cust_no
                AND status = 'Resolved';

        -- disputed
        SELECT
            count(*) INTO disputed
        FROM
            orders
        WHERE
            customerNumber = cust_no
                AND status = 'Disputed';

END$$
DELIMITER ;

CALL get_order_by_cust(141,@shipped,@canceled,@resolved,@disputed);
SELECT @shipped,@canceled,@resolved,@disputed;


-- CLASS 18 part 2

DROP PROCEDURE IF EXISTS classicmodels.test_mysql_loop;

DELIMITER $$
$$
CREATE PROCEDURE test_mysql_loop()
    BEGIN
        DECLARE x  INT;
        DECLARE str  VARCHAR(255);

        SET x = 1;
        SET str =  '';

        loop_label:  LOOP
            IF  x > 10 THEN 
                LEAVE  loop_label;
            END  IF;

            SET  x = x + 1;
            IF  (x mod 2) THEN
                ITERATE  loop_label;
            ELSE
                SET  str = CONCAT(str,x,',');
            END  IF;
         END LOOP;    

         SELECT str;

    END; $$
DELIMITER ;

CALL test_mysql_loop();

-- CLASS 18 part 4 

CREATE PROCEDURE build_email_list (INOUT email_list varchar(4000))
BEGIN

    DECLARE v_finished INTEGER DEFAULT 0;
        DECLARE v_email varchar(100) DEFAULT "";

    -- declare cursor for employee email
    DEClARE email_cursor CURSOR FOR 
        SELECT email FROM employees;

    -- declare NOT FOUND handler
    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET v_finished = 1;

    OPEN email_cursor;

    get_email: LOOP

        FETCH email_cursor INTO v_email;

        IF v_finished = 1 THEN 
            LEAVE get_email;
        END IF;

        -- build email list
        SET email_list = CONCAT(v_email,";",email_list);

    END LOOP get_email;

    CLOSE email_cursor;

END;

SET @email_list = "";
CALL build_email_list(@email_list);
SELECT @email_list;


-- CLASS 18 part 5
-- EXERCISES

-- 1

DROP FUNCTION IF EXISTS sakila.getMovieQuantityFromStore ;

DELIMITER $$
$$
CREATE FUNCTION sakila.getMovieQuantityFromStore(p_storeId SMALLINT UNSIGNED, p_filmTitle VARCHAR(255)) RETURNS SMALLINT UNSIGNED
    NOT DETERMINISTIC
BEGIN
    DECLARE movies_quantity SMALLINT UNSIGNED;
    SET movies_quantity = ( SELECT COUNT(film_id)
							FROM film
							INNER JOIN inventory USING(film_id)
							INNER JOIN store USING(store_id)
							WHERE store_id = p_storeId
							AND title LIKE p_filmTitle );
    RETURN (movies_quantity);
END $$
DELIMITER ;

SELECT getMovieQuantityFromStore(1, 'COMA HEAD');

-- 2

DROP PROCEDURE IF EXISTS sakila.customersFromCountry ;

DELIMITER $$
$$
CREATE DEFINER=`root`@`%` PROCEDURE `sakila`.`customersFromCountry`(IN p_countryName VARCHAR(255), OUT out_list TEXT)
BEGIN
	DECLARE p_customerList TEXT DEFAULT "";
	DECLARE v_finished INTEGER DEFAULT 0;
    DECLARE v_customer_fn varchar(255) DEFAULT "";
    DECLARE v_customer_ln varchar(255) DEFAULT "";    
        
    DECLARE customer_cursor CURSOR FOR 
        SELECT first_name, last_name
		FROM customer
			INNER JOIN address USING (address_id)
			INNER JOIN city USING (city_id)
			INNER JOIN country USING (country_id)
		WHERE country LIKE p_countryName;
		
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET v_finished = 1;
    
    OPEN customer_cursor;

    get_customer: LOOP

        FETCH customer_cursor INTO v_customer_fn, v_customer_ln;
        
        IF v_finished = 1 THEN 
            LEAVE get_customer;
        END IF;

        SET p_customerList = CONCAT(v_customer_fn, " ", v_customer_ln ,";",p_customerList);
        
        

    END LOOP get_customer;

    SET out_list = p_customerList;
    
    CLOSE customer_cursor;
    
    
	
END $$
DELIMITER ;



-- 3

-- Inventory_in_stock

-- This function gets the number of rentals from a certain entry in the inventory and makes some checks.
-- If it hasn't been rented, then the inventory entry is in stock.
-- If it has been rented, it checks if it hasnt been returned yet. 
-- If the inventory entry hasn't been returned, then it is not in stock (function returns 0)
-- otherwise it is in stock (function returns 1).

-- Since this movie hasn't been returned yet, it's not in stock. So function returns 0.
SELECT inventory_in_stock(4106);

-- This movie is in stock, so function returns 1.
SELECT inventory_in_stock(327);



-- Film_in_stock

-- This function receives both a film and a store's id and outputs the number copies of that film available in stock.
-- It achieves this by checking their inventory entrys' stock state with inventory_in_stock function.

-- The film 'COMA HEAD' has four copies available in stock.
CALL film_in_stock(167, 1, @film_stock);
SELECT @film_stock;
