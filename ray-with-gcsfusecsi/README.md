# Deploys kuberay operator, ray cluster of head and worker nodes, and a jupyternotebook pod

1. cd platform; terraform apply
2. gcloud container clusters get-credentials <cluster-name> --zone=<gcp-zone>
3. cd user; terraform apply