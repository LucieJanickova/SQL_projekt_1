-- 4.	Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
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
    wc.wage_percentage_change,
    CASE WHEN (pc.avg_price_percentage_change- wc.wage_percentage_change) >10 THEN 'ANO' ELSE 'NE' 
    END AS difference_above_10
FROM price_changes pc
JOIN wage_changes wc 
    ON pc.current_year = wc.current_year
ORDER BY pc.current_year;
