# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

variable "namespace" {
  type        = string
  description = "Kubernetes namespace where resources are deployed"
  default     = "perf"
}

variable "project_id" {
  type        = string
  description = "GCP project id"
  default     = "<your project>"
}

variable "service_account" {
  type        = string
  description = "Google Cloud IAM service account for authenticating with GCP services"
  default     = "ml-perf-sa"
}

variable "k8s_service_account" {
  type        = string
  description = "Kubernetes service account name as in the Configure access to Cloud Storage buckets using GKE Workload Identity step"
  default     = "ml-perf-ksa"
}

variable "gcs_bucket" {
  type        = string
  description = "GCS Bucket name"
  default     = "<your gcs bucket>"
}



