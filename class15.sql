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

CREATE OR REPLACE VIEW sales_by_film_category AS
	SELECT DISTINCT category.name, SUM(amount) as total_rental FROM category
					INNER JOIN film_category USING(category_id)
					INNER JOIN film USING(film_id)
					INNER JOIN inventory USING(film_id)
					INNER JOIN rental USING(inventory_id)
					INNER JOIN payment USING(rental_id)
				GROUP BY 1;
	
	
SELECT * FROM sales_by_film_category;

-- 4

CREATE OR REPLACE VIEW actor_information AS
	SELECT actor_id as id,
		first_name,
		last_name,
		(SELECT COUNT(film_id)
		FROM film
			INNER JOIN film_actor USING(film_id)
			INNER JOIN actor USING(actor_id)
		WHERE actor_id = id) AS films_participated_in
	  FROM actor;
	  
SELECT * FROM actor_information;

-- 5

-- This view fetches values from table actor, and joins them whenever it can with values from tables film_actor, film_category
-- and category. This meaning that they will only be joined in case the actor has acted in a film.
-- It displays the data in four columns. The first three of them are just basic actor data: its name, surname and id.
-- The fourth column, called film_info, displays every film the actor has acted on, grouped by category.
-- The query achieves this by concatenating every category with the group of films that belongs to it and, after that,
-- concatenating the groups of categories with its films together.  

-- 6

-- Materialized views are a form of chaching query results.The main difference between this type of views the ordinary ones  
-- is that Materialized views are concrete tables that store the results of a query.
-- They are used to improve performance and exist in a variety of DBMSs, but not in MySQL. In this last scenario you could
-- implement some workaround by using triggers or stored procedures.

