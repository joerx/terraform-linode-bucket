# terraform-linode-bucket

Terraform module to provision object storage buckets in [Akamai Cloud](https://www.linode.com/) (formerly known as Linode). Uses the [Linode Terraform Provider](https://registry.terraform.io/providers/linode/linode/latest/docs).

## Terraform Versions

Due to [this issue](https://github.com/hashicorp/terraform/issues/36704) affecting Linode backend storage, Terraform versions are currently pinned to `>= 1.0, < 1.11.2`.

## Usage

```c
module "terraform_backend" {
  source = "https://github.com/joerx/terraform-linode-bucket/releases/download/<VERSION>/terraform-linode-bucket.tar.gz"
  env    = "tst"
  label  = "my-bucket"
  region = "eu-central"
}
```

### Versioning

- To enable versioning make sure `obj_use_temp_keys` is set to `true` in your provider config

```hcl
provider "linode" {
  obj_use_temp_keys = true
}

module "bucket" {
  source = "https://github.com/joerx/terraform-linode-bucket/releases/download/<VERSION>/terraform-linode-bucket.tar.gz"
  env    = "dev"
  region = "eu-central"
  label  = "example"

  versioning_enabled = true
}
```

## Tests

The following will run all included Terraform tests locally:

```sh
make test
```

## Releasing

To create a new release in GH, which will also publish release assets:

```sh
make release VERSION=v0.2.1
```
