terraform {
  backend "gcs"{
    bucket = "devbucket11"
    prefix = "test"
  }
}
