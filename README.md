# Customer Retention and Cohort Analysis for a SaaS Product (RavenStack)
This project simulates real-world product analytics used by Product Managers to drive retention and engagement decisions.

# Project Overivew & Objective
This project analyzes customer retention, engagement, and cohort behavior for RavenStack, a fictional SaaS platform.
The objective is to understand:
- How users engage with the product over time
- What drives retention vs churn
- Whether users form consistent usage habits
- How retention varies across cohorts

This project combines SQL-based data analysis with product thinking to generate actionable business insights.

# Dataset
SaaS Subscription & Churn Analytics Dataset (Kaggle)

# Tools and Skills Used
- SQL (Bigquery)
- Data Analysis and Aggregations
- Cohort Analysis Techniques

# 📂 Project Structure
- retention_analysis.sql → Retention & Engagement Analysis
- cohort_analysis.sql → Cohort Retention Analysis

# Key Insights

# Retention Analysis
1. User acquisition is growing rapidly, but active users remain stable, indicating retention challenges.
2. Early-stage retention is low (~15–25%), highlighting weak user activation post-signup.
3. Retention patterns are non-linear, with users returning after inactivity → indicating sporadic (non-habitual) usage behavior.
4. Engagement metrics are similar for churned and retained users, suggesting retention depends on value perception, not just usage volume.
5. Feature usage is distributed across all features, with no clear “sticky” feature driving retention.
6. Beta features show slightly higher engagement, indicating potential opportunities for experimentation.
7. Retention is consistent across plan tiers, suggesting pricing is not the primary churn driver.
8. Trial users convert effectively, but sustaining long-term engagement remains a challenge.

# Cohort Analysis Insights
1. Retention does not follow a typical decay curve; instead, it fluctuates over time, indicating inconsistent usage habits.
2. Users often return after inactivity, suggesting the product is used on a need-based rather than habitual basis.
3. A significant number of users do not engage in the first month, highlighting onboarding gaps.
4. Larger cohorts show more stable but not improved retention, indicating growth without retention improvement.

# Recommendations
1. Improve user onboarding & activation to ensure users experience value early.
2. Build habit-forming mechanisms (notifications, reminders, workflows) to drive consistent engagement.
3. Identify and enhance high-impact features to improve product stickiness.
4. Expand experimentation (beta features) to drive innovation and engagement.
5. Implement targeted retention strategies to reduce early-stage drop-offs.


