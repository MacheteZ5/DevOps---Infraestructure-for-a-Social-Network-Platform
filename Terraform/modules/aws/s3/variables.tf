variable "region" {
  default     = "us-east-1"
  description = "Region where the Infraestructure will be created"
  type        = string
}

variable "s3_buckets" {
  description = "Bucket's Name list"
  type        = map(string)
}

variable "s3_enable_disable_versioning" {
  default     = "Disabled"
  description = "Enable or Disable versioning in the Bucket"
  type        = string
}
