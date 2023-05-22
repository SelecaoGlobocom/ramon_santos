output "db_ip" {
  description = "DB Instance IP"
  value = google_sql_database_instance.instance.private_ip_address
}