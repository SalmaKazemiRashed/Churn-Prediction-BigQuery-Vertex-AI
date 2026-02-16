CREATE OR REPLACE TABLE `churn-prediction-v1.analytics.customers` AS
WITH base AS (
  SELECT
    GENERATE_UUID() AS user_id,
    DATE_SUB(CURRENT_DATE(), INTERVAL CAST(RAND() * 180 AS INT64) DAY) AS signup_date,
    country,
    plan,
    channel AS acquisition_channel
  FROM UNNEST(GENERATE_ARRAY(1, 10000)) AS _
  CROSS JOIN UNNEST(["US","UK","DE","SE","CA"]) AS country
  CROSS JOIN UNNEST(["free","pro","enterprise"]) AS plan
  CROSS JOIN UNNEST(["organic","ads","referral"]) AS channel
)
SELECT *
FROM base
QUALIFY ROW_NUMBER() OVER () <= 10000;