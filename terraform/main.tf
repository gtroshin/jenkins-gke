provider "google" {
  project = "jenkins-gke-demo-440609"
  region  = "us-central1"
}

resource "google_container_cluster" "primary" {
  name     = "jenkins-cluster"
  location = "us-central1-a"

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  initial_node_count = 1
}

resource "google_container_node_pool" "linux_pool" {
  name       = "linux-pool"
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  initial_node_count = 1
  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }
}

output "kubeconfig" {
  value = google_container_cluster.primary.endpoint
}

output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "cluster_location" {
  value = google_container_cluster.primary.location
}

output "project_id" {
  value = "jenkins-gke-demo-440609"
}
