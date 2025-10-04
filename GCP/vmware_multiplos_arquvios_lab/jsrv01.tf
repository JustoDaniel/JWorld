terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.50.0"
  }
}

  backend "gcs" {
    bucket = "tf-state-justo" # <-- MUDE AQUI para o nome do bucket que você criou
    prefix = "terraform-vmware-multiplos-arquivos-lab"          # (Opcional) Uma pasta dentro do bucket para organizar o estado
  }

}

locals {
  project_id   = "terraform-teste-projeto01" 
  instance_name = "j-srv01"
  machine_type = "e2-medium"          
  zone         = "us-central1-a"     
  tags         = ["web-server", "terraform-managed"]
  image        = "debian-cloud/debian-11"    
  network      = "default"
}


resource "google_compute_instance" "j-srv01" {
  project      = local.project_id
  zone         = local.zone
  name         = local.instance_name
  machine_type = local.machine_type
  tags         = local.tags


  boot_disk {
    initialize_params {
      image = local.image
    }
  }

 
  network_interface {
    network = local.network

    # Este bloco vazio atribui um endereço IP público temporário à VM.
    access_config {
    }
  }

  
  labels = {
    owner = "Justo"
    lab = "Laboratoria-2025-10-04"
    env   = "Justo-dev"
  }

  # Permite que a VM seja deletada via Terraform sem erros de proteção.
  allow_stopping_for_update = true
}
