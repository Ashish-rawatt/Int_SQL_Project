WITH null_rev AS (
SELECT
  s.customerkey ,
  SUM(s.netprice*s.quantity*s.exchangerate) AS net_rev
FROM 
  sales AS s
LEFT JOIN customer  AS c ON s.customerkey = c.customerkey
GROUP BY
  s.customerkey
)
SELECT
  AVG(nr.net_rev) AS sp_cust_rev,
  AVG(coalesce(nr.net_rev , 0)) AS all_cust_rev
FROM 
  customer  AS c 
LEFT JOIN null_rev AS nr ON nr.customerkey = c.customerkey