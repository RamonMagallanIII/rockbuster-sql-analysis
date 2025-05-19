SELECT AVG(total_amount_spent) AS avg_paid
FROM (
  SELECT A.customer_id,
         A.first_name,
         A.last_name,
         C.city,
         D.country,
         SUM(E.amount) AS total_amount_spent
  FROM customer A
  INNER JOIN address B ON A.address_id = B.address_id
  INNER JOIN city C ON B.city_id = C.city_id
  INNER JOIN country D ON C.country_id = D.country_id
  INNER JOIN payment E ON A.customer_id = E.customer_id
  WHERE C.city IN ('Aurora',
                   'Acua',
                   'Citrus Heights',
                   'Iwaki',
                   'Ambattur',
                   'Shanwei',
                   'So Leopoldo',
                   'Teboksary',
                   'Tianjin',
                   'Cianjur')
    AND D.country IN ('United States',
                      'Mexico',
                      'Japan',
                      'India',
                      'China',
                      'Brazil',
                      'Russian Federation',
                      'Indonesia')
  GROUP BY A.customer_id,
           A.first_name,
           A.last_name,
           C.city,
           D.country
  ORDER BY total_amount_spent DESC
  LIMIT 5
) AS total_amount_paid;
