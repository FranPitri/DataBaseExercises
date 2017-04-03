-- MAX (SELECT on SELECT)

SELECT customer_id,
	   first_name,
	   last_name,
	   (SELECT MAX(amount)
	      FROM payment
	    WHERE payment.customer_id = customer.customer_id) AS amount
  FROM customer
ORDER BY amount DESC,
	     customer_id DESC;