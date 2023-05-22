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

resource "kubernetes_secret" "comments-database" {
  metadata {
    name      = "comments-secret"
    namespace = kubernetes_namespace.comment_api.metadata[0].name
  }

  data = {
    "DB_USER" = var.DB_HOST
    "DB_PASSWORD" = var.DB_PASS
    "DB_HOST" = var.DB_HOST

  }
}