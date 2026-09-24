# Customer Churn & Retention: Insights & Recommendations

**Analyst:** Spoon · **Tools:** BigQuery (SQL), Excel, dashboard, Claude (AI assistant) · **Grain:** one row per customer
**Dataset:** IBM Telco Customer Churn (7,043 customers, 21 fields) · **Source:** raw dataset, analyzed in BigQuery

---

## Executive summary

The business is losing **1,869 of 7,043 customers, a 26.5% churn rate**, and those customers carry **$1,669,570 in annual recurring revenue**. That figure is **30.5% of the company's entire $5.47M annual revenue base** walking out the door each year.

The loss is not evenly spread. It concentrates so tightly that it can be named in one sentence: new, month-to-month, fiber-optic customers who pay by electronic check. One segment alone, month-to-month plus fiber plus electronic check, is **1,307 customers churning at 60.4%**, and it accounts for **$819,378, or 49% of all at-risk revenue.**

Because the churn is concentrated, the fix can be too. Three levers (contract conversion, auto-pay enrollment, and first-year onboarding) target the exact customers bleeding revenue. This document shows the evidence for each and what to do about it.

---

## The situation

A 26.5% annual churn rate means roughly one in four customers leaves every year. For a subscription business, that is the single most expensive problem on the books, because every churned customer must be replaced through acquisition just to stay flat, before any growth.

The question this analysis answers is not "how much are we losing?" (that is the easy part) but "who exactly is leaving, and what do they have in common that we can act on?" The answer determines whether retention spend is scattered across 7,043 customers or aimed at the few thousand who actually drive the loss.

---

## Key findings: the four churn drivers

### 1. Contract type is the strongest predictor of churn

| Contract | Customers | Churn rate | Annual revenue at risk |
|---|---|---|---|
| **Month-to-month** | 3,875 | **42.7%** | **$1,450,165** |
| One year | 1,473 | 11.3% | $169,421 |
| Two year | 1,695 | 2.8% | $49,984 |

Month-to-month customers churn at **42.7%**, roughly **15 times the rate of two-year customers (2.8%).** They are only 55% of the customer base but produce **88.5% of all churned customers** and **86.9% of all at-risk revenue.** This is the master lever: the contract itself, more than any single service or demographic, decides whether a customer stays.

### 2. The first year is where customers are lost

| Tenure | Customers | Churn rate |
|---|---|---|
| **0 to 12 months** | 2,186 | **47.4%** |
| 13 to 24 months | 1,024 | 28.7% |
| 25 to 48 months | 1,594 | 20.4% |
| 49 to 72 months | 2,239 | 9.5% |

Nearly half of all first-year customers leave. Churn then falls steadily with tenure: a customer who reaches four-plus years churns at just 9.5%, a 5x improvement. The implication is clear. The retention battle is won or lost in the first 12 months, and customers who survive year one become the most loyal cohort on the books.

### 3. Fiber-optic customers churn most, a value-perception red flag

| Internet service | Customers | Churn rate |
|---|---|---|
| **Fiber optic** | 3,096 | **41.9%** |
| DSL | 2,421 | 19.0% |
| No internet | 1,526 | 7.4% |

The premium product has the worst retention. Fiber churns at more than double the DSL rate. When customers paying the most leave the fastest, it signals a price-to-value mismatch: expectations set by a premium tier that the experience (reliability, support, or price) is not meeting.

### 4. Electronic check is a churn signal in disguise

| Payment method | Customers | Churn rate |
|---|---|---|
| **Electronic check** | 2,365 | **45.3%** |
| Mailed check | 1,612 | 19.1% |
| Bank transfer (automatic) | 1,544 | 16.7% |
| Credit card (automatic) | 1,522 | 15.2% |

Electronic-check customers churn at **45.3%, roughly 3 times the rate of either automatic-payment method.** Auto-pay is not just a billing convenience; it is a retention mechanism. A customer on auto-pay has to make an active decision to leave, while a customer writing a check each month re-decides to stay every billing cycle.

---

## The bullseye: where the money actually is

Slicing all three high-risk traits together (the "money query") ranks every contract, internet, and payment combination by churn rate and revenue exposure:

| Segment | Customers | Churn rate | Annual revenue at risk |
|---|---|---|---|
| **Month-to-month, Fiber, Electronic check** | 1,307 | **60.4%** | **$819,378** |
| Month-to-month, Fiber, Mailed check | 201 | 50.7% | $100,887 |
| Month-to-month, Fiber, Bank transfer | 327 | 45.6% | $156,745 |
| Month-to-month, Fiber, Credit card | 293 | 41.6% | $128,774 |

The top segment alone, 1,307 customers churning at 60.4%, represents **$819,378, or 49% of all at-risk revenue.** Expand to all four month-to-month plus fiber segments and you capture roughly **$1.2M, about 72% of total at-risk revenue, inside about 2,100 customers.** The entire retention problem lives in under 30% of the customer base.

---

## Recommendations

Each recommendation targets a driver above, ordered by revenue impact. Impact figures are illustrative models based on the verified churn rates, meant to size the prize, not to forecast.

### 1. Convert month-to-month customers to annual contracts (largest lever)
Month-to-month churns at 42.7%, one year at 11.3%, two year at 2.8%. Moving a customer off month-to-month is the single highest-impact action available. Offer a targeted incentive (a discount, a bill credit, or a hardware perk) to convert month-to-month fiber customers to a 12-month term. Illustratively, converting just 10% of the 3,875 month-to-month customers to annual terms protects roughly $130K to $150K in annual revenue at the observed rate differential.

### 2. Drive auto-pay enrollment, starting with electronic-check customers
Electronic check churns at 45.3% versus about 15% to 17% for auto-pay. Run an enrollment campaign (a small one-time credit for switching to bank transfer or card auto-pay) aimed first at the 2,365 electronic-check customers. This is a low-cost, high-leverage move: it removes the monthly re-decision moment that drives churn.

### 3. Build a first-year onboarding and retention program
With 47.4% first-year churn, a structured onboarding sequence (proactive check-ins at 30, 60, and 90 days, early value reinforcement, and a first-anniversary retention offer) targets the cohort where nearly half of all loss occurs. Every customer moved past year one joins the 9.5%-churn loyal base.

### 4. Investigate the fiber value gap
Fiber's 41.9% churn on a premium product is a signal to diagnose, not just discount. Review fiber pricing, reliability, and support experience against customer expectations. If the premium tier is not delivering premium value, no retention offer will hold these customers long-term.

---

## What success looks like

The concentration of churn is the opportunity. Because 72% of at-risk revenue sits in about 2,100 identifiable customers, retention spend can be aimed with precision rather than sprayed across the base. A focused program hitting the month-to-month, fiber, electronic-check core (contract conversion first, auto-pay second, onboarding third) targets $1.2M of the $1.67M at risk with a known, named audience.

---

## Method note

All figures were produced in BigQuery from the raw IBM Telco Customer Churn dataset (7,043 rows). The one real data-quality issue (11 new customers with tenure of 0 whose `TotalCharges` imported as blank strings) was handled with `SAFE_CAST` plus `COALESCE`, and the analytical fields (`tenure_bucket`, `churn_flag`) were derived in SQL. Doing the cleaning and the metrics in SQL means every number here re-runs against the raw source and stays consistent across the SQL, the Excel layer, and the dashboard.

Churn rate is computed as `AVG(churn_flag)`, where `churn_flag` equals 1 for churned customers, a shortcut that turns a rate into a single aggregate. Revenue at risk equals churned customers' monthly charges times 12.
