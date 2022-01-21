variable "project_id" {
    type = string
    description = "(optional) describe your variable"
}

variable "image_port" {
  description = "The port the image exposes for HTTP requests"
  type        = number
  default     = 8080
}

variable "network" {
  description = "The GCP network"
  type        = string
  default     = "default"
}
