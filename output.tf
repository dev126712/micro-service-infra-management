output "load_balancer_ip" {
  description = "The static external IP address for the Global Load Balancer. Point your DNS A-record to this IP."
  value       = google_compute_global_address.lb_default_ip.address
}

output "gke_cluster_name" {
  description = "The name of the GKE cluster."
  value       = google_container_cluster.primary.name
}

output "gke_cluster_endpoint" {
  description = "The IP address of the Kubernetes master."
  value       = google_container_cluster.primary.endpoint
}

#output "ssl_certificate_status" {
#  description = "The status of the managed SSL certificate."
#  value       = google_compute_managed_ssl_certificate.default.managed[0].status
#}
