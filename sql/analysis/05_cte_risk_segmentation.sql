-- ================================================
-- ANALYSIS 5: RISK SEGMENTATION USING CTEs
-- Business Question: Which borrower segments represent 
-- the highest combined risk exposure?
-- ================================================

-- 5.1 Multi-factor risk segmentation using CTEs
WITH grade_risk AS (
    SELECT 
        grade,
        ROUND(AVG(is_default::numeric) * 100, 2) AS grade_default_rate
    FROM loans
    GROUP BY grade
),
income_risk AS (
    SELECT 
        CASE 
            WHEN annual_inc < 50000 THEN 'Low Income'
            WHEN annual_inc < 100000 THEN 'Mid Income'
            ELSE 'High Income'
        END AS income_segment,
        ROUND(AVG(is_default::numeric) * 100, 2) AS income_default_rate
    FROM loans
    GROUP BY income_segment
),
combined_risk AS (
    SELECT 
        l.grade,
        CASE 
            WHEN l.annual_inc < 50000 THEN 'Low Income'
            WHEN l.annual_inc < 100000 THEN 'Mid Income'
            ELSE 'High Income'
        END AS income_segment,
        COUNT(*) AS total_loans,
        SUM(l.is_default) AS total_defaults,
        ROUND(AVG(l.is_default::numeric) * 100, 2) AS default_rate_pct,
        ROUND(AVG(l.loan_amnt::numeric), 2) AS avg_loan_amount,
        ROUND(SUM(l.loan_amnt::numeric) / 1000000, 2) AS total_exposure_millions
    FROM loans l
    GROUP BY l.grade, income_segment
)
SELECT 
    cr.grade,
    cr.income_segment,
    cr.total_loans,
    cr.total_defaults,
    cr.default_rate_pct,
    cr.avg_loan_amount,
    cr.total_exposure_millions,
    gr.grade_default_rate,
    ir.income_default_rate,
    ROUND((cr.default_rate_pct - gr.grade_default_rate + cr.default_rate_pct - ir.income_default_rate) / 2, 2) AS risk_deviation
FROM combined_risk cr
JOIN grade_risk gr ON cr.grade = gr.grade
JOIN income_risk ir ON cr.income_segment = ir.income_segment
ORDER BY cr.default_rate_pct DESC
LIMIT 20;

-- 5.2 Identify highest risk borrower profile
WITH borrower_segments AS (
    SELECT 
        grade,
        home_ownership,
        CASE 
            WHEN annual_inc < 50000 THEN 'Low Income'
            WHEN annual_inc < 100000 THEN 'Mid Income'
            ELSE 'High Income'
        END AS income_segment,
        purpose,
        COUNT(*) AS total_loans,
        ROUND(AVG(is_default::numeric) * 100, 2) AS default_rate_pct,
        ROUND(SUM(loan_amnt::numeric) / 1000000, 2) AS exposure_millions
    FROM loans
    GROUP BY grade, home_ownership, income_segment, purpose
    HAVING COUNT(*) > 200
)
SELECT *
FROM borrower_segments
ORDER BY default_rate_pct DESC
LIMIT 15;