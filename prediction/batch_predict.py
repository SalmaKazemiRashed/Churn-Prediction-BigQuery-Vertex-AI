from google.cloud import aiplatform

PROJECT_ID = "churn-prediction-v1"   # BigQuery
PROJECT_NUMBER = PROJECT_NUMBER  #e.g., "838193578764"      # Vertex
REGION = "us-central1"
MODEL_ID = MODEL_ID #e.g.,"1962882242766176256"

aiplatform.init(project=PROJECT_ID, location=REGION)

model = aiplatform.Model(
    model_name=f"projects/{PROJECT_NUMBER}/locations/{REGION}/models/{MODEL_ID}"
)

job = model.batch_predict(
    job_display_name="churn_batch_prediction",
    bigquery_source="bq://churn-prediction-v1.ml.prediction_input",
    bigquery_destination_prefix="bq://churn-prediction-v1.ml",
    instances_format="bigquery",
    predictions_format="bigquery"
)

job.wait()
print("Batch prediction completed")