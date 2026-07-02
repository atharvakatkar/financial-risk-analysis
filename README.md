# Peer Lending Risk Intelligence Dashboard

Financial risk analysis of 396,030 Lending Club loans (2007–2016) identifying borrower segments with the highest default risk using SQL, Python, and Tableau.

**[Live Dashboard](https://public.tableau.com/views/LendingClubFinancialRiskAnalysis/LendingClubFinancialRiskAnalysisDashboard)**

---

## Key Findings

1. **Loan grade is the strongest default predictor.** Grade A defaults at 6.29%, Grade G at 47.84% — a 7.6x spread. Interest rates track lockstep from ~7% to ~28%.

2. **Small business is the riskiest loan purpose.** 29.45% default rate overall. Even Grade A small business loans default at 13.32% — nearly double the Grade A average.

3. **Debt consolidation dominates volume but concentrates risk.** 59.2% of all loans, 20.74% default rate — any macro shock hits the majority of the portfolio simultaneously.

4. **Income is a clean linear predictor.** Under $30k: 25.89% default. Over $150k: 14.21%. No exceptions across income brackets.

5. **2014–2015 default spike tied to Lending Club's IPO.** Default rates jumped from ~15% to 26–27%. Lending Club went public in December 2014 — likely loosened underwriting to maximise pre-listing loan volume.

6. **Highest-risk profile:** Grade F/G + Renter + Low Income + Debt Consolidation — four compounding risk factors.

---

## Methodology

**Data:** 396,030 loans loaded into PostgreSQL. Engineered `is_default` binary flag and income bracket columns for segmentation.

**SQL Analysis:** Six query files — default rates by grade, purpose, income, employment, home ownership, and time series. Techniques: window functions, CTEs, subqueries, CASE statements, date functions.

**Python EDA:** PostgreSQL via SQLAlchemy, visualised with Matplotlib and Seaborn, exported processed summaries for Tableau.

**Tableau:** Five interactive views published to Tableau Public with annotated time series highlighting the IPO-period risk spike.

---

## SQL Techniques

| File | Techniques |
|---|---|
| `01_default_rates.sql` | GROUP BY, aggregations, casting |
| `02_risk_by_purpose.sql` | Window functions, SUM OVER() |
| `03_income_employment.sql` | CASE WHEN, income bracketing |
| `04_window_functions.sql` | RANK(), PARTITION BY, rolling averages |
| `05_cte_risk_segmentation.sql` | Multiple CTEs, JOINs, HAVING |
| `06_time_series.sql` | TO_DATE, EXTRACT, rolling averages |

---

## Structure
```
financial-risk-analysis/
├── data/
│   ├── raw/                  # Lending Club dataset (Kaggle)
│   └── processed/            # Aggregated CSVs for Tableau
├── notebooks/
│   └── eda.ipynb
├── sql/analysis/
│   ├── 01_default_rates.sql
│   ├── 02_risk_by_purpose.sql
│   ├── 03_income_employment.sql
│   ├── 04_window_functions.sql
│   ├── 05_cte_risk_segmentation.sql
│   └── 06_time_series.sql
├── assets/
└── README.md
```

---

## Run Locally

```bash
git clone https://github.com/atharvakatkar/financial-risk-analysis.git
cd financial-risk-analysis
uv venv && source .venv/bin/activate
uv pip install -r requirements.txt
# Place Lending Club CSV in data/raw/
python src/data/load_data.py
jupyter notebook notebooks/eda.ipynb
```

---

## Future Work

- Logistic regression model for individual borrower default probability
- Macroeconomic overlays (Fed funds rate, unemployment) to explain the 2014–2015 spike
- Borrower risk scoring function outputting default probability from input characteristics
- Geographic analysis using state data from the address column

---

**Atharva Katkar** | [GitHub](https://github.com/atharvakatkar) | [LinkedIn](https://www.linkedin.com/in/ankatkar) | Macquarie University
