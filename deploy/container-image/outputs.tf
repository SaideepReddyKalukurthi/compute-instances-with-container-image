output "container" {
  description = "The container metadata provided to the module"
  value       = module.gce-container.container
}

output "container_image" {
    value =  module.gce-container.source_image
}

output "metadata_value" {
    value = module.gce-container.metadata_value  
}

output "labels" {
    value = module.gce-container.vm_container_label  
}
