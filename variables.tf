variable "region" {
  description = "Linode region to create the bucket in"
  type        = string
}

variable "stage" {
  description = "Deployment stage"
  type        = string
}

variable "service" {
  description = "Service name"
  type        = string
}

variable "versioning" {
  description = "Enable versioning for the bucket"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}
