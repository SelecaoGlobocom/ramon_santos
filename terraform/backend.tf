terraform {
 backend "gcs" {
   bucket  = "8vskzsmv2-tf-comments-state"
   prefix  = "terraform/state"
 }
}