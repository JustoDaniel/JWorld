

# Bloco de dados para buscar as informações da instância especificada
data "google_compute_instance" "instance" {
  name    = var.instance_name
  zone    = var.instance_zone
  project = var.gcp_project_id
}

# Bloco de recursos para criar os snapshots
# Utiliza 'for_each' para iterar sobre cada disco anexado à instância
resource "google_compute_snapshot" "disk_snapshots" {
  for_each = toset([for disk in data.google_compute_instance.instance.attached_disk : disk.source])

  name    = "${var.ticket_number}-${data.google_compute_instance.instance.name}-${element(split("/", each.value), length(split("/", each.value)) - 1)}-${formatdate("YYYYMMDD-HHmmss", timestamp())}"
  source_disk = each.value
  project     = var.gcp_project_id

  labels = {
    "created_by"   = "terraform"
    "owner"        = "sauter"
    "instance_name" = var.instance_name
  }

/*   snapshot_encryption_key {
    raw_key = "Sua chave de criptografia em base64 aqui, se necessário" # Opcional: Remova se não usar CMEK
  } */

  storage_locations = ["us-central1"] # Opcional: Especifique a localização do snapshot se desejar
}

# (Opcional) Bloco de saída para mostrar os nomes dos snapshots criados
output "snapshot_names" {
  description = "Os nomes dos snapshots que foram criados."
  value       = [for snapshot in google_compute_snapshot.disk_snapshots : snapshot.name]
}