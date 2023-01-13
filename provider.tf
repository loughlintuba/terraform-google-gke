terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.4.0"
    }
    google = {
      source = "hashicorp/google"
    }
  }
  required_version = ">= 0.13"
}

provider "google" {
  credentials = file(var.google_credentials) #GOOGLE_CREDENTIALS to the path of a file containing the credential JSON
  project     = var.google_project_id
  version     = "4.23.0"
}

provider "google-beta" {
  credentials = file(var.google_credentials) #GOOGLE_CREDENTIALS to the path of a file containing the credential JSON
  project     = var.google_project_id
  version     = "4.4.0"
}
