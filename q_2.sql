-- 2.	Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
SELECT DISTINCT price,
	   		    category_name,
	   			price_year
FROM t_lucie_janíčková_project_sql_primary_final tljpspf 
WHERE price_year IN ('2006','2018')
AND (category_name LIKE '%mléko%' OR category_name LIKE '%chléb%')
;

SELECT DISTINCT wage, 
				industry_name,
				payroll_year
FROM t_lucie_janíčková_project_sql_primary_final tljpspf 
WHERE industry_name IS NULL 
AND payroll_year IN ('2006','2018')
;
-- výsledná tabulka
SELECT DISTINCT *,
				ROUND((wage/price),0) AS ratio
FROM t_lucie_janíčková_project_sql_primary_final tljpspf 
WHERE price_year IN ('2006','2018')
AND (category_name LIKE '%mléko%' OR category_name LIKE '%chléb%')
AND industry_name IS NULL
;