resource "google_container_cluster" "primary" {
  name                = "my-gke-cluster"
  location            = var.region
  project             = var.project_id
  initial_node_count  = 1
  deletion_protection = false # For demo purposes
  network             = google_compute_network.my-network.id
  subnetwork          = google_compute_subnetwork.custum-subnet.id

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  project    = google_container_cluster.primary.project
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  node_count = 1
  # node_locations = ["us-central1-a", "us-central1-b", "us-central1-c"]
  # enable_private_nodes = true

  node_locations = ["us-central1-a"]

  node_config {
    preemptible  = false
    machine_type = "e2-medium"
    # enable_private_nodes = true
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only"
    ]

  }

  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
