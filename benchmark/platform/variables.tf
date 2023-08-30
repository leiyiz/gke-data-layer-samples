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

variable "project_id" {
  type        = string
  description = "GCP project id"
  default     = "<your project>"
}

variable "region" {
  type        = string
  description = "GCP project region"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "GCP project zone"
  default     = "us-central1-c"
}

variable "cluster_name" {
  type        = string
  description = "GKE cluster name"
  default     = "ml-perf-cluster"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace where resources are deployed"
  default     = "perf"
}

variable "enable_gcp_filestore_csi_driver" {
  type        = bool
  description = "Set to true to enable Filestore CSI driver for the cluster"
  default     = false
}

variable "enable_gce_persistent_disk_csi_driver" {
  type        = bool
  description = "Set to true to enable Google Compute Engine Persistent Disk Container Storage Interface (CSI) Driver for the cluster"
  default     = false
}

# GCSFuse CSI Driver Configuration
variable "enable_gcs_fuse_csi_driver" {
  type        = bool
  description = "Set to true to enable gcs fuse csi driver for the cluster"
  default     = false
}

variable "gcs_bucket" {
  type        = string
  description = "GCS Bucket name"
  default     = "<your gcs bucket>"
}

variable "workload_metadata_mode" {
  type        = string
  description = "Metadata configuration to expose to workloads on the node pool"
  default     = "MODE_UNSPECIFIED"
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

# CPU node pool configuration
variable "enable_cpu" {
  type        = bool
  description = "Set to true to create CPU node pool"
  default     = false
}

variable "cpu_node_count" {
  description = "Number of CPU nodes in the cluster"
  default     = 1
}

variable "cpu_min_node_count" {
  description = "Minimum number of nodes per zone in the CPU NodePool"
  default     = 1
}

variable "cpu_max_node_count" {
  description = "Maximum number of nodes per zone in the CPU NodePool"
  default     = 3
}

variable "cpu_auto_repair" {
  description = "Whether the nodes will be automatically repaired in the CPU NodePool"
  default     = true
}

variable "cpu_auto_upgrade" {
  description = "Whether the nodes will be automatically upgraded in the CPU NodePool"
  default     = true
}

variable "cpu_machine_type" {
  description = "The name of a Google Compute Engine machine type in the CPU NodePool"
  default     = "n1-standard-16"
}

variable "cpu_disk_size_gb" {
  description = "Size for node VM boot disks in GB in the CPU NodePool"
  default     = "100"
}

variable "cpu_disk_type" {
  description = "Type of the node VM boot disk in the CPU NodePool"
  default     = "pd-balanced"
}

variable "cpu_ephemeral_storage_local_ssd_count" {
  description = "Number of local SSDs to use to back ephemeral storage in the CPU NodePool"
  default     = "0"
}

variable "cpu_local_nvme_ssd_block_count" {
  description = "Number of raw-block local NVMe SSD disks to be attached to each node in the CPU NodePool"
  default     = "0"
}

# GPU node pool configuration
variable "enable_gpu" {
  type        = bool
  description = "Set to true to create GPU node pool"
  default     = false
}

variable "gpu_node_count" {
  description = "Number of GPU nodes in the cluster"
  default     = 1
}

variable "gpu_min_node_count" {
  description = "Minimum number of nodes per zone in the GPU NodePool"
  default     = 1
}

variable "gpu_max_node_count" {
  description = "Maximum number of nodes per zone in the GPU NodePool"
  default     = 3
}

variable "gpu_auto_repair" {
  description = "Whether the nodes will be automatically repaired in the GPU NodePool"
  default     = true
}

variable "gpu_auto_upgrade" {
  description = "Whether the nodes will be automatically upgraded in the GPU NodePool"
  default     = true
}

variable "gpu_machine_type" {
  description = "The name of a Google Compute Engine machine type in the GPU NodePool"
  default     = "n1-standard-16"
}

variable "gpu_guest_accelerator_type" {
  description = "The type of accelerator cards attached to the instance in the GPU NodePool"
  default     = "nvidia-tesla-t4"
}

variable "gpu_guest_accelerator_count" {
  description = "The number of the guest accelerator cards exposed to instances in the GPU NodePool"
  default     = "1"
}

variable "gpu_disk_size_gb" {
  description = "Size for node VM boot disks in GB in the GPU NodePool"
  default     = "100"
}

variable "gpu_disk_type" {
  description = "Type of the node VM boot disk in the GPU NodePool"
  default     = "pd-balanced"
}

variable "gpu_ephemeral_storage_local_ssd_count" {
  description = "Number of local SSDs to use to back ephemeral storage in the GPU NodePool"
  default     = "0"
}

variable "gpu_local_nvme_ssd_block_count" {
  description = "Number of raw-block local NVMe SSD disks to be attached to each node in the GPU NodePool"
  default     = "0"
}

# TPU node pool configuration
variable "enable_tpu" {
  type        = bool
  description = "Set to true to create TPU node pool"
  default     = false
}

variable "tpu_node_count" {
  description = "Number of TPU nodes in the cluster"
  default     = 1
}

variable "tpu_machine_type" {
  description = "The name of a Google Compute Engine machine type in the TPU NodePool"
  default     = "ct4p-hightpu-4t"
}

variable "tpu_ephemeral_storage_local_ssd_count" {
  description = "Number of local SSDs to use to back ephemeral storage in the TPU NodePool"
  default     = "0"
}

variable "tpu_local_nvme_ssd_block_count" {
  description = "Number of raw-block local NVMe SSD disks to be attached to each node in the TPU NodePool"
  default     = "0"
}

variable "tpu_placement_policy_tpu_topology" {
  description = "The TPU placement topology for pod slice node pool"
  default     = "2x2x1"
}

variable "tpu_placement_policy_type" {
  description = "The type of the policy."
  default     = "COMPACT"
}