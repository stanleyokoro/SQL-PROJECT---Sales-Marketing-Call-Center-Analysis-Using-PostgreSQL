
-- Create Table
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

-- Total Calls and Success Rate
SELECT 
    COUNT(*) AS total_calls,
    COUNT(*) FILTER (WHERE call_outcome = 'Success') AS successful_calls,
    ROUND(COUNT(*) FILTER (WHERE call_outcome = 'Success') * 100.0 / COUNT(*), 2) AS success_rate_pct
FROM call_center;

-- Top 5 Performing Agents
SELECT 
    agent_first_name || ' ' || agent_last_name AS agent_name,
    COUNT(*) FILTER (WHERE call_outcome = 'Success') AS successful_calls,
    COUNT(*) AS total_calls,
    ROUND(COUNT(*) FILTER (WHERE call_outcome = 'Success') * 100.0 / COUNT(*), 2) AS success_rate_pct
FROM call_center
GROUP BY agent_name
ORDER BY success_rate_pct DESC
LIMIT 5;

-- Product Conversion Rate
SELECT 
    product_discussed,
    COUNT(*) AS total_calls,
    COUNT(*) FILTER (WHERE call_outcome = 'Success') AS successful_calls,
    ROUND(COUNT(*) FILTER (WHERE call_outcome = 'Success') * 100.0 / COUNT(*), 2) AS success_rate_pct
FROM call_center
GROUP BY product_discussed
ORDER BY success_rate_pct DESC;

-- Average Call Duration by Outcome
SELECT 
    call_outcome,
    ROUND(AVG(call_duration_minutes), 2) AS avg_duration
FROM call_center
GROUP BY call_outcome;

-- Repeat Customers Success Rate
SELECT 
    repeat_customer,
    COUNT(*) FILTER (WHERE call_outcome = 'Success') AS successful_calls,
    COUNT(*) AS total_calls,
    ROUND(COUNT(*) FILTER (WHERE call_outcome = 'Success') * 100.0 / COUNT(*), 2) AS success_rate_pct
FROM call_center
GROUP BY repeat_customer;

-- Gender-Based Performance
SELECT 
    customer_gender,
    COUNT(*) AS total_calls,
    COUNT(*) FILTER (WHERE call_outcome = 'Success') AS successful_calls,
    ROUND(COUNT(*) FILTER (WHERE call_outcome = 'Success') * 100.0 / COUNT(*), 2) AS success_rate_pct
FROM call_center
GROUP BY customer_gender;

-- Abandonment Reasons
SELECT 
    reason_call_abandoned,
    COUNT(*) AS occurrences
FROM call_center
WHERE reason_call_abandoned IS NOT NULL
GROUP BY reason_call_abandoned
ORDER BY occurrences DESC
LIMIT 5;
