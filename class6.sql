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

SELECT c.first_name, c.last_name
  FROM customer c
WHERE NOT EXISTS (SELECT *
					FROM rental r, customer cc
				  WHERE cc.customer_id = r.customer_id
				    AND c.customer_id <> cc.customer_id);

-- 4

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