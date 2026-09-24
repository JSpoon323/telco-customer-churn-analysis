-- =====================================================================
-- 01 | Profiling & Data-Quality Checks
-- Run these FIRST. The goal is to prove the data is trustworthy and to
-- find problems before they reach the analysis.
-- Dialect: Google BigQuery (Standard SQL)
-- Source table: raw IBM Telco Customer Churn (7,043 rows)
-- =====================================================================

-- 1) Grain / duplicates: is it one row per customer?
--    COUNT(*) should equal COUNT(DISTINCT customerID).
SELECT
  COUNT(*)                    AS total_rows,
  COUNT(DISTINCT customerID)  AS distinct_customers
FROM `my-case-study-506620.case_study1.case study_churn retention`;
-- Result: 7,043 and 7,043 -> no duplicate keys.


-- 2) Target balance: what share of customers churned?
--    This is the headline denominator for every downstream metric.
SELECT
  Churn,
  COUNT(*)                                         AS customers,
  ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct
FROM `my-case-study-506620.case_study1.case study_churn retention`
GROUP BY Churn;
-- Result: false 5,174 (73.5%) stayed | true 1,869 (26.5%) churned.


-- 3) TotalCharges: which rows are not valid numbers?
--    SAFE_CAST returns NULL on a bad value instead of erroring like CAST.
--    Every offending row turns out to be a new customer (tenure = 0).
SELECT
  customerID, tenure, MonthlyCharges, TotalCharges
FROM `my-case-study-506620.case_study1.case study_churn retention`
WHERE SAFE_CAST(TotalCharges AS FLOAT64) IS NULL;
-- Result: 11 rows, all tenure = 0 (never billed).


-- 4) NULL / blank scan across the key columns.
SELECT
  COUNTIF(customerID     IS NULL)  AS null_id,
  COUNTIF(TRIM(TotalCharges) = '') AS blank_totalcharges,
  COUNTIF(Contract       IS NULL)  AS null_contract,
  COUNTIF(MonthlyCharges IS NULL)  AS null_monthly
FROM `my-case-study-506620.case_study1.case study_churn retention`;
-- Result: only blank_totalcharges = 11; everything else 0.


-- 5) Cardinality: confirm categorical columns hold only expected values.
--    One UNION ALL pass profiles all three drivers at once.
SELECT 'Contract' AS col, Contract AS value, COUNT(*) AS n
FROM `my-case-study-506620.case_study1.case study_churn retention` GROUP BY Contract
UNION ALL
SELECT 'InternetService', InternetService, COUNT(*)
FROM `my-case-study-506620.case_study1.case study_churn retention` GROUP BY InternetService
UNION ALL
SELECT 'PaymentMethod', PaymentMethod, COUNT(*)
FROM `my-case-study-506620.case_study1.case study_churn retention` GROUP BY PaymentMethod
ORDER BY col, n DESC;
-- Result: 3 contracts, 3 internet types, 4 payment methods; each group sums to 7,043.
