variable "region" {
  description = "Linode region to create the bucket in"
  type        = string
}

variable "stage" {
  description = "Deployment stage. Deprecated, use 'env' instead"
  type        = string
  default     = null
}

variable "env" {
  description = "Deployment environment."
  type        = string
}

variable "service" {
  description = "Service name. Deprecated, use 'label' instead"
  type        = string
  default     = null
}

variable "label" {
  description = "Service name"
  type        = string

  validation {
    condition     = var.service != null || var.label != null
    error_message = "Either service or label value are required"
  }
}

variable "versioning_enabled" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = false
}

variable "access_key_enabled" {
  description = "Whether to create an access key for this bucket"
  type        = bool
  default     = false
}
