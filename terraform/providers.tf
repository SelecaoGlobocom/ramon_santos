terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.65.2"
    }
  }
}

provider "google" {
  project     = var.project
  region      = var.default_region
  zone        = var.default_zone
  credentials = var.credentials
}