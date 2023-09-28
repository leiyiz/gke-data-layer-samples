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
}

variable "region" {
  type        = string
  description = "GCP project region"
}

variable "zone" {
  type        = string
  description = "GCP project zone"
}

# GKE cluster configuration
variable "cluster_name" {
  type        = string
  description = "GKE cluster name"
}

variable "enable_gcs_fuse_csi_driver" {
  type        = bool
  description = "Set to true to enable GCSFuse CSI driver for the cluster"
}

variable "workload_metadata_mode" {
  type        = string
  description = "Metadata configuration to expose to workloads on the node pool"
}

variable "enable_gcp_filestore_csi_driver" {
  type        = bool
  description = "Set to true to enable Filestore CSI driver for the cluster"
}

variable "enable_gce_persistent_disk_csi_driver" {
  type        = bool
  description = "Set to true to enable Google Compute Engine Persistent Disk Container Storage Interface (CSI) Driver for the cluster"
}

# CPU node pool configuration
variable "enable_cpu" {
  type        = bool
  description = "Set to true to create CPU node pool"
}

variable "cpu_node_count" {
  type        = number
  description = "Number of CPU nodes in the cluster"
}

variable "cpu_min_node_count" {
  type        = number
  description = "Minimum number of nodes per zone in the CPU NodePool"
}

variable "cpu_max_node_count" {
  type        = number
  description = "Maximum number of nodes per zone in the CPU NodePool"
}

variable "cpu_auto_repair" {
  type        = bool
  description = "Whether the nodes will be automatically repaired in the CPU NodePool"
}

variable "cpu_auto_upgrade" {
  type        = bool
  description = "Whether the nodes will be automatically upgraded in the CPU NodePool"
}

variable "cpu_machine_type" {
  type        = string
  description = "The name of a Google Compute Engine machine type in the CPU NodePool"
}

variable "cpu_disk_size_gb" {
  type        = number
  description = "Size for node VM boot disks in GB in the CPU NodePool"
}

variable "cpu_disk_type" {
  type        = string
  description = "Type of the node VM boot disk in the CPU NodePool"
}

variable "cpu_ephemeral_storage_local_ssd_count" {
  type        = number
  description = "Number of local SSDs to use to back ephemeral storage in the CPU NodePool"
}

variable "cpu_local_nvme_ssd_block_count" {
  type        = number
  description = "Number of raw-block local NVMe SSD disks to be attached to each node in the CPU NodePool"
}

# GPU node pool configuration
variable "enable_gpu" {
  type        = bool
  description = "Set to true to create GPU node pool"
}

variable "gpu_node_count" {
  type        = number
  description = "Number of GPU nodes in the cluster"
}

variable "gpu_min_node_count" {
  type        = number
  description = "Minimum number of nodes per zone in the GPU NodePool"
}

variable "gpu_max_node_count" {
  type        = number
  description = "Maximum number of nodes per zone in the GPU NodePool"
}

variable "gpu_auto_repair" {
  type        = bool
  description = "Whether the nodes will be automatically repaired in the GPU NodePool"
}

variable "gpu_auto_upgrade" {
  type        = bool
  description = "Whether the nodes will be automatically upgraded in the GPU NodePool"
}

variable "gpu_machine_type" {
  type        = string
  description = "The name of a Google Compute Engine machine type in the GPU NodePool"
}

variable "gpu_guest_accelerator_type" {
  type        = string
  description = "The type of accelerator cards attached to the instance in the GPU NodePool"
}

variable "gpu_guest_accelerator_count" {
  type        = number
  description = "The number of the guest accelerator cards exposed to instances in the GPU NodePool"
}

variable "gpu_disk_size_gb" {
  type        = number
  description = "Size for node VM boot disks in GB in the GPU NodePool"
}

variable "gpu_disk_type" {
  type        = string
  description = "Type of the node VM boot disk in the GPU NodePool"
}

variable "gpu_ephemeral_storage_local_ssd_count" {
  type        = number
  description = "Number of local SSDs to use to back ephemeral storage in the GPU NodePool"
}

variable "gpu_local_nvme_ssd_block_count" {
  type        = number
  description = "Number of raw-block local NVMe SSD disks to be attached to each node in the GPU NodePool"
}

# TPU node pool configuration
variable "enable_tpu" {
  type        = bool
  description = "Set to true to create TPU node pool"
}

variable "tpu_node_count" {
  type        = number
  description = "Number of TPU nodes in the cluster"
}

variable "tpu_machine_type" {
  type        = string
  description = "The name of a Google Compute Engine machine type in the TPU NodePool"
}

variable "tpu_ephemeral_storage_local_ssd_count" {
  type        = number
  description = "Number of local SSDs to use to back ephemeral storage in the TPU NodePool"
}

variable "tpu_local_nvme_ssd_block_count" {
  type        = number
  description = "Number of raw-block local NVMe SSD disks to be attached to each node in the TPU NodePool"
}

variable "tpu_placement_policy_tpu_topology" {
  type        = string
  description = "The TPU placement topology for pod slice node pool"
}

variable "tpu_placement_policy_type" {
  type        = string
  description = "The type of the policy."
}