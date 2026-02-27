-- ================================================
-- ANALYSIS 6: TIME SERIES — DEFAULT TRENDS OVER TIME
-- Business Question: How have default rates changed over time?
-- ================================================

-- 6.1 Monthly loan issuance and default rate over time
SELECT 
    issue_d,
    COUNT(*) AS total_loans,
    SUM(is_default) AS total_defaults,
    ROUND(AVG(is_default::numeric) * 100, 2) AS default_rate_pct,
    ROUND(AVG(loan_amnt::numeric), 2) AS avg_loan_amount,
    ROUND(AVG(int_rate::numeric), 2) AS avg_interest_rate
FROM loans
GROUP BY issue_d
ORDER BY TO_DATE(issue_d, 'Mon-YYYY');

-- 6.2 Yearly summary
SELECT 
    EXTRACT(YEAR FROM TO_DATE(issue_d, 'Mon-YYYY')) AS year,
    COUNT(*) AS total_loans,
    SUM(is_default) AS total_defaults,
    ROUND(AVG(is_default::numeric) * 100, 2) AS default_rate_pct,
    ROUND(SUM(loan_amnt::numeric) / 1000000, 2) AS total_volume_millions
FROM loans
GROUP BY year
ORDER BY year;

-- 6.3 Rolling 3 month average default rate
WITH monthly_rates AS (
    SELECT 
        TO_DATE(issue_d, 'Mon-YYYY') AS loan_date,
        ROUND(AVG(is_default::numeric) * 100, 2) AS monthly_default_rate,
        COUNT(*) AS total_loans
    FROM loans
    GROUP BY loan_date
)
SELECT 
    loan_date,
    monthly_default_rate,
    total_loans,
    ROUND(AVG(monthly_default_rate) OVER (
        ORDER BY loan_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS rolling_3month_avg
FROM monthly_rates
ORDER BY loan_date;