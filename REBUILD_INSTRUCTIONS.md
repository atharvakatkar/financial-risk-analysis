# Financial Risk Analysis — Learning-First Rebuild

Use Claude as a tutor, reviewer, and debugging partner—not as a code generator. Your goal is to understand and rebuild this project yourself so you can explain every major decision in an interview.

## Rules for Claude

- Do not write complete notebooks, scripts, SQL queries, models, dashboards, or READMEs in one response.
- First explain the concept, approach, assumptions, and trade-offs.
- Ask clarifying questions before giving advice.
- Let me attempt the implementation first.
- Review only the code, output, charts, or interpretation I provide.
- Point out bugs, leakage, poor assumptions, and weak reasoning; ask me to fix them.
- Explain why a correction matters, not only what to change.
- If I ask for a full solution, remind me of these rules and ask me to attempt it first.

## Project goal

Rebuild this into a rigorous, reproducible analysis of loan default risk.

**Business question:** Which borrower and loan characteristics are most associated with default, and how could a lender use these patterns to prioritise risk review?

## Rebuild order

1. Audit and understand the existing repository.
2. Audit and document the raw data.
3. Build a reproducible cleaning and feature-preparation pipeline.
4. Conduct exploratory data analysis.
5. Build a simple baseline and an interpretable logistic-regression model.
6. Evaluate the model properly.
7. Interpret results and communicate recommendations.
8. Rewrite the README and clean the repository.

## Stage 1: Understand the current project

Create `rebuild-plan.md` before changing analysis code.

Prompt for Claude:

> I am rebuilding my financial-risk-analysis project because it was heavily AI-assisted and I want to genuinely learn the analysis. Please do not write the full solution. First, ask me questions to establish what I understand about the Lending Club dataset, SQL, exploratory data analysis, and logistic regression. Then help me create a stage-by-stage rebuild plan with deliverables and learning objectives.

Deliverables:

- Inventory of existing notebooks, SQL files, charts, and dashboard assets
- List of what you understand versus what you cannot yet explain
- A prioritised rebuild plan
- A learning log template

## Stage 2: Data audit

Create `data_audit.md`.

Prompt for Claude:

> I have a loan dataset with a `loan_status` target. Teach me how to perform a data audit before analysis. Ask me questions about the columns, target definition, date fields, missing values, duplicates, outliers, data types, and possible target leakage. Then help me write SQL and Python myself to document data quality. Do not write the complete audit code.

Deliverables:

- Data dictionary
- Missingness and data-quality report
- Target definition and leakage assessment
- Cleaning decisions with justifications
- Reproducible SQL/Python cleaning pipeline

Key questions to answer:

- What exactly counts as default in this dataset?
- Which columns would not be available at the time a lending decision is made?
- Are there date fields that could cause future information to leak into the model?
- Which missing values should be imputed, flagged, or excluded?
- Are outliers errors, genuine extreme values, or meaningful risk signals?

## Stage 3: Exploratory analysis

Prompt for Claude:

> Teach me how to conduct exploratory analysis for a loan-default dataset. Help me form hypotheses, choose appropriate visualisations, calculate default rates across meaningful segments, and identify confounding factors. I will write the SQL and Python. Review my approach and results, but do not provide the complete code.

Deliverables:

- Default rate by grade, term, interest rate, income, debt-to-income, loan amount, employment length, home ownership, and purpose
- Distribution and outlier analysis
- Correlation analysis with appropriate caveats
- At least 6 decision-oriented charts
- A short EDA findings document

Important: distinguish association from causation. A feature may predict default without causing it.

## Stage 4: Modelling

Prompt for Claude:

> Teach me logistic regression for binary default classification. Explain assumptions, coefficient and odds-ratio interpretation, feature encoding, class imbalance, train/test splitting, regularisation, calibration, and threshold selection. Then ask me to implement a baseline model myself. Review my code and interpretation without writing the full solution.

Deliverables:

- A documented baseline model, such as predicting the majority class or using a simple rule
- A logistic-regression model with interpretable features
- Train/test or time-based validation strategy
- ROC-AUC, precision, recall, F1, confusion matrix, and calibration analysis
- Threshold analysis tied to a business trade-off
- Coefficient or odds-ratio interpretation
- Clear limitations and assumptions

Do not use XGBoost or another complex model until the logistic-regression baseline is understood and documented.

## Stage 5: Communication

Prompt for Claude:

> Review my README and analysis narrative. Help me turn technical results into a concise business recommendation for a lender. Ask me questions to test whether I understand my own analysis. Do not rewrite it entirely; give structured feedback first.

Deliverables:

- Professional README
- Executive summary
- Key findings
- Risk-segment recommendations
- Limitations
- Reproduction instructions

## Completion checklist

Before calling this project complete, answer in writing:

- What business decision does this support?
- What data did I use, and what are its limitations?
- What did I clean, transform, or exclude, and why?
- What baseline did I compare against?
- Why did I choose logistic regression?
- How did I validate the model?
- Which metric matters most, and why?
- What are the main drivers of the result?
- What would I do differently with more time or better data?
- What recommendation would I give a decision-maker?
