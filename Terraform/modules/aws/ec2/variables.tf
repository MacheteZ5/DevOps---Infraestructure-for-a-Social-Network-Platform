variable "region" {
  default     = "us-east-1"
  description = "Region where the Infraestructure will be created"
  type        = string
}

variable "instances" {
  description = "Map of instance configurations"
  type = map(object({
    ami           = string
    instance_type = string
  }))
}
