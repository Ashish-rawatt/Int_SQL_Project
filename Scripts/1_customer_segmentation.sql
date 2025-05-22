WITH customer_ltv AS (
SELECT 
  ca.customerkey,
  ca.cleaned_name,
  SUM(total_net_revenue) AS total_ltv
FROM 
  cohort_analysis AS ca 
GROUP BY 
  ca.customerkey,
  ca.cleaned_name
ORDER BY
  ca.customerkey 
), customer_segments AS (
SELECT
  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY cl.total_ltv) AS ltv_25th_percentile,
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY cl.total_ltv) AS ltv_75th_percentile
FROM 
  customer_ltv AS cl
), segment_values AS (
SELECT
  cl.*,
  CASE 
  	WHEN cl.total_ltv < cs.ltv_25th_percentile THEN '1 - Low_value'
  	WHEN cl.total_ltv <= cs.ltv_75th_percentile THEN '2 - Mid_value'
  	ELSE '3 - High_value'
  	END customer_segment 
FROM 
  customer_ltv AS cl,
  customer_segments AS cs
)
SELECT 
  sv.customer_segment,
  SUM(total_ltv) AS total_ltv,
  COUNT(customerkey) AS cutsomer_count
FROM
  segment_values AS sv
GROUP BY 
  sv.customer_segment
ORDER BY
  sv.customer_segment DESC 