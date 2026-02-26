-- ================================================
-- ANALYSIS 4: ADVANCED ANALYSIS WITH WINDOW FUNCTIONS
-- Business Question: How does risk accumulate across loan grades 
-- and what are the cumulative exposure patterns?
-- ================================================

-- 4.1 Cumulative default rate across grades using window functions
SELECT 
    grade,
    total_loans,
    total_defaults,
    default_rate_pct,
    SUM(total_loans) OVER (ORDER BY grade) AS cumulative_loans,
    SUM(total_defaults) OVER (ORDER BY grade) AS cumulative_defaults,
    ROUND(SUM(total_defaults) OVER (ORDER BY grade)::numeric / 
          SUM(total_loans) OVER (ORDER BY grade) * 100, 2) AS cumulative_default_rate
FROM (
    SELECT 
        grade,
        COUNT(*) AS total_loans,
        SUM(is_default) AS total_defaults,
        ROUND(AVG(is_default::numeric) * 100, 2) AS default_rate_pct
    FROM loans
    GROUP BY grade
) grade_summary
ORDER BY grade;

-- 4.2 Rank loan purposes by default rate within each grade
SELECT 
    grade,
    purpose,
    total_loans,
    default_rate_pct,
    RANK() OVER (PARTITION BY grade ORDER BY default_rate_pct DESC) AS risk_rank
FROM (
    SELECT 
        grade,
        purpose,
        COUNT(*) AS total_loans,
        ROUND(AVG(is_default::numeric) * 100, 2) AS default_rate_pct
    FROM loans
    WHERE grade IN ('A', 'B', 'C', 'D')
    GROUP BY grade, purpose
    HAVING COUNT(*) > 100
) ranked
ORDER BY grade, risk_rank;

-- 4.3 Rolling 3-grade average default rate
SELECT 
    grade,
    default_rate_pct,
    ROUND(AVG(default_rate_pct) OVER (
        ORDER BY grade 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ), 2) AS rolling_avg_default_rate
FROM (
    SELECT 
        grade,
        ROUND(AVG(is_default::numeric) * 100, 2) AS default_rate_pct
    FROM loans
    GROUP BY grade
) grade_rates
ORDER BY grade;