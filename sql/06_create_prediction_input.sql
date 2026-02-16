CREATE OR REPLACE TABLE `churn-prediction-v1.ml.prediction_input` AS
SELECT
  user_id,
  events_30d,
  logins_30d,
  purchases_30d,
  active_days_30d
FROM `churn-prediction-v1.ml.user_features`;