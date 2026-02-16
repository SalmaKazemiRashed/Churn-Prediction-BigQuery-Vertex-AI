-- Create churn labels
CREATE OR REPLACE TABLE `churn-prediction-v1.ml.churn_labels` AS
WITH last_activity AS (
  SELECT
    user_id,
    MAX(event_time) AS last_event_time
  FROM `churn-prediction-v1.analytics.events`
  GROUP BY user_id
)
SELECT
  user_id,
  IF(
    DATE_DIFF(CURRENT_DATE(), DATE(last_event_time), DAY) >= 14,
    1,
    0
  ) AS churned
FROM last_activity;