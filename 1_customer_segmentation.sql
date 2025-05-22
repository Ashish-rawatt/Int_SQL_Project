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
)
SELECT
  cl.*,
  CASE 
  	WHEN cl.total_ltv < cs.ltv_25th_percentile THEN '1 - low_value'
  	WHEN cl.total_ltv <= cs.ltv_75th_percentile THEN '2 - mid_value'
  	ELSE '3 - high_value'
  	END customer_segment 
FROM 
  customer_ltv AS cl,
  customer_segments AS cs;