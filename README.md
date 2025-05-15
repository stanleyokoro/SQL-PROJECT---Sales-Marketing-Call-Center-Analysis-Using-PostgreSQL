
# 📊 Sales & Marketing Call Center Analysis Using PostgreSQL

## 🧾 Project Overview

This project analyzes **200,000 customer service call records** from a fictional sales and marketing call center. It aims to uncover actionable insights on agent performance, customer behavior, product success, and operational bottlenecks using advanced SQL queries.

## 📂 Dataset Details

The dataset includes:
- Call IDs and timestamps
- Agent names and ratings
- Call outcomes and durations
- Customer demographics (age, gender, income)
- Products discussed
- Operational metrics (follow-ups, repeat customers, time of day)

## 🛠️ Tools Used

- **SQL Language**: PostgreSQL
- **Environment**: pgAdmin / DBeaver
- **Optional Visualization**: Power BI / Tableau

## 🧱 Table Schema

```sql
CREATE TABLE call_center (
    call_id TEXT PRIMARY KEY,
    date DATE,
    agent_first_name TEXT,
    agent_last_name TEXT,
    agent_rating NUMERIC(2,1),
    product_discussed TEXT,
    call_duration_minutes NUMERIC(5,2),
    call_outcome TEXT,
    customer_age INT,
    customer_gender TEXT,
    state TEXT,
    customer_income_bracket TEXT,
    time_of_day TEXT,
    follow_up_call_required TEXT,
    repeat_customer TEXT,
    reason_call_abandoned TEXT
);
```

---

## 🔍 Key Analyses & Insights

### 1. Total Calls and Success Rate
```sql
SELECT 
    COUNT(*) AS total_calls,
    COUNT(*) FILTER (WHERE call_outcome = 'Success') AS successful_calls,
    ROUND(COUNT(*) FILTER (WHERE call_outcome = 'Success') * 100.0 / COUNT(*), 2) AS success_rate_pct
FROM call_center;
```
- **Result**: 41.79% of calls are successful

### 2. Top 5 Performing Agents by Success Rate
```sql
SELECT 
    agent_first_name || ' ' || agent_last_name AS agent_name,
    COUNT(*) FILTER (WHERE call_outcome = 'Success') AS successful_calls,
    COUNT(*) AS total_calls,
    ROUND(COUNT(*) FILTER (WHERE call_outcome = 'Success') * 100.0 / COUNT(*), 2) AS success_rate_pct
FROM call_center
GROUP BY agent_name
ORDER BY success_rate_pct DESC
LIMIT 5;
```

### 3. Product Conversion Rate
```sql
SELECT 
    product_discussed,
    COUNT(*) AS total_calls,
    COUNT(*) FILTER (WHERE call_outcome = 'Success') AS successful_calls,
    ROUND(COUNT(*) FILTER (WHERE call_outcome = 'Success') * 100.0 / COUNT(*), 2) AS success_rate_pct
FROM call_center
GROUP BY product_discussed
ORDER BY success_rate_pct DESC;
```

### 4. Average Call Duration by Outcome
```sql
SELECT 
    call_outcome,
    ROUND(AVG(call_duration_minutes), 2) AS avg_duration
FROM call_center
GROUP BY call_outcome;
```

### 5. Success Rate by Repeat Customers
```sql
SELECT 
    repeat_customer,
    COUNT(*) FILTER (WHERE call_outcome = 'Success') AS successful_calls,
    COUNT(*) AS total_calls,
    ROUND(COUNT(*) FILTER (WHERE call_outcome = 'Success') * 100.0 / COUNT(*), 2) AS success_rate_pct
FROM call_center
GROUP BY repeat_customer;
```

### 6. Gender-Based Performance
```sql
SELECT 
    customer_gender,
    COUNT(*) AS total_calls,
    COUNT(*) FILTER (WHERE call_outcome = 'Success') AS successful_calls,
    ROUND(COUNT(*) FILTER (WHERE call_outcome = 'Success') * 100.0 / COUNT(*), 2) AS success_rate_pct
FROM call_center
GROUP BY customer_gender;
```

### 7. Top Abandonment Reasons
```sql
SELECT 
    reason_call_abandoned,
    COUNT(*) AS occurrences
FROM call_center
WHERE reason_call_abandoned IS NOT NULL
GROUP BY reason_call_abandoned
ORDER BY occurrences DESC
LIMIT 5;
```

---

## 📌 Summary of Insights

| Category               | Insight |
|------------------------|---------|
| Call Center Performance| 41.79% success rate |
| Agent Effectiveness    | Top agents >90% success |
| Product Insights       | Travel & Loan products lead |
| Time Factor            | Longer calls yield better success |
| Customer Behavior      | Repeat customers slightly more successful |
| Gender Demographics    | Females slightly more receptive |
| Operational Gaps       | Tech issues & wait times hurt performance |

## 🚀 Business Applications

- Build KPI dashboards for live monitoring
- Design targeted campaigns by customer segments
- Train agents based on best practices from top performers
- Improve system performance and reduce technical failures

## 📫 Contact

Made by **Stanley Chinor Okoro**  
📧 stanley.chinor@gmail.com  
🔗 [GitHub](https://github.com/timelesshov) • [LinkedIn](https://www.linkedin.com/in/timelesshov)
