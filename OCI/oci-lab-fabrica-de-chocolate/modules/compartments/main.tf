resource "oci_identity_compartment" "chocolatebranco_prod" {
  name           = "ChocolateBrancoProj-prod"
  description    = "Compartimento de produção ChocolateBranco"
  compartment_id = var.parent_compartment_ocid
  enable_delete  = true
}

resource "oci_identity_compartment" "choquito_dev" {
  name           = "ChoquitoProj-dev"
  description    = "Compartimento de desenvolvimento Choquito"
  compartment_id = var.parent_compartment_ocid
  enable_delete  = true
}

