# Benchmark on GKE

This repository contains a Terraform template for running Machine Learning benchmark workload on Google Kubernetes Engine.

The solution is split into `platform` and `workload` resources. 

Platform resources (deployed once):
* GKE Cluster
* GKE Node Pool
* Nvidia GPU drivers
* User namespace
* Workload Identity for GCSFuse CSI driver

Workload resources (deployed once per workload):
TBD


## Installation

Preinstall the following on your computer:
* Kubectl
* Terraform 
* Helm
* Gcloud

Note: Terraform keeps state metadata in a local file called `terraform.tfstate`.
If you need to reinstall any resources, make sure to delete this file as well.

### Platform

1. git clone https://github.com/saikat-royc/gke-data-layer-samples.git

2. `cd benchmark/platform`

3. Edit `variables.tf` with your GCP settings and the GKE cluster configurations 
you want to run your machine learning benchmark workload.

4. Run `terraform init`

5. Run `terraform apply`

6. To delete platform resources after your test, run `terraform destroy` 

### Workload

TBD


