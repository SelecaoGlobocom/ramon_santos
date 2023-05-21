output "vpc_network_name" {
  description = "Name of the VPC"
  value       = google_compute_network.vpc_network.name
}

output "id" {
  description = "ID of the VPC"
  value       = google_compute_network.vpc_network.id
}
