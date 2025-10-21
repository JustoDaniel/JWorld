

resource "oci_identity_policy" "rede_policy" {
  name           = "RedePolicy"
  description    = "Permissões de rede"
  compartment_id = var.tenancy_ocid

  statements = [
    "Allow group RedeGrupo to manage instance-family in compartment id ${var.chocolatebranco_prod_id}"
  ]


}

resource "oci_identity_policy" "devops_policy" {
  name           = "DevOpsPolicy"
  description    = "Permissões de DevOps"
  compartment_id = var.tenancy_ocid

  statements = [
    "Allow group DevOpsGrupo to manage buckets in compartment id ${var.choquito_dev_id}",
    "Allow group DevOpsGrupo to manage instance-family in compartment id ${var.choquito_dev_id}"
  ]


}
