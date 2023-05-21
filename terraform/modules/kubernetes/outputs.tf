output "api_namespace" {
  value = kubernetes_namespace.comment_api.id
}

output "monitoring_namespace" {
  value = kubernetes_namespace.monitoring.id
}