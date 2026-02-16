CREATE OR REPLACE TABLE `churn-prediction-v1.analytics.churn_targets` AS
SELECT
  c.user_id,
  c.plan,
  c.country,
  c.acquisition_channel,
  s.churn_probability
FROM `churn-prediction-v1.ml.churn_scored_users` s
JOIN `churn-prediction-v1.analytics.customers` c
USING (user_id);