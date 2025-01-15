-- jméno na Discordu lucie_janickova

CREATE TABLE t_Lucie_Janíčková_project_SQL_primary_final AS
(WITH prices AS
	(SELECT 
	ROUND(AVG(value),2) AS price,
	category_code,
	cpc.name AS category_name,
	YEAR (date_from) AS price_year
	FROM czechia_price cp
	JOIN czechia_price_category cpc 
	ON cp.category_code = cpc.code
	WHERE region_code IS NULL 
	GROUP BY price_year, category_name)
	,
	wages AS 
	(SELECT 
	ROUND(AVG(cp.value),0) AS wage,
	cp.industry_branch_code,
	cpib.name AS industry_name,
	cp.payroll_year 
	FROM czechia_payroll cp 
	LEFT JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code = cpib.code
	WHERE value_type_code ='5958'
	GROUP BY industry_name, payroll_year)
SELECT 
	   pr.price,
	   pr.category_name,
	   pr.price_year,
	   w.wage,
	   w.industry_name,
	   w.payroll_year
FROM prices AS pr
JOIN wages AS w
ON w.payroll_year=pr.price_year)
;

