variable "project_id" {
  description = "The project ID to deploy resources into"
  type = string
}

# variable "subnetwork_project" {
#   description = "The project ID where the desired subnetwork is provisioned"
# }

variable "subnetwork" {
  description = "The name of the subnetwork to deploy instances into"
  default = "default"
}

variable "instance_name" {
  description = "The desired name to assign to the deployed instance"
  default     = "hello-world-container-vm"
  type = string
}

variable "region" {
  description = "The GCP region to deploy instances into"
  type = string
}

variable "zone" {
  type = string
}