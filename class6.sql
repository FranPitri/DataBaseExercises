-- 1

SELECT first_name, last_name
  FROM actor a1
WHERE EXISTS (SELECT last_name
			    FROM actor a2
			  WHERE a1.last_name = a2.last_name
			    AND a1.actor_id <> a2.actor_id)
ORDER BY last_name;

-- 2

SELECT a1.first_name, a1.last_name
  FROM actor a1
WHERE a1.actor_id NOT IN (SELECT DISTINCT fa.actor_id
           				    FROM film_actor fa);

-- 3

-- SELECT c.first_name, c.last_name ,r.rental_date
--   FROM rental r, customer c
-- WHERE r.customer_id = c.customer_id;

SELECT  c.customer_id, c.first_name, c.last_name
  FROM rental r1, customer c
WHERE NOT EXISTS (SELECT *
					FROM rental r2
				  WHERE r1.customer_id = r2.customer_id
				    AND r1.rental_id <> r2.rental_id)
  AND r1.customer_id = c.customer_id
ORDER BY 1;

-- 4

SELECT DISTINCT c.customer_id, c.first_name, c.last_name
  FROM rental r1, customer c
WHERE EXISTS (SELECT *
					FROM rental r2
				  WHERE r1.customer_id = r2.customer_id
				    AND r1.rental_id <> r2.rental_id)
  AND r1.customer_id = c.customer_id
ORDER BY 1;

-- 5
				    
SELECT first_name, last_name
  FROM actor
WHERE actor.actor_id IN (SELECT actor.actor_id
						  FROM actor, film, film_actor
						WHERE actor.actor_id = film_actor.actor_id
						  AND film_actor.film_id = film.film_id
						  AND (film.title = 'BETRAYED REAR' OR film.title = 'CATCH AMISTAD' ));
-- 6

SELECT first_name, last_name
  FROM actor
WHERE actor.actor_id IN (SELECT actor.actor_id
						  FROM actor, film, film_actor
						WHERE actor.actor_id = film_actor.actor_id
						  AND film_actor.film_id = film.film_id
						  AND film.title = 'BETRAYED REAR'
						  AND film.title <> 'CATCH AMISTAD');

-- 7
  
SELECT first_name, last_name
  FROM actor
WHERE actor.actor_id IN (SELECT actor.actor_id
						  FROM actor, film, film_actor
						WHERE actor.actor_id = film_actor.actor_id
						  AND film_actor.film_id = film.film_id
						  AND (film.title = 'BETRAYED REAR'))
  AND actor.actor_id IN (SELECT actor.actor_id
						  FROM actor, film, film_actor
						WHERE actor.actor_id = film_actor.actor_id
						  AND film_actor.film_id = film.film_id
						  AND (film.title = 'CATCH AMISTAD'));
						  
-- 8
						  
SELECT first_name, last_name
  FROM actor
WHERE actor.actor_id NOT IN (SELECT actor.actor_id
						  FROM actor, film, film_actor
						WHERE actor.actor_id = film_actor.actor_id
						  AND film_actor.film_id = film.film_id
						  AND (film.title = 'BETRAYED REAR' OR film.title = 'CATCH AMISTAD' ));