variable salt_key_pub {}
variable salt_key {}

resource "google_compute_instance" "backend" {
  name         = "backend"
  machine_type = "n1-standard-1"
  zone         = "${var.region}-b"
  project      = "${google_project.project_immobilier.project_id}"

  tags = ["inge", "immobilier"]

  boot_disk {
    initialize_params {
      image = "debian-9"
    }
  }

  network_interface {
    network = "${google_compute_network.network.name}"

    access_config {
      // Ephemeral IP
    }
  }


  depends_on = [
    "google_compute_disk.data-disk",
    "google_project_services.project"
  ]
  lifecycle {
    ignore_changes = ["attached_disk"]
  }

}
output "backen_public_ip" {
  value = google_compute_instance.backend.network_interface[0].access_config[0].nat_ip
}
