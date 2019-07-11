terraform {
 backend "gcs" {
   bucket  = "skazy-terraform-admin"
   prefix  = "terraform/inge/immobilier-pf/stage"
 }
}