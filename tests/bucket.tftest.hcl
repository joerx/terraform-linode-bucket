mock_provider "linode" {}

variables {
  env    = "tst"
  label  = "bucket"
  region = "eu-central"
}

run "sets_correct_name_and_region" {
  assert {
    condition     = startswith(linode_object_storage_bucket.b.label, "${var.env}-${var.label}")
    error_message = "incorrect bucket name"
  }

  assert {
    condition     = linode_object_storage_bucket.b.region == var.region
    error_message = "incorrect bucket region"
  }
}

run "sets_private_acl" {
  assert {
    condition     = linode_object_storage_bucket.b.acl == "private"
    error_message = "bucket ACL is not set to private"
  }
}

run "set_default_env" {
  variables {
    env = null
  }

  assert {
    condition     = startswith(linode_object_storage_bucket.b.label, "dev")
    error_message = "default value 'dev' was expected for env prefix"
  }
}

run "set_default_label_and_env" {
  variables {
    env     = null
    label   = null
    stage   = "sbx"
    service = "foo"
  }

  assert {
    condition     = strcontains(linode_object_storage_bucket.b.label, var.service)
    error_message = "value of service was supposed to be used for label instead of label"
  }

  assert {
    condition     = startswith(linode_object_storage_bucket.b.label, var.stage)
    error_message = "value of stage was supposed to be used for label instead of env"
  }
}

run "must_set_label_or_service" {
  variables {
    label   = null
    service = null
  }

  command         = plan # Must be provided for condition checks
  expect_failures = [var.label]
}
