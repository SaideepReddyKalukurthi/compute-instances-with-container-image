output "project_id" {
  description = "The project ID resources were deployed into"
  value       = var.project_id
}

# output "vm_container_label" {
#   description = "The instance label containing container configuration"
#   value       = module.gce-container.vm_container_label
# }

# output "container" {
#   description = "The container metadata provided to the module"
#   value       = module.gce-container.container
# }

# output "volumes" {
#   description = "The volume metadata provided to the module"
#   value       = module.gce-container.volumes
# }

# output "http_address" {
#   description = "The IP address on which the HTTP service is exposed"
#   value       = module.http-lb.external_ip
# }

output "http_port" {
  description = "The port on which the HTTP service is exposed"
  value       = "80"
}

output "region" {
  description = "The region the GCE instance was deployed into"
  value       = var.region
}

output "zone" {
  description = "The zone the GCE instance was deployed into"
  value       = var.zone
}

output "mig-group" {
  value = module.mig1.instance_group
  
}
output "tags" {
  value = module.mig1_template.tags  
}

