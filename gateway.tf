resource "kubectl_manifest" "external_gateway" {
  yaml_body = templatefile("${path.module}/gateway/gateway.yaml", {
    static_ip_name = google_compute_global_address.lb_default_ip.name
  })

  depends_on = [google_container_node_pool.primary_preemptible_nodes]
}
