provider "google" {
  version = "3.5.0"
  project = "${var.project_id}"
  region  = "${var.region}"
  zone = "${var.zone}"
}

resource "google_container_cluster" "primary" {
 
  name  = "${var.cls_name}"
  location = "${var.cls_location_id}"

  remove_default_node_pool = "${var.remove_default_node_pool}"
  initial_node_count    = "${var.initial_node_count}"
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name  =  "${var.container_node_pool_name}"
  location = "${var.container_node_pool_name_location_id}"
  cluster    = google_container_cluster.primary.name
  node_count = "${var.node_count}"
  
  
node_config {

    preemptible  = "${var.preemptible}"  
    machine_type = "${var.machine_type}"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

