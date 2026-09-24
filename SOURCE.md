# Data Source

**Dataset:** Telco Customer Churn (IBM sample data)
**File:** `WA_Fn-UseC_-Telco-Customer-Churn.csv`
**Rows:** 7,043 customers · **Columns:** 21

Each row is one telecom customer, with account attributes (tenure, contract, internet service, payment method, monthly and total charges) and a `Churn` flag indicating whether they left.

This is a well-known public sample dataset originally published by IBM and widely mirrored on Kaggle ("Telco Customer Churn"). It is used here purely for portfolio and educational demonstration. It contains no real personal data.

**Known data-quality note:** 11 rows have a blank `TotalCharges`. All 11 are new customers with `tenure = 0` (never billed). The cleaning view (`sql/02_clean_view.sql`) sets these to 0.
