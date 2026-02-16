SELECT
  user_id,
  churn_probability,
  CASE
    WHEN churn_probability >= 0.9 THEN 'IMMEDIATE_OFFER'
    WHEN churn_probability >= 0.74 THEN 'EMAIL_NUDGE'
    ELSE 'MONITOR'
  END AS retention_action
FROM `churn-prediction-v1.analytics.churn_targets`;