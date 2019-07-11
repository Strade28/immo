resource "google_dns_managed_zone" "immo" {
  name        = "immo"
  dns_name    = "immo."
  description = "Immobilier-pf zone"
  project     = "${google_project.project_immobilier.project_id}"

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = "${google_compute_network.network.self_link}"
    }
  }
}

resource "google_dns_record_set" "postgres" {
  name    = "postgres.${google_dns_managed_zone.immo.dns_name}"
  project = "${google_project.project_immobilier.project_id}"
  type    = "A"
  ttl     = 60

  managed_zone = "${google_dns_managed_zone.immo.name}"

  rrdatas = ["${google_sql_database_instance.master.private_ip_address}"]
}
