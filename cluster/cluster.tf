provider "google" {
    credentials = "${file(var.credentials_path)}"
    project = "${var.project_name}"
    region = "${var.cluster_region}"
}

resource "google_container_cluster" "production" {
    name = "${var.cluster_name}"
    location = "${var.cluster_region}"

    remove_default_node_pool = true

    initial_node_count = 1

    master_auth {
        username = "${var.cluster_username}"
        password = "${var.cluster_password}"
    }
}

resource "google_container_node_pool" "production_pool" {
    name = "${var.nodepool_name}"
    location = "${var.cluster_region}"
    cluster = "${google_container_cluster.production.name}"
    node_count = "${var.node_pool_count}"

    node_config {
        preemptible  = true
        machine_type = "n1-standard-1"
        disk_size_gb = "${var.node_disk_size}"

        metadata = {
        disable-legacy-endpoints = "true"
        }
        oauth_scopes = [
            "https://www.googleapis.com/auth/logging.write",
            "https://www.googleapis.com/auth/monitoring",
        ]
    }
}

output "cluster_certificate" {
    value = "${google_container_cluster.production.master_auth.0.client_certificate}"
}

output "cluster_client_key" {
  value = "${google_container_cluster.production.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.production.master_auth.0.cluster_ca_certificate}"
}
output "endpoint" {
  value = "${google_container_cluster.production.endpoint}"
}

terraform {
    backend "gcs" {
        credentials = "account.json"
        bucket = "naesheim-home-terraform"
        prefix = "cluster/state"
    }
}