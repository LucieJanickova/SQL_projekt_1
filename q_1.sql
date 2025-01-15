-- 1.	Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
SELECT DISTINCT wage,
	   industry_name,
	   payroll_year
FROM t_lucie_janíčková_project_sql_primary_final tljpspf 
WHERE payroll_year IN ('2006','2018')
AND industry_name IS NOT NULL
;
-- Odpověď: Ve všech odvětvích se mzda během sledovaných let zvýšila.
-- O kolik procent se zvýšila mzda v roce 2018 oproti roku 2006
SELECT industry_name,
	   ROUND(((MAX(CASE WHEN payroll_year='2018'THEN wage ELSE NULL END)-
	   MAX(CASE WHEN payroll_year='2006'THEN wage ELSE NULL END))/
	   MAX(CASE WHEN payroll_year='2006'THEN wage ELSE NULL END))*100,2) AS wage_percentage_increase
FROM t_lucie_janíčková_project_sql_primary_final tljpspf
WHERE payroll_year IN ('2006','2018')	
AND industry_name IS NOT NULL
GROUP BY industry_name
;
