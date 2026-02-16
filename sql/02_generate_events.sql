-- Generate synthetic events
CREATE OR REPLACE TABLE `churn-prediction-v1.analytics.events` AS
SELECT
  c.user_id,
  event_name,
  TIMESTAMP_ADD(
    TIMESTAMP(c.signup_date),
    INTERVAL CAST(RAND() * 120 AS INT64) DAY
  ) AS event_time,
  platform
FROM `churn-prediction-v1.analytics.customers` c
JOIN UNNEST(
  IF(
    RAND() < 0.35,
    ["signup","login"],
    ["signup","login","feature_use","purchase"]
  )
) AS event_name
CROSS JOIN UNNEST(["web","ios","android"]) AS platform;