variable "region" {
  default     = "us-east-1"
  description = "Region where the Infraestructure will be created"
  type        = string
}

variable "rds_instances" {
  description = "RDS Instances Map"
  type = map(object({
    identifier           = string
    engine               = string
    engine_version       = string
    instance_class       = string
    allocated_storage    = number
    username             = string
    password             = string
    parameter_group_name = string
    skip_final_snapshot  = bool
  }))
}
