-- ================================================
-- ANALYSIS 2: DEFAULT RATES BY LOAN PURPOSE
-- Business Question: Which loan purposes are highest risk?
-- ================================================

-- 2.1 Default rate by loan purpose
SELECT 
    purpose,
    COUNT(*) AS total_loans,
    SUM(is_default) AS total_defaults,
    ROUND(AVG(is_default::numeric) * 100, 2) AS default_rate_pct,
    ROUND(AVG(loan_amnt::numeric), 2) AS avg_loan_amount,
    ROUND(AVG(int_rate::numeric), 2) AS avg_interest_rate
FROM loans
GROUP BY purpose
ORDER BY default_rate_pct DESC;

-- 2.2 Loan volume by purpose
SELECT 
    purpose,
    COUNT(*) AS total_loans,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct_of_total,
    ROUND(AVG(loan_amnt::numeric), 2) AS avg_loan_amount
FROM loans
GROUP BY purpose
ORDER BY total_loans DESC;