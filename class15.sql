-- 1

CREATE OR REPLACE VIEW list_of_customers AS
	SELECT customer_id,
		CONCAT_WS(" " ,first_name, last_name) as full_name,
		address,
		postal_code,
		phone,
		city,
		country,
		CASE 
			WHEN active = 1 THEN 'active' 
			ELSE 'inactive' 
		END AS status,
		store_id
	FROM customer
		INNER JOIN address USING(address_id)
		INNER JOIN city USING(city_id)
		INNER JOIN country USING(country_id);
		
SELECT * FROM list_of_customers;

-- 2

CREATE OR REPLACE VIEW film_details AS
	SELECT film_id,
		title,
		description,
		name,
		rental_rate,
		`length`,
		rating,
		GROUP_CONCAT(DISTINCT CONCAT_WS(" " ,first_name, last_name) SEPARATOR ',') AS actores
	FROM film
		INNER JOIN film_category USING(film_id)
		INNER JOIN category USING(category_id)
		INNER JOIN film_actor USING(film_id)
		INNER JOIN actor USING(actor_id)
	GROUP BY 1,4;
	
SELECT * FROM film_details;

-- 3

