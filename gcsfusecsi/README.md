# Deploys a sample pod with gcsfusecsi mounted volume

1. cd platform; terraform apply
2. gcloud container clusters get-credentials ${cluster-name} --zone=${gcp-zone}
3. cd user; terraform apply