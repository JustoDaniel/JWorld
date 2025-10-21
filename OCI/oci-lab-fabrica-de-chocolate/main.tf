terraform {
  required_version = ">= 1.5.0"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 6.5.0"
    }
  }
}

# Provider lendo perfil local (~/.oci/config)
provider "oci" {
  config_file_profile = var.oci_profile
  region              = var.region
}

# ——————————————
# 1) Compartments
# ——————————————
module "compartments" {
  source = "./modules/compartments"

  parent_compartment_ocid = var.root_compartment_ocid # geralmente igual ao tenancy_ocid

  projects = {
    ChocolateBrancoProj = {
      children = ["ChocolateBrancoProj-dev", "ChocolateBrancoProj-prod"]
    }
    ChoquitoProj = {
      children = ["ChoquitoProj-dev", "ChoquitoProj-prod"]
    }
  }
}

# ——————————————
# 2) IAM: Users, Groups, Network Source, Policies
# ——————————————
module "iam" {
  source = "./modules/iam"

  tenancy_ocid            = var.tenancy_ocid
  chocolatebranco_prod_id = module.compartments.chocolatebranco_prod_id
  choquito_dev_id         = module.compartments.choquito_dev_id


  # Compartments vindos do módulo anterior
  compartments_map = module.compartments.compartments_map

  # Emails -> criação de usuários (apenas para LAB)
  rede_group_users   = ["carlosajdaniel@hotmail.com"]
  devops_group_users = ["cjustonaooficial@outlook.com"]


  # Network Source com seu IP
  network_source_name = "TrustedMyIP"
  my_ip_cidr          = var.my_ip_cidr

  # Nome do bucket alvo para políticas do DevOps
  dev_bucket_name = var.choquito_bucket_name
}

# ——————————————
# 3) Network por ambiente (uma VCN por *-prod)
# ——————————————
module "net_choc_prod" {
  source             = "./modules/network"
  compartment_ocid   = module.compartments.compartments_map["ChocolateBrancoProj-prod"].id
  vcn_cidr           = "10.10.0.0/16"
  public_subnet_cidr = "10.10.10.0/24"
  my_ip_cidr         = var.my_ip_cidr
  name_prefix        = "choc-prod"
}

module "net_choq_prod" {
  source             = "./modules/network"
  compartment_ocid   = module.compartments.compartments_map["ChoquitoProj-prod"].id
  vcn_cidr           = "10.20.0.0/16"
  public_subnet_cidr = "10.20.10.0/24"
  my_ip_cidr         = var.my_ip_cidr
  name_prefix        = "choq-prod"
}

# ——————————————
# 4) Bucket em ChoquitoProj-dev
# ——————————————
module "bucket_choquito_dev" {
  source           = "./modules/bucket"
  compartment_ocid = module.compartments.choquito_dev_id
  bucket_name      = var.choquito_bucket_name
}

# ——————————————
# 5) Compute (duas VMs micro, uma em cada *-prod)
# ——————————————
module "vm_choc_prod" {
  source              = "./modules/compute"
  compartment_ocid    = module.compartments.compartments_map["ChocolateBrancoProj-prod"].id
  subnet_ocid         = module.net_choc_prod.public_subnet_id
  availability_domain = var.availability_domain_index
  instance_name       = "vm-choc-prod-01"
  ssh_public_key      = var.ssh_public_key
}

module "vm_choq_prod" {
  source              = "./modules/compute"
  compartment_ocid    = module.compartments.compartments_map["ChoquitoProj-prod"].id
  subnet_ocid         = module.net_choq_prod.public_subnet_id
  availability_domain = var.availability_domain_index
  instance_name       = "vm-choq-prod-01"
  ssh_public_key      = var.ssh_public_key
}

