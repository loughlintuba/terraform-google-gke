data "google_container_engine_versions" "cluster_version" {
  location       = var.google_region
  version_prefix = var.cluster_version
  project        = var.google_project_id
}

output "cluster_version" {
  value = data.google_container_engine_versions.cluster_version.latest_node_version
}

resource "google_service_account" "service_accounts" {
  account_id   = var.account_id
  display_name = var.display_name
  project      = var.google_project_id 
}

resource "google_container_cluster" "primary" {
  provider                 = google-beta
  min_master_version       = data.google_container_engine_versions.cluster_version.latest_node_version
  node_version             = data.google_container_engine_versions.cluster_version.latest_node_version
  name                     = var.cluster_name
  location                 = var.google_region
  project                  = var.google_project_id
  network                  = var.cluster_network
  subnetwork               = var.subnetwork
  remove_default_node_pool = true
  initial_node_count       = 1

}


resource "google_container_node_pool" "primary_preemptible_nodes" {
    name               = "my-node-pool"
    node_count         = var.cluster_node_count
    cluster            = google_container_cluster.primary.name
    provider           = google-beta

    management {
      auto_repair  = var.auto_repair
      auto_upgrade = var.auto_upgrade
    }

    autoscaling {
      min_node_count = var.min_desired_count
      max_node_count = var.max_desired_count
    }

    node_config {
      image_type   = var.image_type
      disk_size_gb = var.disk_size_in_gb
      preemptible  = var.preemptible_nodes
      machine_type = var.machine_type
      labels       = var.labels
      service_account = google_service_account.service_accounts.email
      oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/source.read_write"
    ]

      metadata = {
        ssh-keys                 = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
        disable-legacy-endpoints = true
      }
    } 
}
