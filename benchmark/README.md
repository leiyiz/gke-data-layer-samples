# Benchmark on GKE

This repository contains a Terraform template for running Machine Learning
benchmark workloads on Google Kubernetes Engine.

The solution is split into `platform` and `workloads` resources.

Platform resources (deployed once):

* GKE Cluster
* GKE Node Pool
* Nvidia GPU drivers

Workloads resources:

* User namespace
* Workload Identity for GCSFuse CSI driver
* Benchmark workload Deployment/Job Yamls

## Installation

Preinstall the following on your computer:

* Kubectl
* Terraform
* Gcloud

Note: Terraform keeps state metadata in a local file called `terraform.tfstate`.
If you need to reinstall any resources, make sure to delete this file as well.

### Platform

1. git clone https://github.com/saikat-royc/gke-data-layer-samples.git

2. `cd benchmark/platform`

3. Edit `variables.tf` with your GCP settings and the GKE cluster configurations
   you want to run your machine learning benchmark workload.
    1. Replace `project_id` with your own project
    2. Enable cpu/gpu/tpu node pool as needed
    3. Update other configurations for your test

   You can check `main.tf` to understand the high level structure
4. Run `terraform init`

5. Run `terraform apply`

6. Run `gcloud container clusters get-credentials <your cluster>`

7. To delete platform resources after your test, run `terraform destroy`

### Workloads

1. `cd benchmark/workloads`

2. If you enable the GCSFuse CSI Driver
    1. `cd user`
    2. Edit `variables.tf` with your own Namespace and Service Account settings

        1. Replace `project_id` with your own project
        2. Replace `gcs_bucket` with
           your own gcs bucket

   You can check `main.tf` to understand the high level structure
    3. Run `terraform init`

    4. Run `terraform apply`
    5. After you finish your test, run `terraform destory` to delete the
       resources
3. Return to the `workloads` directory and pick a benchmark tool you want to
   run. Each
   benchmark tool has its own instruction.
