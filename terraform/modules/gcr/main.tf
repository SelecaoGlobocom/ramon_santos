resource "google_artifact_registry_repository" "comment-repo" {
  location      = var.default_region
  repository_id = var.repository_id
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }
}

resource "google_artifact_registry_repository_iam_member" "repo-iam" {
  location = google_artifact_registry_repository.comment-repo.location
  repository = google_artifact_registry_repository.comment-repo.name
  role   = "roles/artifactregistry.reader"
  member = "serviceAccount:terraform-globo@sandbox-387113.iam.gserviceaccount.com"
}