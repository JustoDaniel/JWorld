output "rede_group_id" {
  value = oci_identity_policy.rede_policy.id
}

output "devops_group_id" {
  value = oci_identity_policy.devops_policy.id
}



