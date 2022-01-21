provider "google" {
    project = var.project_id
    region = var.region
}


resource "random_shuffle" "zone" {
  input        = data.google_compute_zones.available.names
  result_count = 1
}

module "gce-container" {
  source = "github.com/terraform-google-modules/terraform-google-container-vm"

  container = {
    image = "gcr.io/google-samples/hello-app:1.0"

    env = [
      {
        name  = "TEST_VAR"
        value = "Hello World!"
      },
    ]

    volumeMounts = [
      {
        mountPath = "/cache"
        name      = "tempfs-0"
        readOnly  = "false"
      },
    ]
  }

  volumes = [
    {
      name = "tempfs-0"

      emptyDir = {
        medium = "Memory"
      }
    },
  ]

  restart_policy = "Always"
}

resource "google_compute_instance" "vm" {
  project      = var.project_id
  name         = var.instance_name
  machine_type = "n1-standard-1"
  zone         = random_shuffle.zone.result[0]


  boot_disk {
    initialize_params {
      image = module.gce-container.source_image
    }
  }

  network_interface {
    subnetwork         = var.subnetwork
    access_config {}
  }

  tags = ["container-vm-example"]

  metadata = {
    gce-container-declaration = module.gce-container.metadata_value
  }

  labels = {
    container-vm = module.gce-container.vm_container_label
  }

  service_account {
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}






resource "google_compute_instance" "vm-2" {
  project      = var.project_id
  name         = "${var.instance_name}-2"
  machine_type = "n1-standard-1"
  zone         = random_shuffle.zone.result[0]


  boot_disk {
    initialize_params {
      image = data.terraform_remote_state.image.outputs.container_image
    }
  }

  network_interface {
    subnetwork         = var.subnetwork
    access_config {}
  }

  tags = ["container-vm-example"]

  metadata = {
    gce-container-declaration = module.gce-container.metadata_value
  }

  labels = {
    container-vm = module.gce-container.vm_container_label
  }

  service_account {
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}