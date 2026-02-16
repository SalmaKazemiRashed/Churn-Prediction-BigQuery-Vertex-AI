-- Feature engineering
CREATE OR REPLACE TABLE `churn-prediction-v1.ml.user_features` AS
SELECT
  user_id,
  COUNT(*) AS events_30d,
  COUNTIF(event_name = "login") AS logins_30d,
  COUNTIF(event_name = "purchase") AS purchases_30d,
  COUNT(DISTINCT DATE(event_time)) AS active_days_30d
FROM `churn-prediction-v1.analytics.events`
WHERE event_time >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 30 DAY)
GROUP BY user_id;