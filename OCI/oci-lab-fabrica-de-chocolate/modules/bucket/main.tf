data "oci_objectstorage_namespace" "ns" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaa5gopwfkaevaz2ybsvqopbb5n3cb223lxtxwkgfyu537vgef675sq"
}

resource "oci_objectstorage_bucket" "this" {
  compartment_id = var.compartment_ocid
  name           = var.bucket_name
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  #public_access_type = "NoPublicAccess"
  storage_tier = "Standard"
  versioning   = "Disabled"
}

output "bucket_name" {
  value = oci_objectstorage_bucket.this.name
}
