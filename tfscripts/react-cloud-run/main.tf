provider "google" {
  version = "3.70.0"
  project = "${var.project_id}"
}

resource "google_cloud_run_service" "default" {
  name     = "cloudrun-opt-out"
  location = "${var.region}"

  template {
    spec {
      containers {
        image = "${var.docker_image}"
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
