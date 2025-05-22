CREATE VIEW cohort_Analysis AS 
WITH customer_revenue AS (
	SELECT 
	  s.customerkey,
	  s.orderdate,
	  SUM(s.netprice*s.quantity*s.exchangerate) AS Total_net_revenue,
	  COUNT(s.orderkey) AS num_orders,
	  c.countryfull,
	  c.age,
	  c.givenname,
	  c.surname
	FROM
	  sales AS s
	LEFT JOIN customer AS c ON c.customerkey = s.customerkey
	GROUP BY 
	  s.customerkey,
	  s.orderdate,
	  c.countryfull,
	  c.age,
	  c.givenname,
	  c.surname
)
SELECT
  cr.*,
  MIN(cr.orderdate) OVER(PARTITION BY cr.customerkey) AS first_purchase_date,
  EXTRACT(YEAR FROM MIN(cr.orderdate) OVER(PARTITION BY cr.customerkey))  AS cohort_year
FROM
  customer_revenue AS cr