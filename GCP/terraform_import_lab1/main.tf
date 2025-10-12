terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "terraform-teste-projeto01"
  region  = "us-central1" // Região padrão para os recursos
}




resource "google_storage_bucket" "meu_bucket" {
  name     = "meu-bucket-gcp-para-importar-12345"
  location = "US-CENTRAL1"
  labels = {
    ambiente = "legado"
  }
  force_destroy = true // Boa prática para buckets de lab, permite apagar mesmo se não estiver vazio
}