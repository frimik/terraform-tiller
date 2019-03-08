output "depends_on_hook" {
  value = "${kubernetes_deployment.tiller.metadata.0.uid}"
}