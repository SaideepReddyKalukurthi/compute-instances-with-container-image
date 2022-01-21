
variable "project_id" {
  description = "The project ID to deploy resource into"
  type        = string
}

variable "subnetwork" {
  description = "The name of the subnetwork to deploy instances into"
  type        = string
  default     = "default"
}

variable "mig_name" {
  description = "The desired name to assign to the deployed managed instance group"
  type        = string
  default     = "mig-test"
}

variable "mig_instance_count" {
  description = "The number of instances to place in the managed instance group"
  type        = string
  default     = "3"
}

variable "image" {
  description = "The Docker image to deploy to GCE instances"
  type        = string
  default     = "gcr.io/google-samples/hello-app:2.0"
}

variable "image_port" {
  description = "The port the image exposes for HTTP requests"
  type        = number
  default     = 8080
}

variable "region" {
  description = "The GCP region to deploy instances into"
  type        = string
  default     = "us-east4"
}

variable "zone" {
  description = "The GCP zone to deploy instances into"
  type        = string
  default     = "us-east4-b"
}

variable "network" {
  description = "The GCP network"
  type        = string
  default     = "default"
}

variable "additional_metadata" {
  type        = map
  description = "Additional metadata to attach to the instance"
  default     = {}
}

variable "service_account" {
  type = object({
    email  = string,
    scopes = list(string)
  })
  default = {
    email  = ""
    scopes = ["cloud-platform"]
  }
}