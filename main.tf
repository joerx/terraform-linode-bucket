locals {
  _default_env = "dev"

  # For backwards compat, remove eventually
  _label = var.label != null ? var.label : var.service
  _env   = var.env != null ? var.env : coalesce(var.stage, local._default_env)
  label  = "${local._env}-${local._label}-${random_string.s.result}"

  access_key_enabled = var.versioning_enabled || var.access_key_enabled
}

resource "random_string" "s" {
  length  = 4
  special = false
  upper   = false
}

# Linodes's handling of object storage keys is a nightmare.
# We need this key only if versioning is enabled
# The provider won't pick up standard AWS credentials either :(
resource "linode_object_storage_key" "k" {
  count = local.access_key_enabled ? 1 : 0
  label = local.label

  bucket_access {
    bucket_name = local.label
    region      = var.region
    permissions = "read_write"
  }
}

resource "linode_object_storage_bucket" "b" {
  region = var.region
  label  = local.label

  access_key = var.versioning_enabled ? linode_object_storage_key.k[0].access_key : null
  secret_key = var.versioning_enabled ? linode_object_storage_key.k[0].secret_key : null

  versioning = var.versioning_enabled
  acl        = "private"
}
