-- 3.Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
WITH prices_2006 AS
	(SELECT DISTINCT price,
				category_name,
				price_year
	FROM t_lucie_janíčková_project_sql_primary_final tljpspf 
	WHERE price_year ='2006')
,
	prices_2018 AS 
	(SELECT DISTINCT price,
				category_name,
				price_year
	FROM t_lucie_janíčková_project_sql_primary_final tljpspf 
	WHERE price_year ='2018')
SELECT p2006.price AS price_2006,
	   p2018.price AS price_2018,
	   p2006.category_name,
	   (p2018.price - p2006.price) AS price_difference,
	   ROUND(((p2018.price - p2006.price) / p2006.price) * 100,2) AS price_percentage_change
FROM prices_2006 AS p2006
JOIN prices_2018 AS p2018
ON p2006.category_name=p2018.category_name
ORDER BY price_percentage_change 
;

