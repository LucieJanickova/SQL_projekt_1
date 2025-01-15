-- 5.	Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce,
-- projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

-- SELECT 
	  -- country,
	  --  year,
	  --   GDP,
	  -- ROUND(((GDP - LAG(GDP) OVER (ORDER BY year)) / LAG(GDP) OVER (ORDER BY year) * 100), 2) AS GDP_percentage_change
-- FROM t_lucie_janíčková_project_sql_secondary_final tljpssf 
-- WHERE country='Czech Republic';

WITH base_prices AS (
    SELECT 
        price,
        category_name,
        price_year
    FROM t_lucie_janíčková_project_sql_primary_final
),
price_changes AS (
    SELECT 
        bp1.price_year AS current_year,
        ROUND(AVG((bp1.price - bp2.price) / bp2.price) * 100, 2) AS avg_price_percentage_change
    FROM base_prices bp1
    JOIN base_prices bp2 
        ON bp1.category_name = bp2.category_name
        AND bp1.price_year = bp2.price_year + 1
    GROUP BY bp1.price_year),
base_wages AS (
    SELECT 
        wage,
        industry_name,
        payroll_year
    FROM t_lucie_janíčková_project_sql_primary_final
    WHERE industry_name IS NULL),
wage_changes AS (
    SELECT 
        bw1.payroll_year AS current_year,
        ROUND(((bw1.wage - bw2.wage) / bw2.wage) * 100, 2) AS wage_percentage_change
    FROM base_wages bw1
    JOIN base_wages bw2 
        ON bw1.payroll_year = bw2.payroll_year + 1)
SELECT DISTINCT 
    pc.current_year,
    pc.avg_price_percentage_change,
    wc.wage_percentage_change
FROM price_changes pc
JOIN wage_changes wc 
    ON pc.current_year = wc.current_year
ORDER BY pc.current_year;WITH base_prices AS (
    SELECT 
        price,
        category_name,
        price_year
    FROM t_lucie_janíčková_project_sql_primary_final
),
price_changes AS (
    SELECT 
        bp1.price_year AS current_year,
        ROUND(AVG((bp1.price - bp2.price) / bp2.price) * 100, 2) AS avg_price_percentage_change
    FROM base_prices bp1
    JOIN base_prices bp2 
        ON bp1.category_name = bp2.category_name
        AND bp1.price_year = bp2.price_year + 1
    GROUP BY bp1.price_year),
base_wages AS (
    SELECT 
        wage,
        industry_name,
        payroll_year
    FROM t_lucie_janíčková_project_sql_primary_final
    WHERE industry_name IS NULL),
wage_changes AS (
    SELECT 
        bw1.payroll_year AS current_year,
        ROUND(((bw1.wage - bw2.wage) / bw2.wage) * 100, 2) AS wage_percentage_change
    FROM base_wages bw1
    JOIN base_wages bw2 
        ON bw1.payroll_year = bw2.payroll_year + 1),
GDP_change AS (
	SELECT 
	   country,
	   year AS current_year,
	   GDP,
	   ROUND(((GDP - LAG(GDP) OVER (ORDER BY year)) / LAG(GDP) OVER (ORDER BY year) * 100), 2) AS GDP_percentage_change
	FROM t_lucie_janíčková_project_sql_secondary_final tljpssf 
	WHERE country='Czech Republic')
SELECT DISTINCT 
    pc.current_year,
    pc.avg_price_percentage_change,
    wc.wage_percentage_change,
	gc.GDP_percentage_change
FROM price_changes pc
JOIN wage_changes wc 
    ON pc.current_year = wc.current_year
JOIN GDP_change gc
	ON pc.current_year = gc.current_year
ORDER BY pc.current_year
;