variable "region" {
  default     = "us-east-1"
  description = "Region where the Infraestructure will be created"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR Block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Public Subnets CIDR Block's List"
  type = map(object({
    cidr_block = string
    az         = string
  }))
}

variable "private_subnets" {
  description = "Private Subnets CIDR Block's List"
  type = map(object({
    cidr_block = string
    az         = string
  }))
}
