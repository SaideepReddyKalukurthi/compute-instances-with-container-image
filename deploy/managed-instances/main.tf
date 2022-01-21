provider "google" {
    project = var.project_id  
    region = var.region
}


module "mig1_template" {
  source     = "../../modules/compute/instance-template"
  project_id = var.project_id
  network    = var.network
  subnetwork = var.subnetwork
  service_account = {
    email  = ""
    scopes = ["cloud-platform"]
  }
  name_prefix          = "ias"
  source_image_family  = "cos-stable"
  source_image_project = "cos-cloud"
  tags = [
    "container-vm-test-mig"
  ]
   source_image         = reverse(split("/", data.terraform_remote_state.image.outputs.container_image))[0]
    labels = {
    "container-vm" = data.terraform_remote_state.image.outputs.labels
  }
  
}


module "mig1" {
  source            = "../../modules/compute/managed-instance-group"
  instance_template = module.mig1_template.self_link
  project_id        = var.project_id
  region            = var.region
  hostname          = "sai"
  target_size       = 2
  named_ports = [{
    name = "http",
    port = var.image_port
  }]
  network    = "default"
  subnetwork = "default"
}


