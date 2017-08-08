SELECT * FROM products;

ALTER TABLE products 
ADD FULLTEXT(productline);

SELECT productName, productline
FROM products
WHERE MATCH(productline) AGAINST('Classic');

SELECT productName, productline
FROM products
WHERE MATCH(productline) AGAINST('Classic,Vintage');

ALTER TABLE products 
ADD FULLTEXT(productName);

SELECT productName, productline
FROM products
WHERE MATCH(productName) AGAINST('1932,Ford');

-- ------------------------------------------ --

-- SAKILA EXCERCISES

-- 1

SELECT * 
  FROM address a1
WHERE postal_code IN (SELECT postal_code
					  FROM address a2
					  WHERE a1.address_id <> a2.address_id
					  AND a1.address_id > a2.address_id);
					  
CREATE INDEX address_index ON address(postal_code);

-- After the creation of the index, the query performance improved by ~110ms (from ~128ms to ~12ms)

-- 2
-- Altough I am not able to see any difference in this context,
-- the column last_name should be more perfomant since it has an index.

select *
from actor
WHERE first_name IN ('LISA')	;

select *
from actor
WHERE last_name IN ('MONROE');

-- 3

-- Perfomance with MATCH..AGAINST is arround 4x better since it is working with the fulltext index.

SELECT *
FROM film
WHERE description LIKE '%Astounding%';

ALTER TABLE film_text 
ADD FULLTEXT(description);

SELECT *
FROM film_text
WHERE MATCH(description) AGAINST('Astounding');