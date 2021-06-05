terraform {
  required_providers {
    google = {
      source = "hashicorp/google-beta"
      version = "3.8.0"
    }
  }
}
provider "google" {
  project = "${var.project_id}"
  region  = "${var.region}"
}

resource "google_cloud_run_service" "default" {
  name     = "cloudrun-opt-out"
  location = "${var.region}"

  template {
    spec {
      containers {
        image = "${var.docker_image}"
        ports {
          container_port = 80
         }
      }
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.default.location
  project     = google_cloud_run_service.default.project
  service     = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
