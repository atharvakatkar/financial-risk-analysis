-- ================================================
-- ANALYSIS 3: DEFAULT RATES BY INCOME AND EMPLOYMENT
-- Business Question: How do borrower financials affect default risk?
-- ================================================

-- 3.1 Default rate by employment length
SELECT 
    emp_length,
    COUNT(*) AS total_loans,
    SUM(is_default) AS total_defaults,
    ROUND(AVG(is_default::numeric) * 100, 2) AS default_rate_pct,
    ROUND(AVG(annual_inc::numeric), 2) AS avg_annual_income
FROM loans
WHERE emp_length IS NOT NULL
GROUP BY emp_length
ORDER BY emp_length;

-- 3.2 Default rate by income bracket
SELECT 
    CASE 
        WHEN annual_inc < 30000 THEN '1. Under $30k'
        WHEN annual_inc < 50000 THEN '2. $30k-$50k'
        WHEN annual_inc < 75000 THEN '3. $50k-$75k'
        WHEN annual_inc < 100000 THEN '4. $75k-$100k'
        WHEN annual_inc < 150000 THEN '5. $100k-$150k'
        ELSE '6. Over $150k'
    END AS income_bracket,
    COUNT(*) AS total_loans,
    SUM(is_default) AS total_defaults,
    ROUND(AVG(is_default::numeric) * 100, 2) AS default_rate_pct,
    ROUND(AVG(loan_amnt::numeric), 2) AS avg_loan_amount
FROM loans
GROUP BY income_bracket
ORDER BY income_bracket;

-- 3.3 Default rate by home ownership
SELECT 
    home_ownership,
    COUNT(*) AS total_loans,
    SUM(is_default) AS total_defaults,
    ROUND(AVG(is_default::numeric) * 100, 2) AS default_rate_pct,
    ROUND(AVG(annual_inc::numeric), 2) AS avg_annual_income
FROM loans
GROUP BY home_ownership
ORDER BY default_rate_pct DESC;