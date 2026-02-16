from google.cloud import aiplatform
import sys

PROJECT_ID = "churn-prediction-v1"
REGION = "us-central1"

print("Starting Vertex AI AutoML training script", flush=True)

try:
    aiplatform.init(project=PROJECT_ID, location=REGION)
    print("Vertex AI initialized", flush=True)

    print("Creating / loading BigQuery dataset reference", flush=True)
    dataset = aiplatform.TabularDataset.create(
        display_name="churn_training_data",
        bq_source=f"bq://{PROJECT_ID}.ml.training_data",
    )

    print(f" Dataset ready: {dataset.resource_name}", flush=True)

    job = aiplatform.AutoMLTabularTrainingJob(
        display_name="churn_model",
        optimization_prediction_type="classification",
        optimization_objective="minimize-log-loss",
    )

    print("Starting AutoML training job...", flush=True)

    model = job.run(
        dataset=dataset,
        target_column="churned",
        training_fraction_split=0.8,
        validation_fraction_split=0.1,
        test_fraction_split=0.1,
        sync=False,  # VERY IMPORTANT: don't block silently
    )

    print("Training job submitted successfully!", flush=True)
    print(" Check progress in Vertex AI → Training", flush=True)

except Exception as e:
    print(" ERROR:", e, flush=True)
    sys.exit(1)