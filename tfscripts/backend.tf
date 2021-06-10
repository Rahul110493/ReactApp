terraform {
  backend "gcs" {
    bucket = "terraform1-state-101"
    prefix = "test"
  }
}
