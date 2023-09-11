## Prerequisites
Before loading the dateset from GCS into Parallelstore, please make sure you have Parallelstore CSI Driver installed, and correctly setup your platform resources following [this section](../../README.md).

## Load the dataset from GCS bucket into Parallelstore
```bash
# replace <bucket-name> with your pre-provisioned GCS bucket name
GCS_BUCKET_NAME=your-bucket-name
sed -i "s/<bucket-name>/$GCS_BUCKET_NAME/g" ./data-loader-job.yaml

# prepare the data
kubectl apply -f ./data-loader-job.yaml

# clean up
kubectl delete -f ./data-loader-job.yaml
```