variable "region" {}
variable "project_name" {}
variable "billing_account" {}

provider "google" {
  region      = var.region
  credentials = "${file("/home/julien/.config/gcloud/skazy-terraform-admin.json")}"
}

data "terraform_remote_state" "folder" {
  backend   = "gcs"
  workspace = "default"

  config = {
    bucket = "skazy-terraform-admin"
    prefix = "terraform/inge/immobilier-pf"
  }
}

resource "random_id" "id" {
  byte_length = 4
  prefix      = "immobilier-pf-"
}

resource "google_project" "project_immobilier" {
  name            = "immobilier-pf"
  project_id      = random_id.id.hex
  billing_account = var.billing_account
  folder_id       = data.terraform_remote_state.folder.outputs.stage_folder_id
}

resource "google_project_services" "project" {
  project = google_project.project_immobilier.project_id

  services = [
    "compute.googleapis.com",
    "oslogin.googleapis.com",
    "servicenetworking.googleapis.com",
    "dns.googleapis.com"
  ]
}

output "project_id" {
  value = google_project.project_immobilier.project_id
}
