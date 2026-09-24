# Telco Customer Churn & Retention Analysis

A SQL-driven analysis of customer churn for a telecom provider: profile the data, clean it, quantify the revenue at risk, and identify exactly which customers to save. Built in **Google BigQuery**, explored in **Excel**, and summarized in a stakeholder dashboard.

**Analyst:** Spoon · **Tools:** BigQuery (SQL), Excel, dashboard, Claude (AI assistant)

## The business question

A 26.5% annual churn rate means roughly one in four customers leaves every year. The goal of this analysis is not "how much are we losing?" but **"who exactly is leaving, and what do they have in common that we can act on?"**

## Headline result

Of 7,043 customers, **1,869 churned (26.5%)**, carrying **$1,669,570 in annual recurring revenue at risk**, about 30.5% of the total $5.47M revenue base. The loss concentrates in one segment, **month-to-month + fiber optic + electronic check**: 1,307 customers churning at **60.4%**, which is 49% of all at-risk revenue.

## Key findings

| Driver | Finding |
|---|---|
| Contract type | Month-to-month churns at 42.7% vs 2.8% for two-year (about 15x). The strongest single driver. |
| Tenure | First-year churn is 47.4%, falling to 9.5% by year 4+. Retention is won in the first 12 months. |
| Internet service | Fiber optic churns at 41.9%, more than double DSL (19.0%). The premium product retains worst. |
| Payment method | Electronic check churns at 45.3%, about 3x either auto-pay method. Auto-pay acts as a retention mechanism. |

## Recommendations

Convert month-to-month customers to annual contracts, the largest lever, since two-year contracts churn at just 2.8%. Drive auto-pay enrollment starting with electronic-check customers, who churn at about 3x the auto-pay rate. Build a first-year onboarding and retention program, since nearly half of all churn happens in the first 12 months. Investigate the fiber value gap: a premium product churning worst signals a price-to-value mismatch. Full narrative with illustrative impact sizing is in Insights_and_Recommendations.md.

## How it was built (method)

Profiling and data-quality checks (01_profiling_and_data_quality.sql) confirm the grain (one row per customer, no duplicates), establish the churn denominator, and find the one real defect: 11 blank TotalCharges values, all new customers with tenure 0. A cleaning view (02_clean_view.sql) repairs TotalCharges with SAFE_CAST plus COALESCE and derives the analytical fields tenure_bucket and churn_flag; AVG(churn_flag) equals the churn rate. Six KPI queries (03_kpi_queries.sql) each feed a tile or chart on the dashboard. Every query and result is captured in the numbered .png screenshots and narrated slide-by-slide in Churn_SQL_Walkthrough.pptx.

## Files in this repository

| File | What it is |
|---|---|
| 01_profiling_and_data_quality.sql | Profiling and data-quality checks |
| 02_clean_view.sql | Cleaning layer (view): fixes TotalCharges, derives fields |
| 03_kpi_queries.sql | Six KPI queries that feed the dashboard |
| Insights_and_Recommendations.md / .docx | Full written analysis |
| verified_findings.md | Raw verified numbers |
| Churn_SQL_Walkthrough.pptx | 16-slide SQL walkthrough |
| 01 to 12 .png | 12 BigQuery query and result screenshots |
| WA_Fn-UseC_-Telco-Customer-Churn.csv | Raw source dataset (7,043 rows) |
| SOURCE.md | Dataset origin and license note |

## Reproduce it

Load WA_Fn-UseC_-Telco-Customer-Churn.csv into a BigQuery dataset. Run 01_profiling_and_data_quality.sql to profile, then 02_clean_view.sql to build the cleaned view, then 03_kpi_queries.sql for the KPIs. Update the project and dataset path at the top of each query to match your own.

## Data source

IBM sample "Telco Customer Churn" dataset (7,043 customers, 21 fields), widely mirrored on Kaggle. See SOURCE.md. This is a public sample dataset used here for portfolio demonstration.

*This project was completed with AI assistance (Claude) as a working tool. All queries were run and verified by the analyst against live BigQuery results.*
