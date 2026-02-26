-- ================================================
-- ANALYSIS 1: OVERALL DEFAULT RATES BY LOAN GRADE
-- Business Question: Which loan grades carry the highest default risk?
-- ================================================

-- 1.1 Overall default rate
SELECT 
    COUNT(*) AS total_loans,
    SUM(is_default) AS total_defaults,
    ROUND(AVG(is_default::numeric) * 100, 2) AS default_rate_pct
FROM loans;

-- 1.2 Default rate by loan grade
SELECT 
    grade,
    COUNT(*) AS total_loans,
    SUM(is_default) AS total_defaults,
    ROUND(AVG(is_default::numeric) * 100, 2) AS default_rate_pct,
    ROUND(AVG(int_rate::numeric), 2) AS avg_interest_rate
FROM loans
GROUP BY grade
ORDER BY grade;

-- 1.3 Default rate by sub grade
SELECT 
    sub_grade,
    COUNT(*) AS total_loans,
    SUM(is_default) AS total_defaults,
    ROUND(AVG(is_default::numeric) * 100, 2) AS default_rate_pct,
    ROUND(AVG(int_rate::numeric), 2) AS avg_interest_rate
FROM loans
GROUP BY sub_grade
ORDER BY sub_grade;