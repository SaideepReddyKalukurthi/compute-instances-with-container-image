data "google_compute_zones" "available" {
  project = var.project_id
  region  = var.region
}
data "terraform_remote_state" "image"{
    backend = "gcs"
    config = {
      bucket = "sai-demo-bucket-001"
      prefix = "container-image/state"
     }
}


terraform {
  backend "gcs" {
      bucket = "sai-demo-bucket-001"
      prefix = "managed-instances/state"   
  }
}

