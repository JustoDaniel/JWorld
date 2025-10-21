output "chocolatebranco_prod_id" {
  value = oci_identity_compartment.chocolatebranco_prod.id
}

output "choquito_dev_id" {
  value = oci_identity_compartment.choquito_dev.id
}

output "compartments_map" {
  value = {
    "ChocolateBrancoProj-prod" = {
      id = oci_identity_compartment.chocolatebranco_prod.id
    }
    "ChoquitoProj-prod" = {
      id = oci_identity_compartment.choquito_dev.id
    }
  }
}
