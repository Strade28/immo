resource "google_compute_disk" "data-disk" {
  name    = "data-disk"
  project = "${google_project.project_immobilier.project_id}"
  type    = "pd-ssd"
  zone    = "${var.region}-b"

  size = 30

  image = "projects/skazy-terraform-admin/global/images/data-ssd-30"
  depends_on = [
    "google_project_services.project"
  ]
}


resource "google_compute_attached_disk" "default" {
  disk     = google_compute_disk.data-disk.self_link
  instance = google_compute_instance.backend.self_link
}
