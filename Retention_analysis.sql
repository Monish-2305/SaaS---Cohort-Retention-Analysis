--Retention Analysis

--1. How many Active users do we have over Time (MAU Trend)
SELECT 
 DATE_TRUNC(usage_date, MONTH) AS Month,
 COUNT(DISTINCT subscription_id) AS Active_users
FROM ravenstack_feature_usage
GROUP BY Month, 
ORDER BY Month

--2. How many New users joined each month? (Signup Trend)
SELECT 
 DATE_TRUNC(start_date, MONTH) AS signup_month,
 COUNT(DISTINCT subscription_id) AS New_users
FROM ravenstack_subscriptions
GROUP BY Month, 
ORDER BY Month

--3. What is the Overall Retention Vs Churn Split?
SELECT
 churn_flag,
COUNT(*) AS Total_subscriptions
ROUND(COUNT(*)*100 / SUM(COUNT(*)) OVER(), 2) AS Percentage
FROM  ravenstack_feature_usage
GROUP BY churn_flag

--4. Do Retained Users Use the Product More Than Churned Users?
SELECT 
  s.churn_flag,
  AVG(f.usage_count) AS avg_usage,
  AVG(f.usage_duration_secs) AS avg_duration
FROM ravenstack_feature_usage f
JOIN ravenstack_subscriptions s 
  ON f.subscription_id = s.subscription_id
GROUP BY s.churn_flag;

--5. What is the Average Usage Frequency per User?
SELECT
 subscription_id
COUNT(DISTINCT usage_date) as Active_days
FROM ravenstack_subscriptions
GROUP BY subscription_id

--6. Which Features are most used overall
SELECT 
  feature_name,
  SUM(usage_count) AS total_usage
FROM ravenstack_feature_usage
GROUP BY feature_name
ORDER BY total_usage DESC;

--7. Which Features Are Used More by Retained vs Churned Users?
SELECT 
  f.feature_name,
  s.churn_flag,
  SUM(f.usage_count) AS total_usage
FROM ravenstack_feature_usage f
JOIN ravenstack_subscriptions s
  ON f.subscription_id = s.subscription_id
GROUP BY f.feature_name, s.churn_flag
ORDER BY f.feature_name;

--8. Do Beta Features Improve Engagement?
SELECT
  is_beta_feature,
  AVG(usage_count) as usage_days
  AVG(usage_duration_secs) as avg_duration_secs
FROM ravenstack_feature_usage
GROUP BY is_beta_feature;

--9. Which Plan Tiers Have Better Retention?
SELECT
  plan_tier,
  churn_flag,
  COUNT(*) as total_users
FROM ravenstack_subscriptions
GROUP BY plan tier, churn_flag
ORDER BY plan_tier;

--10. Do trial users convert to Retain users?
SELECT 
  is_trial,
  churn_flag,
  COUNT(*) AS total_users
FROM ravenstack_subscriptions
GROUP BY is_trial, churn_flag;

--11. Does Usage Drop Before Churn?
SELECT 
  s.subscription_id,
  s.churn_flag,
  AVG(f.usage_count) AS avg_usage
FROM ravenstack_subscriptions s
LEFT JOIN ravenstack_feature_usage f
  ON s.subscription_id = f.subscription_id
GROUP BY s.subscription_id, s.churn_flag;

--12. Who Are High Retention (Highly Engaged) Users?
SELECT 
  subscription_id,
  COUNT(DISTINCT usage_date) AS active_days
FROM ravenstack_feature_usage
GROUP BY subscription_id
HAVING COUNT(DISTINCT usage_date) > 10;
