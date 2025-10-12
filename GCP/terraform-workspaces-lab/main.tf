# Configura o provedor do Google Cloud
provider "google" {
  project = "terraform-teste-projeto01" # Substitua pelo ID do seu projeto GCP
  region  = "us-central1"
}

# Define variáveis que vamos usar para customizar os ambientes
variable "instance_type" {
  type        = map(string)
  description = "O tipo de máquina para cada ambiente"
  default = {
    "dev"  = "e2-micro"
    "prod" = "e2-small"
  }
}

# Cria um nome dinâmico para a VM baseado no workspace
locals {
  # terraform.workspace nos dá o nome do workspace atual (ex: "dev", "prod")
  instance_name = "vm-${terraform.workspace}"
}

# O recurso da máquina virtual (Compute Engine)
resource "google_compute_instance" "vm" {
  name         = local.instance_name
  machine_type = var.instance_type[terraform.workspace]
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

network_interface {
  network = "default"
  # Adicione este bloco para solicitar um IP externo
  access_config {
  }
}

  # Adiciona uma tag para identificar o ambiente
  labels = {
    environment = terraform.workspace
  }
}

# (Opcional) Mostra o IP externo da VM criada
output "instance_ip" {
  value = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}