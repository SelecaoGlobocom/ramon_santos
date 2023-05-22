resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_compute_network_peering_routes_config" "peering_routes" {
  peering = google_service_networking_connection.private_vpc_connection.peering
  network = var.network_id

  import_custom_routes = true
  export_custom_routes = true
}

resource "google_sql_database_instance" "instance" {
  name             = var.db_instance_name
  database_version = var.database_version
  region           = var.default_region

  depends_on = [google_service_networking_connection.private_vpc_connection]

  deletion_protection  = "false"

  settings {
    tier = var.db_instance_tier
    backup_configuration {
      enabled = true
      start_time = "03:00"
    }
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = var.network
      enable_private_path_for_google_cloud_services = true

    }
  }
}


resource "google_sql_user" "users" {
  name     = var.db_user
  instance = google_sql_database_instance.instance.name
  password = var.db_pass
}


resource "google_sql_database" "comments-db" {
  name     = "comments"
  instance = google_sql_database_instance.instance.name
}
