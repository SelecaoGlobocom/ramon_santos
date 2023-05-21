terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.65.2"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.20.0"
    }
     helm = {
      source = "hashicorp/helm"
      version = "2.9.0"
    }
  }
}

provider "google" {
  project     = var.project
  region      = var.default_region
  zone        = var.default_zone
  credentials = var.credentials
}

data "google_client_config" "google" {
}

data "google_container_cluster" "comments" {
  name     = var.cluster_name
  location = var.default_zone

  depends_on = [ module.gke-cluster ]
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.comments.endpoint}"
  token = data.google_client_config.google.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.comments.master_auth[0].cluster_ca_certificate,
  )
}

provider "helm" {
  kubernetes {
  host  = "https://${data.google_container_cluster.comments.endpoint}"
  token = data.google_client_config.google.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.comments.master_auth[0].cluster_ca_certificate,
  )
}
}
