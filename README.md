# 💳 Lending Club Financial Risk Analysis

[![Tableau Dashboard](https://img.shields.io/badge/Dashboard-Tableau%20Public-blue)](https://public.tableau.com/views/LendingClubFinancialRiskAnalysis/LendingClubFinancialRiskAnalysisDashboard)
[![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-336791)](https://www.postgresql.org/)
[![Python](https://img.shields.io/badge/Python-3.11-blue)](https://www.python.org/)

A financial risk analysis of 396,030 Lending Club loans issued between 2007-2016. Built to identify borrower segments with the highest default risk using SQL, Python, and Tableau.

🔗 **[View Live Dashboard](https://public.tableau.com/views/LendingClubFinancialRiskAnalysis/LendingClubFinancialRiskAnalysisDashboard)**

---

## Dashboard Preview

![Dashboard](assets/dashboard_screenshot.png)

---

## Business Problem

Lending Club is a peer-to-peer lending platform connecting borrowers with investors. With a 19.61% overall default rate across their loan portfolio, understanding which borrower segments carry the highest risk is critical for pricing loans correctly, managing investor exposure, and making sound underwriting decisions.

This analysis answers one central question — **what factors predict loan default and where is Lending Club's greatest risk exposure?**

---

## Key Findings

**1. Loan grade is the strongest risk predictor.** Grade A loans default at 6.29% while Grade G loans default at 47.84% — a 7.6x difference. Lending Club's internal grading system effectively captures default risk, with interest rates climbing in lockstep from ~7% for Grade A to ~28% for Grade G.

**2. Small business loans are consistently the riskiest purpose.** With a 29.45% default rate, small business loans rank as the highest risk purpose across every loan grade. Even Grade A small business loans default at 13.32% — nearly double the Grade A average.

**3. Debt consolidation dominates volume but carries hidden risk.** At 59.2% of all loans, debt consolidation is Lending Club's core business. Its 20.74% default rate means any macroeconomic shock hits the majority of the portfolio simultaneously.

**4. Income is a clean linear predictor.** Borrowers earning under $30k default at 25.89% while those earning over $150k default at 14.21%. Every income bracket is safer than the one below it without exception.

**5. The 2014-2015 risk spike coincides with Lending Club's IPO.** Default rates jumped from ~15% to 26-27% in 2014-2015. Lending Club went public in December 2014 and likely loosened underwriting standards to maximise loan volume ahead of the listing. This is the most significant risk event in the dataset.

**6. Highest risk borrower profile identified.** Grade F/G + Renter + Low Income + Debt Consolidation represents the highest default risk segment — four compounding risk factors simultaneously.

---

## Methodology

**Data:** 396,030 Lending Club loans issued 2007-2016 loaded into PostgreSQL. Two columns engineered — `is_default` binary flag and income brackets for segmentation.

**SQL Analysis:** Six query files covering default rates by grade, purpose, income, employment, home ownership, and time series trends. Techniques include window functions, CTEs, subqueries, CASE statements, and date functions.

**Python EDA:** Connected to PostgreSQL via SQLAlchemy, visualised all key findings with Matplotlib and Seaborn, exported processed summaries for Tableau.

**Tableau Dashboard:** Five interactive visualisations published to Tableau Public showing default rates across all key dimensions with annotated time series highlighting the 2014-2015 risk spike and survival bias in recent data.

---

## SQL Techniques Demonstrated

| File | Techniques |
|---|---|
| `01_default_rates.sql` | GROUP BY, aggregations, type casting |
| `02_risk_by_purpose.sql` | Window functions, SUM OVER() |
| `03_income_employment.sql` | CASE WHEN, income bracketing |
| `04_window_functions.sql` | RANK(), PARTITION BY, rolling averages |
| `05_cte_risk_segmentation.sql` | Multiple CTEs, JOINs, HAVING |
| `06_time_series.sql` | Date functions, TO_DATE, EXTRACT, rolling averages |

---

## Project Structure
```
financial-risk-analysis/
├── data/
│   ├── raw/                  # Original Lending Club dataset (see Kaggle)
│   └── processed/            # Aggregated CSVs for Tableau
├── notebooks/
│   └── eda.ipynb             # Python EDA and visualisations
├── sql/
│   └── analysis/
│       ├── 01_default_rates.sql
│       ├── 02_risk_by_purpose.sql
│       ├── 03_income_employment.sql
│       ├── 04_window_functions.sql
│       ├── 05_cte_risk_segmentation.sql
│       └── 06_time_series.sql
├── assets/                   # Screenshots
└── README.md
```

---

## How to Run Locally

**Prerequisites:** Python 3.11+, PostgreSQL 14+, Tableau Public
```bash
# Clone the repository
git clone https://github.com/atharvakatkar/financial-risk-analysis.git
cd financial-risk-analysis

# Create virtual environment
uv venv
source .venv/bin/activate
uv pip install -r requirements.txt

# Download dataset from Kaggle
# Search: "Lending Club Loan Data" — place CSV in data/raw/

# Load data into PostgreSQL
python src/data/load_data.py

# Run EDA notebook
jupyter notebook notebooks/eda.ipynb
```

---

## Future Work

- Add a logistic regression model to predict default probability for individual borrowers
- Incorporate macroeconomic indicators — Fed funds rate, unemployment rate — to explain the 2014-2015 spike
- Build a borrower risk scoring function that outputs a default probability given borrower characteristics
- Expand geographic analysis using state data extracted from the address column

---

## Tech Stack

Python, Pandas, NumPy, Matplotlib, Seaborn, SQLAlchemy, PostgreSQL, Tableau Public

---

## Author

**Atharva Katkar**
[GitHub](https://github.com/atharvakatkar) | [LinkedIn](https://www.linkedin.com/in/ankatkar)

*Data Science Student — Macquarie University*