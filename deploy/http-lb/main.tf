provider "google" {
  project = var.project_id
}
locals {
  google_load_balancer_ip_ranges = [
    "130.211.0.0/22",
    "35.191.0.0/16",
  ]
}


# module "http-lb" {
#   source            = "github.com/GoogleCloudPlatform/terraform-google-lb-http"
#   project           = var.project_id
#   name              = "sai-lb"
#   firewall_networks = []
#   target_tags       = [data.terraform_remote_state.instance.outputs.tags] 

#   backends = {
#     "0" = [
#       {
#         group = data.terraform_remote_state.instance.outputs.mig-group
#       },
#     ]
#   }

#   # backend_params = [
#   #   "/,http,${var.image_port},30",
#   # ]
# }


resource "google_compute_firewall" "lb-to-instances" {
  name    = "sai-firewall-lb-to-instances"
  project = var.project_id
  network = var.network

  allow {
    protocol = "tcp"
    ports    = [var.image_port]
  }

  # source_ranges = [local.google_load_balancer_ip_ranges]
  target_tags   = data.terraform_remote_state.instance.outputs.tags
}

module "gce-lb-http" {
  source            = "GoogleCloudPlatform/lb-http/google"
  version           = "~> 4.4"

  project           = var.project_id
  name              = "group-http-lb"
  target_tags       = data.terraform_remote_state.instance.outputs.tags
  backends = {
    default = {
      description                     = null
      protocol                        = "HTTP"
      port                            = 80
      port_name                       = "reddy"
      timeout_sec                     = 10
      enable_cdn                      = false
      custom_request_headers          = null
      custom_response_headers         = null
      security_policy                 = null

      connection_draining_timeout_sec = null
      session_affinity                = null
      affinity_cookie_ttl_sec         = null

      health_check = {
        check_interval_sec  = null
        timeout_sec         = null
        healthy_threshold   = null
        unhealthy_threshold = null
        request_path        = "/"
        port                = 80
        host                = null
        logging             = null
      }

      log_config = {
        enable = true
        sample_rate = 1.0
      }

      groups = [
        {
          # Each node pool instance group should be added to the backend.
          group                        = data.terraform_remote_state.instance.outputs.mig-group
          balancing_mode               = null
          capacity_scaler              = null
          description                  = null
          max_connections              = null
          max_connections_per_instance = null
          max_connections_per_endpoint = null
          max_rate                     = null
          max_rate_per_instance        = null
          max_rate_per_endpoint        = null
          max_utilization              = null
        },
      ]

      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
    }
  }
}