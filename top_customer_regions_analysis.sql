WITH top_countries AS (
  SELECT D. country
  FROM customer A
  INNER JOIN address B ON A. address_id = B. address_id
  INNER JOIN city C ON B. city_id = C. city_id
  INNER JOIN country D ON C. country_id = D. country_id
  WHERE D. country IN ('United States', 'Mexico', 'Japan', 'India', 'China',
                       'Brazil', 'Russian Federation', 'Indonesia')
),

top_cities AS (
  SELECT C. city
  FROM customer A
  INNER JOIN address B ON A. address_id = B. address_id
  INNER JOIN city C ON B. city_id = C. city_id
  INNER JOIN country D ON C. country_id = D. country_id
  WHERE C. city IN ('Aurora', 'Acua', 'Citrus Heights', 'Iwaki', 'Ambattur',
                    'Shanwei', 'So Leopoldo', 'Teboksary', 'Tianjin', 'Cianjur')
    AND D. country IN ('United States', 'Mexico', 'Japan', 'India', 'China',
                       'Brazil', 'Russian Federation', 'Indonesia')
),

top_customers AS (
  SELECT SUM(E.amount) AS total_payment,
         D. country
  FROM customer A
  INNER JOIN address B ON A. address_id = B. address_id
  INNER JOIN city C ON B. city_id = C. city_id
  INNER JOIN country D ON C. country_id = D. country_id
  INNER JOIN payment E ON A. customer_id = E. customer_id
  WHERE C. city IN (
    SELECT * FROM top_cities
  )
  GROUP BY A. first_name,
           A. last_name,
           C. city,
           D. country
  ORDER BY total_payment DESC
  LIMIT 5
)

SELECT D. country,
       COUNT(DISTINCT A.customer_id) AS all_customer_count,
       COUNT(DISTINCT top_customers.country) AS top_customer_count
FROM customer A
INNER JOIN address B ON A. address_id = B. address_id
INNER JOIN city C ON B. city_id = C. city_id
INNER JOIN country D ON C. country_id = D. country_id
LEFT JOIN top_customers ON D.country = top_customers.country
GROUP BY D.country
ORDER BY top_customer_count DESC;
