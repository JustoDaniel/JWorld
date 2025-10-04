terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.50.0"
    }
  }



}

locals {
  project_id         = "terraform-teste-projeto01"
  instance_name      = "j-srv02"
 // machine_type       = "n1-highmem-32" // Funcionou depois que troquei de n1-highmem-8
 // machine_type       = "n2d-standard-8" // Funcionou depois que troquei de n1-highmem-32
  machine_type       = "e2-standard-2"
  zone               = "us-central1-a"
  tags               = ["web-server", "terraform-managed"]
  image              = "windows-cloud/windows-2022"
  disk_size_gb       = 50
  network            = "default"
  static_internal_ip = "10.128.0.30"
}


resource "google_compute_instance" "j-srv02" {
  project      = local.project_id
  zone         = local.zone
  name         = local.instance_name
  machine_type = local.machine_type
  tags         = local.tags


      
   
  
  #Essa parte a cima ainda esta errada preciso corrigi-la depois para aparecer o display

  boot_disk {
    initialize_params {
      image = local.image
      size  = local.disk_size_gb
    }
  }


  network_interface {
    network    = local.network
    network_ip = local.static_internal_ip

        # Este bloco vazio atribui um endereço IP público temporário à VM.
    access_config {
    }  
  }


  labels = {
    owner = "justo"
    lab   = "laboratoria-2025-10-04"
    env   = "justo-dev"
  }

  # Permite que a VM seja deletada via Terraform sem erros de proteção.
  allow_stopping_for_update = true
  enable_display            = true  //habilita a exibição de print screen do display (console da máquina)
 


}

