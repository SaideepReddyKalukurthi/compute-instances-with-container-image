module "gce-container" {
  source = "github.com/terraform-google-modules/terraform-google-container-vm"

  container = {
    image = var.image
  }
}
