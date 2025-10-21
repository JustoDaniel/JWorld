output "compartments" {
  value = module.compartments.compartments_map
}


output "rede_grupo_id" {
  value = module.iam.rede_group_id
}


output "devops_grupo_id" {
  value = module.iam.devops_group_id
}


output "bucket_name" {
  value = module.bucket_choquito_dev.bucket_name
}


output "vm_choc_public_ip" {
  value = module.vm_choc_prod.public_ip
}


output "vm_choq_public_ip" {
  value = module.vm_choq_prod.public_ip
}