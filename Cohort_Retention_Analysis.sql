--Cohort Retention Analysis

--1. How many users from each signup cohort remain active over time?
SELECT 
  DATE_TRUNC(s.start_date, MONTH) AS cohort_month,
  DATE_TRUNC(f.usage_date, MONTH) AS activity_month,
  COUNT(DISTINCT s.subscription_id) AS active_users
FROM ravenstack_subscriptions s
JOIN ravenstack_feature_usage f
  ON s.subscription_id = f.subscription_id
GROUP BY cohort_month, activity_month
ORDER BY cohort_month, activity_month;

--2. After how many months are users still active?
SELECT 
  DATE_TRUNC(s.start_date, MONTH) AS cohort_month,
  DATE_DIFF(DATE_TRUNC(f.usage_date, MONTH), DATE_TRUNC(s.start_date, MONTH), MONTH) AS months_since_signup,
  COUNT(DISTINCT s.subscription_id) AS active_users
FROM ravenstack_subscriptions s
JOIN ravenstack_feature_usage f
  ON s.subscription_id = f.subscription_id
GROUP BY cohort_month, months_since_signup
ORDER BY cohort_month, months_since_signup;

--3. What % of users are retained over time?
WITH monthly_usage AS (
  SELECT DISTINCT
    subscription_id,
    DATE_TRUNC(usage_date, MONTH) AS usage_month
  FROM Ravenstack_featureusage
),

cohort_data AS (
  SELECT 
    DATE_TRUNC(s.start_date, MONTH) AS cohort_month,
    DATE_DIFF(f.usage_month, DATE_TRUNC(s.start_date, MONTH), MONTH) AS months_since_signup,
    COUNT(DISTINCT s.subscription_id) AS active_users
  FROM Ravenstack_subscriptions s
  JOIN monthly_usage f
    ON s.subscription_id = f.subscription_id
  WHERE f.usage_month >= DATE_TRUNC(s.start_date, MONTH)
  GROUP BY cohort_month, months_since_signup
),

cohort_size AS (
  SELECT
    DATE_TRUNC(start_date, MONTH) AS cohort_month,
    COUNT(DISTINCT subscription_id) AS cohort_users
  FROM Ravenstack_subscriptions
  GROUP BY cohort_month
)

SELECT 
  c.cohort_month,
  c.months_since_signup,
  c.active_users,
  cs.cohort_users,
  ROUND(c.active_users * 100.0 / cs.cohort_users, 2) AS retention_rate
FROM cohort_data c
JOIN cohort_size cs
  ON c.cohort_month = cs.cohort_month
ORDER BY c.cohort_month, c.months_since_signup;
