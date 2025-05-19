SELECT A. customer_id,
       A. store_id,
	     A. first_name,
	     A. last_name,
	     A. email,
	     A. address_id,
	     A. activebool,
	     A. create_date,
	     A. last_update,
  	   A. active,
	     B. address,
	     B. postal_code,
  	   C. city_id,
	     C. city,
	     D. country
FROM customer A
INNER JOIN address B ON A. address_id = B. address_id
INNER JOIN city C ON B. city_id = C. city_id
INNER JOIN country D ON C. country_id = D. country_id
