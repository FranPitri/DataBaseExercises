-- JAVIn

SELECT c.customer_id, first_name, last_name, COUNT(*)
  FROM rental r1, customer c
WHERE c.customer_id = r1.customer_id
GROUP BY c.customer_id, first_name, last_name
  HAVING COUNT(*) = 1;


  SELECT rating, MIN(`length`)
  FROM film
GROUP BY rating
  HAVING MIN(`length`) > 46;
  
  
SELECT rating, COUNT(*)
  FROM film
GROUP BY rating
  HAVING COUNT(*) < 195;
  
SELECT rating, AVG(`length`)
  FROM film
GROUP BY rating
  HAVING AVG(`length`) > (SELECT AVG(`length`) FROM film);