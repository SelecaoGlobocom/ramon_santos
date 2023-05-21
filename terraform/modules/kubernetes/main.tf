resource "kubernetes_namespace" "comment_api" {
  metadata {
    name = var.api_namespace
  }
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.monitoring_namespace
  }
}

resource "kubernetes_secret" "registry_credentials" {
  metadata {
    name      = "artifact-registry-credentials"
    namespace = kubernetes_namespace.comment_api.metadata[0].name
  }

  data = {
    "username" = "your-registry-username"
    "password" = "your-registry-password"
  }
}