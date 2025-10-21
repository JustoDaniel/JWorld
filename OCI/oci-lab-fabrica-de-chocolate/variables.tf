variable "oci_profile" {
  type        = string
  description = "Perfil do arquivo ~/.oci/config a ser usado pelo provider"
  default     = "DEFAULT"
}


variable "region" {
  type        = string
  description = "Região OCI (ex.: sa-saopaulo-1)"
}


variable "tenancy_ocid" {
  type        = string
  description = "OCID do Tenancy"
}


variable "root_compartment_ocid" {
  type        = string
  description = "OCID do compartment raiz (geralmente o próprio tenancy_ocid)"
}


variable "my_ip_cidr" {
  type        = string
  description = "Seu IP público em formato CIDR (ex.: 200.200.200.200/32)"
}


variable "ssh_public_key" {
  type        = string
  description = "Conteúdo da sua chave pública (ex.: ~/.ssh/id_rsa.pub)"
}


variable "choquito_bucket_name" {
  type        = string
  default     = "bucketchoquitoproj_justodaniel"
  description = "Nome do bucket do projeto Choquito"
}


# Índice do AD (0, 1 ou 2) — simplificado para laboratório
variable "availability_domain_index" {
  type    = number
  default = 0
}