locals {
  _default_env = "dev"

  # For backwards compat, remove eventually
  _label = var.label != null ? var.label : var.service
  _env   = var.env != null ? var.env : coalesce(var.stage, local._default_env)
  label  = "${local._env}-${local._label}-${random_string.s.result}"
}

resource "random_string" "s" {
  length  = 4
  special = false
  upper   = false
}

# Linodes's handling of object storage keys is a nightmare.
resource "linode_object_storage_key" "k" {
  count = var.access_key_enabled ? 1 : 0
  label = local.label

  bucket_access {
    bucket_name = linode_object_storage_bucket.b.label
    region      = var.region
    permissions = "read_write"
  }
}

resource "linode_object_storage_bucket" "b" {
  region     = var.region
  label      = local.label
  versioning = var.versioning_enabled
  acl        = "private"
}
