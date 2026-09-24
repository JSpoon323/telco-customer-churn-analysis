-- =====================================================================
-- 03 | KPI Queries (feed the dashboard)
-- Each block answers one business question and reads from the cleaned
-- view, so numbers are consistent across SQL, Excel, and the dashboard.
-- Trick: AVG(churn_flag) = churn rate, which keeps the SQL short.
-- Dialect: Google BigQuery (Standard SQL)
-- =====================================================================

-- KPI 1 | How big is churn, and what is it costing?
SELECT
  COUNT(*)                                           AS total_customers,
  SUM(churn_flag)                                    AS churned_customers,
  ROUND(100 * AVG(churn_flag), 1)                    AS churn_rate_pct,
  ROUND(SUM(IF(Churn, MonthlyCharges, 0)), 0)        AS monthly_revenue_at_risk,
  ROUND(SUM(IF(Churn, MonthlyCharges, 0)) * 12, 0)   AS annual_revenue_at_risk
FROM `my-case-study-506620.case_study1.rw_customers_clean`;
-- 7,043 | 1,869 | 26.5% | $139,131 / mo | $1,669,570 / yr


-- KPI 2 | Does contract type drive churn?
SELECT
  Contract,
  COUNT(*)                        AS customers,
  SUM(churn_flag)                 AS churned,
  ROUND(100 * AVG(churn_flag), 1) AS churn_rate_pct
FROM `my-case-study-506620.case_study1.rw_customers_clean`
GROUP BY Contract
ORDER BY churn_rate_pct DESC;
-- Month-to-month 42.7% | One year 11.3% | Two year 2.8%


-- KPI 3 | Is there a tenure lifecycle to churn?
SELECT
  tenure_bucket,
  COUNT(*)                        AS customers,
  ROUND(100 * AVG(churn_flag), 1) AS churn_rate_pct
FROM `my-case-study-506620.case_study1.rw_customers_clean`
GROUP BY tenure_bucket
ORDER BY tenure_bucket;
-- 0-12: 47.4% | 13-24: 28.7% | 25-48: 20.4% | 49-72: 9.5%


-- KPI 4 | Does internet service type affect churn?
SELECT
  InternetService,
  COUNT(*)                        AS customers,
  ROUND(100 * AVG(churn_flag), 1) AS churn_rate_pct
FROM `my-case-study-506620.case_study1.rw_customers_clean`
GROUP BY InternetService
ORDER BY churn_rate_pct DESC;
-- Fiber optic 41.9% | DSL 19.0% | No 7.4%


-- KPI 5 | Does payment method signal churn?
SELECT
  PaymentMethod,
  COUNT(*)                        AS customers,
  ROUND(100 * AVG(churn_flag), 1) AS churn_rate_pct
FROM `my-case-study-506620.case_study1.rw_customers_clean`
GROUP BY PaymentMethod
ORDER BY churn_rate_pct DESC;
-- Electronic check 45.3% | Mailed check 19.1% | Bank transfer 16.7% | Credit card 15.2%


-- KPI 6 | Which package profile is the highest risk (the money query)?
SELECT
  Contract, InternetService, PaymentMethod,
  COUNT(*)                                          AS customers,
  ROUND(100 * AVG(churn_flag), 1)                   AS churn_rate_pct,
  ROUND(SUM(IF(Churn, MonthlyCharges, 0)) * 12, 0)  AS annual_revenue_at_risk
FROM `my-case-study-506620.case_study1.rw_customers_clean`
GROUP BY Contract, InternetService, PaymentMethod
HAVING customers >= 100
ORDER BY churn_rate_pct DESC
LIMIT 10;
-- Top: Month-to-month + Fiber + Electronic check -> 1,307 cust, 60.4%, $819,378 (49% of at-risk revenue)
