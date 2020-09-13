module "gke_cluster" {
    source  = "fuchicorp/gke/google"
    cluster_name = "tl-cluster"
    google_region = "us-central1"
    google_project_id = "brave-aviary-285822"
    cluster_node_count = "2"
    cluster_version = "1.15"
    google_credentials = "./tl-service-account.json" # service account 
}
