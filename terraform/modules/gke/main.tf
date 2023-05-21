resource "google_container_cluster" "primary" {
  project                 = var.project
  name                     = var.cluster_name
  location                 = var.default_zone
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.network
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.pool_name
  location   = var.default_zone
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    preemptible  = true
    machine_type = var.machine_type
  }
}