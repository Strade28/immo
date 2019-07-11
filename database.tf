resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "master" {
  name             = "immobilier-pf-instance-${random_id.db_name_suffix.hex}"
  region           = var.region
  project          = google_project.project_immobilier.project_id
  database_version = "POSTGRES_9_6"

  depends_on = [
    "google_service_networking_connection.postgres_vpc_connection",
  ]

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = "false"
      private_network = google_compute_network.network.self_link
    }
  }
}

resource "google_sql_database" "immo-db" {
  name     = "immo_db"
  instance = google_sql_database_instance.master.name
  charset  = "UTF8"
  project  = google_project.project_immobilier.project_id
}

resource "google_sql_user" "user" {
  name     = "immo-dba"
  instance = google_sql_database_instance.master.name
  password = "test"
  project  = google_project.project_immobilier.project_id
}
