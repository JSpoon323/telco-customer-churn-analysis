-- =====================================================================
-- 02 | Cleaning layer (view)
-- Fixes the one real defect found in profiling and derives the fields
-- the KPIs read from. Building it as a VIEW means every KPI re-runs live
-- against the raw source and stays consistent everywhere.
-- Dialect: Google BigQuery (Standard SQL)
-- =====================================================================

CREATE OR REPLACE VIEW `my-case-study-506620.case_study1.rw_customers_clean` AS
SELECT
  customerID,
  gender,

  -- SeniorCitizen is stored 0/1; label it for readable output.
  IF(SeniorCitizen = 1, 'Yes', 'No')              AS SeniorCitizen,

  Partner,
  Dependents,
  tenure,

  -- Tenure buckets: the x-axis of the tenure churn chart.
  CASE
    WHEN tenure <= 12 THEN '0-12'
    WHEN tenure <= 24 THEN '13-24'
    WHEN tenure <= 48 THEN '25-48'
    ELSE '49-72'
  END                                             AS tenure_bucket,

  PhoneService, MultipleLines, InternetService,
  OnlineSecurity, OnlineBackup, DeviceProtection,
  TechSupport, StreamingTV, StreamingMovies,
  Contract, PaperlessBilling, PaymentMethod,

  MonthlyCharges,

  -- The 11 blank TotalCharges are new customers (tenure = 0) who were
  -- never billed. SAFE_CAST turns the blanks into NULL; COALESCE sets
  -- them to 0, which is the correct economic value.
  COALESCE(SAFE_CAST(TotalCharges AS FLOAT64), 0) AS TotalCharges,

  Churn,
  -- TRUE -> 1, FALSE -> 0, so AVG(churn_flag) equals the churn rate.
  CAST(Churn AS INT64)                            AS churn_flag
FROM `my-case-study-506620.case_study1.case study_churn retention`;
