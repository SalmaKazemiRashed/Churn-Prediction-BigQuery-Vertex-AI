CREATE OR REPLACE TABLE `churn-prediction-v1.ml.churn_scored_users` AS
SELECT
  user_id,
  predicted_churned.scores[OFFSET(1)] AS churn_probability
FROM `churn-prediction-v1.ml.predictions_2026_02_13T11_19_54_418Z_834`
WHERE predicted_churned.scores[OFFSET(1)] >= 0.7;