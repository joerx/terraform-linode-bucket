output "bucket" {
  value = linode_object_storage_bucket.b.label
}

output "endpoint" {
  value = linode_object_storage_bucket.b.s3_endpoint
}

output "access_key" {
  value = local.access_key_enabled ? linode_object_storage_key.k[0].access_key : null
}

output "secret_key" {
  sensitive = true
  value     = local.access_key_enabled ? linode_object_storage_key.k[0].secret_key : null
}
