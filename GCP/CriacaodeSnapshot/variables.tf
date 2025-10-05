# Define as variáveis de entrada para o nosso script
variable "gcp_project_id" {
  description = "O ID do projeto no GCP onde a máquina virtual está."
  type        = string
}

variable "instance_name" {
  description = "O nome da máquina virtual da qual os snapshots serão criados."
  type        = string
}

/* variable "snapshot_prefix" {
  description = "O prefixo para o nome de cada snapshot criado."
  type        = string
} */

variable "instance_zone" {
  description = "A zona onde a instância está localizada (ex: us-central1-a)."
  type        = string
}

variable "ticket_number" {
    description = "Coloque aqui o numero do chamado que voce esta atendendo ou a gmud"
    type = string
}

# Configuração do provedor do Google Cloud
provider "google" {
  project = var.gcp_project_id
}