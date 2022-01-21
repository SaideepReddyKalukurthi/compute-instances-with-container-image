output "project_id" {
  description = "The project ID resources were deployed into"
  value       = var.project_id
}

output "zone" {
  description = "The zone the GCE instance was deployed into"
  value       = google_compute_instance.vm.zone
}

output "vm_container_label" {
  description = "The instance label containing container configuration"
  value       = module.gce-container.vm_container_label
}

output "container" {
  description = "The container metadata provided to the module"
  value       = module.gce-container.container
}

output "volumes" {
  description = "The volume metadata provided to the module"
  value       = module.gce-container.volumes
}

output "instance_name" {
  description = "The deployed instance name"
  value       = var.instance_name
}

output "ipv4" {
  description = "The public IP address of the deployed instance"
  value       = google_compute_instance.vm.network_interface.0.access_config.0.nat_ip
}