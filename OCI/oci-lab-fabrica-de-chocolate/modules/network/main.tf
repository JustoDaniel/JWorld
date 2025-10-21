resource "oci_core_vcn" "this" {
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_ocid
  display_name   = "${var.name_prefix}-vcn"
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.name_prefix}-igw"
  vcn_id         = oci_core_vcn.this.id
  enabled        = true
}

resource "oci_core_route_table" "rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${var.name_prefix}-rt"

  route_rules {
    destination       = "0.0.0.0/0" # ✅ substitui cidr_block
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
    description       = "Default route to IGW"
  }
}


resource "oci_core_security_list" "sl" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${var.name_prefix}-sl"

  # ✅ Corrigido — blocos declarativos para egress
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
    stateless   = false
  }

  # ✅ Corrigido — blocos declarativos para ingress
  ingress_security_rules {
    protocol    = "6" # TCP
    source      = var.my_ip_cidr
    stateless   = false
    description = "SSH apenas do meu IP"

    tcp_options {
      min = 22
      max = 22
    }
  }
}

resource "oci_core_subnet" "public" {
  cidr_block                 = var.public_subnet_cidr
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.this.id
  route_table_id             = oci_core_route_table.rt.id
  security_list_ids          = [oci_core_security_list.sl.id]
  display_name               = "${var.name_prefix}-public-subnet"
  prohibit_public_ip_on_vnic = false
}

output "public_subnet_id" {
  value = oci_core_subnet.public.id
}

output "vcn_id" {
  value = oci_core_vcn.this.id
}
