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

# GKE cluster
resource "google_container_cluster" "ml_cluster" {
  name                     = var.cluster_name
  location                 = var.zone
  count                    = 1
  remove_default_node_pool = true
  initial_node_count       = 1

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
    managed_prometheus {
      enabled = "true"
    }
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  addons_config {
    gcs_fuse_csi_driver_config {
      enabled = var.enable_gcs_fuse_csi_driver
    }
    gcp_filestore_csi_driver_config {
      enabled = var.enable_gcp_filestore_csi_driver
    }
    gce_persistent_disk_csi_driver_config {
      enabled = var.enable_gce_persistent_disk_csi_driver
    }
  }

  release_channel {
    channel = "RAPID"
  }
}

resource "google_container_node_pool" "cpu_pool" {
  name       = "cpu-pool"
  location   = var.zone
  node_count = var.cpu_node_count
  count      = var.enable_cpu ? 1 : 0
  cluster    = google_container_cluster.ml_cluster[0].name

  autoscaling {
    min_node_count = var.cpu_min_node_count
    max_node_count = var.cpu_max_node_count
  }

  management {
    auto_repair  = var.cpu_auto_repair
    auto_upgrade = var.cpu_auto_upgrade
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
    ]

    labels = {
      env = var.project_id
    }
    image_type   = "cos_containerd"
    machine_type = var.cpu_machine_type
    tags         = ["gke-node", "${var.project_id}-gke"]

    disk_size_gb = var.cpu_disk_size_gb
    disk_type    = var.cpu_disk_type

    ephemeral_storage_local_ssd_config {
      local_ssd_count = var.cpu_ephemeral_storage_local_ssd_count
    }
    local_nvme_ssd_block_config {
      local_ssd_count = var.cpu_local_nvme_ssd_block_count
    }

    metadata = {
      disable-legacy-endpoints = "true"
    }
    workload_metadata_config {
      mode = var.workload_metadata_mode
    }
  }
}

resource "google_container_node_pool" "gpu_pool" {
  name       = "gpu-pool"
  location   = var.zone
  node_count = var.gpu_node_count
  count      = var.enable_gpu ? 1 : 0
  cluster    = var.enable_gpu ? google_container_cluster.ml_cluster[0].name : null

  autoscaling {
    min_node_count = var.gpu_min_node_count
    max_node_count = var.gpu_max_node_count
  }

  management {
    auto_repair  = var.gpu_auto_repair
    auto_upgrade = var.gpu_auto_upgrade
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
    ]

    labels = {
      env = var.project_id
    }

    guest_accelerator {
      type  = var.gpu_guest_accelerator_type
      count = var.gpu_guest_accelerator_count
    }

    image_type   = "cos_containerd"
    machine_type = var.gpu_machine_type
    tags         = ["gke-node", "${var.project_id}-gke"]

    disk_size_gb = var.gpu_disk_size_gb
    disk_type    = var.gpu_disk_type

    ephemeral_storage_local_ssd_config {
      local_ssd_count = var.gpu_ephemeral_storage_local_ssd_count
    }
    local_nvme_ssd_block_config {
      local_ssd_count = var.gpu_local_nvme_ssd_block_count
    }

    metadata = {
      disable-legacy-endpoints = "true"
    }
    workload_metadata_config {
      mode = var.workload_metadata_mode
    }
  }
}

resource "google_container_node_pool" "tpu_pool" {
  provider           = google-beta
  name               = "tpu-pool"
  location           = var.zone
  cluster            = var.enable_tpu ? google_container_cluster.ml_cluster[0].name : null
  initial_node_count = var.tpu_node_count
  count              = var.enable_tpu ? 1 : 0

  node_config {
    machine_type = var.tpu_machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
    ]

    labels = {
      env = var.project_id
    }

    ephemeral_storage_local_ssd_config {
      local_ssd_count = var.tpu_ephemeral_storage_local_ssd_count
    }
    local_nvme_ssd_block_config {
      local_ssd_count = var.tpu_local_nvme_ssd_block_count
    }

    workload_metadata_config {
      mode = var.workload_metadata_mode
    }
  }

  placement_policy {
    tpu_topology = var.tpu_placement_policy_tpu_topology
    type         = var.tpu_placement_policy_type
  }
}