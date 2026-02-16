-- Combine features and labels for training
CREATE OR REPLACE TABLE `churn-prediction-v1.ml.training_data` AS
SELECT
  f.user_id,
  f.events_30d,
  f.logins_30d,
  f.purchases_30d,
  f.active_days_30d,
  l.churned
FROM `churn-prediction-v1.ml.user_features` f
JOIN `churn-prediction-v1.ml.churn_labels` l
USING (user_id);