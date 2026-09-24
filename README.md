# Telco Customer Churn & Retention Analysis

A SQL-driven analysis of customer churn for a telecom provider: profile the data, clean it, quantify the revenue at risk, and identify exactly which customers to save. Built in **Google BigQuery**, explored in **Excel**, and summarized in a stakeholder dashboard.

**Analyst:** Spoon · **Tools:** BigQuery (SQL), Excel, dashboard, Claude (AI assistant)

---

## The business question

A 26.5% annual churn rate means roughly one in four customers leaves every year. The goal of this analysis is not "how much are we losing?" but **"who exactly is leaving, and what do they have in common that we can act on?"**

## Headline result

- **1,869 of 7,043 customers churned (26.5%)**
- **$1,669,570 in annual recurring revenue at risk** — about **30.5% of the total $5.47M revenue base**
- The loss concentrates in one segment: **month-to-month + fiber optic + electronic check** — 1,307 customers churning at **60.4%**, which is **49% of all at-risk revenue**

## Key findings

| Driver | Finding |
|---|---|
| **Contract type** | Month-to-month churns at **42.7%** vs **2.8%** for two-year (about 15x). The strongest single driver. |
| **Tenure** | First-year churn is **47.4%**, falling to **9.5%** by year 4+. Retention is won in the first 12 months. |
| **Internet service** | Fiber optic churns at **41.9%**, more than double DSL (19.0%). The premium product retains worst. |
| **Payment method** | Electronic check churns at **45.3%**, about 3x either auto-pay method. Auto-pay acts as a retention mechanism. |

## Recommendations

1. **Convert month-to-month customers to annual contracts** — the largest lever (two-year contracts churn at 2.8%).
2. **Drive auto-pay enrollment**, starting with electronic-check customers (they churn at ~3x the auto-pay rate).
3. **Build a first-year onboarding and retention program** — nearly half of all churn happens in the first 12 months.
4. **Investigate the fiber value gap** — a premium product churning worst signals a price-to-value mismatch.

Full narrative with tables and illustrative impact sizing: [`docs/Insights_and_Recommendations.md`](docs/Insights_and_Recommendations.md).

---

## How it was built (method)

1. **Profile & QA** ([`sql/01_profiling_and_data_quality.sql`](sql/01_profiling_and_data_quality.sql)) — confirm the grain (one row per customer, no duplicates), establish the churn denominator, and find the one real defect: 11 blank `TotalCharges` values, all new customers with `tenure = 0`.
2. **Clean** ([`sql/02_clean_view.sql`](sql/02_clean_view.sql)) — a view that repairs `TotalCharges` with `SAFE_CAST` + `COALESCE` and derives the analytical fields (`tenure_bucket`, `churn_flag`). `AVG(churn_flag)` conveniently equals the churn rate.
3. **KPIs** ([`sql/03_kpi_queries.sql`](sql/03_kpi_queries.sql)) — six queries, one per business question, each feeding a tile or chart on the dashboard.

Every query and result is captured in [`screenshots/`](screenshots/) and narrated slide-by-slide in [`presentation/Churn_SQL_Walkthrough.pptx`](presentation/Churn_SQL_Walkthrough.pptx).

## Repository structure

```
telco-customer-churn-analysis/
├── README.md
├── data/
│   ├── WA_Fn-UseC_-Telco-Customer-Churn.csv   # raw source dataset (7,043 rows)
│   └── SOURCE.md                              # dataset origin & license
├── sql/
│   ├── 01_profiling_and_data_quality.sql
│   ├── 02_clean_view.sql
│   └── 03_kpi_queries.sql
├── docs/
│   ├── Insights_and_Recommendations.md        # full written analysis
│   ├── Insights_and_Recommendations.docx      # Word version
│   └── verified_findings.md                   # raw verified numbers
├── presentation/
│   └── Churn_SQL_Walkthrough.pptx             # 16-slide SQL walkthrough
└── screenshots/                              # 12 BigQuery query + result captures
```

## Reproduce it

1. Load `data/WA_Fn-UseC_-Telco-Customer-Churn.csv` into a BigQuery dataset.
2. Run `sql/01_...` to profile, `sql/02_...` to build the cleaned view, then `sql/03_...` for the KPIs.
3. Update the project/dataset path at the top of each query to match your own.

## Data source

IBM sample "Telco Customer Churn" dataset (7,043 customers, 21 fields), widely mirrored on Kaggle. See [`data/SOURCE.md`](data/SOURCE.md). This is a public sample dataset used here for portfolio demonstration.

---

*This project was completed with AI assistance (Claude) as a working tool. All queries were run and verified by the analyst against live BigQuery results.*
