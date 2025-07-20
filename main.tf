locals {
  label = "${var.stage}-${var.service}-${random_string.s.result}"
  tags  = ["stage:${var.stage}", "service:${var.service}", "component:backups"]
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
  count = var.versioning.enabled ? 1 : 0
  label = local.label
}

resource "linode_object_storage_bucket" "b" {
  region = var.region
  label  = local.label

  access_key = var.versioning.enabled ? linode_object_storage_key.k[0].access_key : null
  secret_key = var.versioning.enabled ? linode_object_storage_key.k[0].secret_key : null

  versioning = var.versioning.enabled
  acl        = "private"
}
