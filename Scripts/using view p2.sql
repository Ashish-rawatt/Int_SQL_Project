-- before correction
SELECT 
  ca.cohort_year,
  SUM(ca.total_net_revenue) AS total_revenue,
  COUNT(DISTINCT ca.customerkey) AS total_customers,
  SUM(ca.total_net_revenue) / COUNT(DISTINCT ca.customerkey) AS customer_revenue
FROM
  cohort_analysis  AS ca
GROUP BY	
  ca.cohort_year
ORDER BY 
  ca.cohort_year;

-- after correction
SELECT 
  ca.cohort_year,
  SUM(ca.total_net_revenue) AS total_revenue,
  COUNT(DISTINCT ca.customerkey) AS total_customers,
  SUM(ca.total_net_revenue) / COUNT(DISTINCT ca.customerkey) AS customer_revenue
FROM
  cohort_analysis  AS ca
WHERE 
  ca.orderdate = ca.first_purchase_date
GROUP BY	
  ca.cohort_year
ORDER BY 
  ca.cohort_year;