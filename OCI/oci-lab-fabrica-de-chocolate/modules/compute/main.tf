# Escolhe uma imagem Oracle Linux mais recente
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}


locals {
  ad_name = data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain].name
}


data "oci_core_images" "ol" {
  compartment_id           = var.compartment_ocid
  operating_system         = "Oracle Linux"
  operating_system_version = "9"
  shape                    = "VM.Standard.E2.1.Micro"
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}


resource "oci_core_instance" "vm" {
  availability_domain = local.ad_name
  compartment_id      = var.compartment_ocid
  display_name        = var.instance_name
  shape               = "VM.Standard.E2.1.Micro" # micro (elegível ao Always Free)


  shape_config {
    ocpus         = 1
    memory_in_gbs = 1
  }


  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.ol.images[0].id
    boot_volume_size_in_gbs = 50
  }


  create_vnic_details {
    subnet_id        = var.subnet_ocid
    assign_public_ip = true
    #hostname_label   = replace(var.instance_name, "_", "-")
  }


  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = base64encode(<<-EOT
#cloud-config
packages:
- python3
runcmd:
- echo "Hello from ${var.instance_name}" > /etc/motd
EOT
    )
  }
}


output "public_ip" {
  value = oci_core_instance.vm.public_ip
}