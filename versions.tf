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
