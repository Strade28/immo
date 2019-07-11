resource "google_compute_network" "network" {
  name    = "skazy-inge-immopf-au1-stage"
  project = "${google_project.project_immobilier.project_id}"
  depends_on = [
    "google_project_services.project"
  ]
}

resource "google_compute_global_address" "immobilier-pf_ip_address" {
  name          = "immobilier-pf-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = "${google_compute_network.network.self_link}"
  project       = "${google_project.project_immobilier.project_id}"
}

resource "google_service_networking_connection" "postgres_vpc_connection" {
  network                 = google_compute_network.network.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = ["${google_compute_global_address.immobilier-pf_ip_address.name}"]
}

resource "google_compute_firewall" "default" {
  name    = "immo-firewall"
  network = "${google_compute_network.network.name}"
  project = "${google_project.project_immobilier.project_id}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
