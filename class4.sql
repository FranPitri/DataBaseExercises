SELECT f.title, f.special_features, f.rental_rate, c.name
FROM film f, film_category fc, category c 
WHERE f.film_id = fc.film_id
AND fc.category_id = c.category_id
ORDER BY f.rental_rate DESC, f.special_features ASC;

SELECT f1.title, f2.title, f1.`length`, f1.film_id, f2.film_id
FROM film f1, film f2
WHERE f1.`length` = f2.`length`
AND f1.film_id > f2.film_id
ORDER BY 1; 

-- EXCERSISES

-- 1

SELECT f.title, f.special_features
FROM film f
WHERE f.rating = 'PG-13';

-- 2

SELECT DISTINCT f1.`length`
FROM film f1;

-- 3

SELECT f.title, f.rental_rate, f.replacement_cost
FROM film f
WHERE f.replacement_cost BETWEEN 20.00 AND 24.00;

-- 4

SELECT f.title, c.name, f.rating, f.special_features
FROM film f, category c, film_category fc
WHERE f.film_id = fc.film_id
AND c.category_id = fc.category_id
AND f.special_features LIKE '%Behind the Scenes%';

-- 5

SELECT actor.first_name, actor.last_name
FROM actor, film_actor fa, film f
WHERE f.film_id = fa.film_id
AND fa.actor_id = actor.actor_id
AND f.title = 'ZOOLANDER FICTION';

-- 6

SELECT co.country, ci.city, ad.address
FROM store str, address ad, city ci, country co
WHERE str.store_id = 1
AND str.address_id = ad.address_id
AND ad.city_id = ci.city_id
AND ci.country_id = co.country_id
ORDER BY co.country, ci.city;

-- 7

SELECT f1.title, f1.rating, f2.title, f2.rating
FROM film f1, film f2
WHERE f1.film_id > f2.film_id
AND f1.rating = f2.rating;

-- 8

SELECT DISTINCT film.title, staff.first_name, staff.last_name
FROM film, inventory inv, store str, staff
WHERE film.film_id = inv.film_id
AND inv.store_id = str.store_id
AND str.store_id = 2
AND str.manager_staff_id = staff.staff_id;