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

data "google_client_config" "provider" {}

data "google_container_cluster" "ml_cluster" {
  name       = var.cluster_name
  location   = var.zone
  depends_on = [module.gke_standard]
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

provider "kubernetes" {
  host                   = data.google_container_cluster.ml_cluster.endpoint
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.ml_cluster.master_auth[0].cluster_ca_certificate
  )
}

provider "kubectl" {
  host                   = data.google_container_cluster.ml_cluster.endpoint
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.ml_cluster.master_auth[0].cluster_ca_certificate
  )
}

module "gke_standard" {
  source = "./modules/gke_standard"

  project_id   = var.project_id
  region       = var.region
  zone         = var.zone
  cluster_name = var.cluster_name

  # Storage configuration
  enable_gcs_fuse_csi_driver            = var.enable_gcs_fuse_csi_driver
  workload_metadata_mode                = var.enable_gcs_fuse_csi_driver ? "GKE_METADATA" : "MODE_UNSPECIFIED"
  enable_gcp_filestore_csi_driver       = var.enable_gcp_filestore_csi_driver
  enable_gce_persistent_disk_csi_driver = var.enable_gce_persistent_disk_csi_driver

  # CPU node pool configuration
  enable_cpu                            = var.enable_cpu
  cpu_node_count                        = var.cpu_node_count
  cpu_min_node_count                    = var.cpu_min_node_count
  cpu_max_node_count                    = var.cpu_max_node_count
  cpu_auto_repair                       = var.cpu_auto_repair
  cpu_auto_upgrade                      = var.cpu_auto_upgrade
  cpu_machine_type                      = var.cpu_machine_type
  cpu_disk_size_gb                      = var.cpu_disk_size_gb
  cpu_disk_type                         = var.cpu_disk_type
  cpu_ephemeral_storage_local_ssd_count = var.cpu_ephemeral_storage_local_ssd_count
  cpu_local_nvme_ssd_block_count        = var.cpu_local_nvme_ssd_block_count

  # GPU node pool configuration
  enable_gpu                            = var.enable_gpu
  gpu_node_count                        = var.gpu_node_count
  gpu_min_node_count                    = var.gpu_min_node_count
  gpu_max_node_count                    = var.gpu_max_node_count
  gpu_auto_repair                       = var.gpu_auto_repair
  gpu_auto_upgrade                      = var.gpu_auto_upgrade
  gpu_machine_type                      = var.gpu_machine_type
  gpu_guest_accelerator_type            = var.gpu_guest_accelerator_type
  gpu_guest_accelerator_count           = var.gpu_guest_accelerator_count
  gpu_disk_size_gb                      = var.gpu_disk_size_gb
  gpu_disk_type                         = var.gpu_disk_type
  gpu_ephemeral_storage_local_ssd_count = var.gpu_ephemeral_storage_local_ssd_count
  gpu_local_nvme_ssd_block_count        = var.gpu_local_nvme_ssd_block_count

  # TPU node pool configuration
  enable_tpu                            = var.enable_tpu
  tpu_node_count                        = var.tpu_node_count
  tpu_machine_type                      = var.tpu_machine_type
  tpu_ephemeral_storage_local_ssd_count = var.tpu_ephemeral_storage_local_ssd_count
  tpu_local_nvme_ssd_block_count        = var.tpu_local_nvme_ssd_block_count
  tpu_placement_policy_tpu_topology     = var.tpu_placement_policy_tpu_topology
  tpu_placement_policy_type             = var.tpu_placement_policy_type
}

module "kubernetes" {
  source = "./modules/kubernetes"

  depends_on = [module.gke_standard]
  enable_gpu = var.enable_gpu
  enable_tpu = var.enable_tpu
}