-- 1
SELECT COUNT(city_id), country.country, country.country_id
  FROM country 
  	INNER JOIN city USING (country_id)
GROUP BY country.country,country.country_id
ORDER BY country.country,country.country_id;

-- 2

SELECT COUNT(city_id), country.country
  FROM country 
  	INNER JOIN city USING (country_id)
GROUP BY country.country
	HAVING COUNT(*) > 10
ORDER BY 1 DESC;

-- 3

SELECT customer.first_name, customer.last_name, address.address, COUNT(rental.rental_id), SUM(payment.amount)
  FROM customer 
  	INNER JOIN address USING (address_id)
  	INNER JOIN rental USING (customer_id)
  	INNER JOIN payment USING(rental_id)
GROUP BY 1, 2, 3
ORDER BY 5 DESC;

-- 4

SELECT film.title
  FROM film
WHERE film.film_id NOT IN 
	(SELECT film_id FROM inventory);
	
-- 5

SELECT film.title, inventory_id, rental.rental_id
  FROM film 
  	INNER JOIN inventory USING (film_id)
  	LEFT OUTER JOIN rental USING (inventory_id)
WHERE rental.rental_id IS NULL;

SELECT film.title
FROM film, inventory
WHERE film.film_id = inventory.film_id
AND film.title = 'ACADEMY DINOSAUR';