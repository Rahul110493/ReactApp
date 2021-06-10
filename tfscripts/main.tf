terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
    helm = "~> 0.10"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

data "google_client_config" "default" {
}

data "google_container_cluster" "default" {
  name = var.cls_name
}

provider "helm" {
  kubernetes {
    token                  = data.google_client_config.default.access_token
    host                   = data.google_container_cluster.default.endpoint
    cluster_ca_certificate = base64decode(data.google_container_cluster.default.master_auth[0].cluster_ca_certificate)
  }
}

resource "helm_release" "example" {
  name  = var.chart_name
  chart = "./helm/var.chart_name"

  set {
    name  = "image.repository"
    value = var.docker_repo
  }

  set {
    name  = "image.tag"
    value = var.docker_tag
  }
}

resource "google_container_cluster" "primary" {

  name                     = var.cls_name
  location                 = var.cls_location_id
  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = var.initial_node_count
  network                  = google_compute_network.vpc.name
  subnetwork               = google_compute_subnetwork.subnet.name
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.container_node_pool_name
  location   = var.container_node_pool_name_location_id
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count


  node_config {

    preemptible  = var.preemptible
    machine_type = var.machine_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

