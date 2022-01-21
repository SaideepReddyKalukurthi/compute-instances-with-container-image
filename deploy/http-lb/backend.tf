data "terraform_remote_state" "instance"{
    backend = "gcs"
    config = {
      bucket = "sai-demo-bucket-001"
      prefix = "managed-instances/state"
     }
}

terraform {
  backend "gcs" {
      bucket = "sai-demo-bucket-001"
      prefix = "http-lb/state"
  }
}



