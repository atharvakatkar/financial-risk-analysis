import pandas as pd
from sqlalchemy import create_engine
import os

# CONNECTION
engine = create_engine("postgresql://lcuser:lcpassword@127.0.0.1:5432/lending_club")

# LOAD RAW DATA
print("Loading raw data...")
df = pd.read_csv("data/raw/lending_club_loan_two.csv")

print("Shape: ", df.shape)
print("Columns: ", df.columns.to_list())
print("Loan status distribution: ", df["loan_status"].value_counts())

# BASIC CLEANING BEFORE LOADING
# strip whitespace
df.columns = df.columns.str.strip().str.lower()

# clean term column - remove " months"
df["term"] = df["term"].str.strip().str.replace(" months", "").astype(float)

# clean int_rate - remove % if present
df["int_rate"] = pd.to_numeric(
    df["int_rate"].astype(str).str.replace("%", ""), errors="coerce"
)

# Clean emp_length
df["emp_length"] = df["emp_length"].str.extract(r"(\d+)").astype(float)

# Create binary default column
df["is_default"] = df["loan_status"].apply(lambda x: 1 if x == "Charged Off" else 0)

print(f"\nDefault rate: {df['is_default'].mean():.2%}")

# LOAD TO POSTGRESQL
print("\nLoading to PostgreSQL...")
df.to_sql("loans", engine, if_exists="replace", index=False)
print("Done. Table 'loans' created in lending_club database.")
