-- 1

SELECT CONCAT_WS(" ",first_name,last_name) as full_name, address.address, city.city
FROM customer 
	INNER JOIN address USING(address_id)
	INNER JOIN city USING(city_id)
	INNER JOIN country USING(country_id)
WHERE country.country LIKE 'Argentina';

-- 2

SELECT title,
`language`.name, 
CASE
	WHEN rating = 'G' THEN 'All Ages Are Admitted.'
	WHEN rating = 'PG' THEN 'Some Material May Not Be Suitable For Children.'
	WHEN rating = 'PG-13' THEN 'Some Material May Be Inappropriate For Children Under 13.'
	WHEN rating = 'R' THEN 'Under 17 Requires Accompanying Parent Or Adult Guardian.'
	WHEN rating = 'NC-17' THEN 'No One 17 and Under Admitted.'
END AS rating_description
  FROM film
	INNER JOIN `language` USING (language_id);
	
-- 3
	
SELECT title, release_year
  FROM film 
	INNER JOIN film_actor USING(film_id)
	INNER JOIN actor USING(actor_id)
WHERE CONCAT_WS(" ",first_name,last_name) LIKE TRIM(UPPER("   johNNy lollobRigidA     "));

-- 4

SELECT film.title,
	   CONCAT_WS(" ", customer.first_name, customer.last_name) as full_name,
	   CASE WHEN rental.return_date IS NOT NULL THEN 'Yes'
	   ELSE 'No' END AS was_returned,
	   MONTHNAME(rental.rental_date) as month
  FROM film
  	INNER JOIN inventory USING(film_id)
  	INNER JOIN rental USING(inventory_id)
  	INNER JOIN customer USING(customer_id)
WHERE MONTHNAME(rental.rental_date) LIKE 'May'
   OR MONTHNAME(rental.rental_date) LIKE 'June';
   
-- 5

-- CAST and CONVERT have barely no differences between them.
-- While CAST has a slightly distinct syntax than CONVERT,they're both used to convert data from one type to another.

SELECT CAST(last_update AS DATE) as only_date
FROM rental;

SELECT CONVERT("2006-02-15", DATETIME);

-- 6

-- NVL() and IFNULL() functions work in the same way: 
-- they check whether an expression is NULL or not; if it is, they return a second expression (a default value).

-- NVL() is an Oracle function, so here is an IFNULL() example:

SELECT rental_id, IFNULL(return_date, 'La pelicula no fue devuelta aun') as fecha_de_devolucion
  FROM rental
WHERE rental_id = 12610
  OR rental_id = 12611;
  
-- ISNULL() function returns 1 if the expression passed is NULL, otherwise it returns 0.
  
SELECT rental_id, ISNULL(return_date) as pelicula_faltante
  FROM rental
WHERE rental_id = 12610
  OR rental_id = 12611;
  
-- COALESCE() function returns the first non-NULL argument of the passed list.
  
SELECT COALESCE(NULL,
				NULL,
				(SELECT return_date
				FROM rental
				WHERE rental_id = 12610), -- null date
				(SELECT return_date
				FROM rental
				WHERE rental_id = 12611)) as primer_valor_no_nulo;