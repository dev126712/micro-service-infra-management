resource "google_compute_global_address" "lb_default_ip" {
  name    = "lb-static-ip"
  project = var.project_id
}

#resource "google_compute_managed_ssl_certificate" "default" {
#  name    = "argocd-cert"
#  project = var.project_id
#  managed {
#    domains = ["argocd.example.com"] # Replace with your real domain
#  }
#}
