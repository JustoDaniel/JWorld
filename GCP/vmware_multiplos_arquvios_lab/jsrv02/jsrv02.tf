terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.50.0"
  }
}



}

locals {
  project_id   = "terraform-teste-projeto01" 
  instance_name = "j-srv02"
  machine_type = "n2-standard-2"          
  zone         = "us-central1-a"     
  tags         = ["web-server", "terraform-managed"]
  image = "windows-cloud/windows-server-2025-dc"
  disk_size_gb       = 50  
  network      = "default"
  static_internal_ip = "10.128.0.30"
}


resource "google_compute_instance" "j-srv02" {
  project      = local.project_id
  zone         = local.zone
  name         = local.instance_name
  machine_type = local.machine_type
  tags         = local.tags
  
  
  

  boot_disk {
    initialize_params {
      image = local.image
      size = local.disk_size_gb
    }
  }

 
  network_interface {
    network = local.network
    network_ip = local.static_internal_ip

/*      # Este bloco vazio atribui um endereço IP público temporário à VM.
    access_config {
    }  */
  }

  
  labels = {
    owner = "justo"
    lab = "laboratoria-2025-10-04"
    env   = "justo-dev"
  }

  # Permite que a VM seja deletada via Terraform sem erros de proteção.
  allow_stopping_for_update = true
}
