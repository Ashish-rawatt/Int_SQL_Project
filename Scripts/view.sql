CREATE VIEW daily_rev AS 
SELECT
  s.orderdate,
  SUM(s.netprice*s.quantity *s.exchangerate) AS net_rev
FROM
  sales AS s
GROUP BY
  s.orderdate
ORDER BY  
  s.orderdate desc
 
 SELECT*
 FROM daily_rev
 
 DROP VIEW daily_rev