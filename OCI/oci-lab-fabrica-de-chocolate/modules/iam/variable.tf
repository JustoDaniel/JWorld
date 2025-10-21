variable "tenancy_ocid" {
  type = string
}
variable "compartments_map" {
  type = map(object({ id = string }))
}


variable "rede_group_users" {
  type = list(string)
}
variable "devops_group_users" {
  type = list(string)
}


variable "network_source_name" {
  type = string
}
variable "my_ip_cidr" {
  type = string
}


variable "dev_bucket_name" {
  type = string
}


variable "chocolatebranco_prod_id" {
  description = "OCID do compartimento de produção ChocolateBranco"
  type        = string
}
variable "choquito_dev_id" {
  description = "OCID do compartimento de desenvolvimento Choquito"
  type        = string
}