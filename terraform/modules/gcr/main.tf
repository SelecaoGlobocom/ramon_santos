resource "google_artifact_registry_repository" "my-repo" {
  location      = var.default_region
  repository_id = var.repository_id
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }
}