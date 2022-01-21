terraform {
  backend "gcs" {
      bucket = "sai-demo-bucket-001"
      prefix = "container-image/state"   
  }
}

