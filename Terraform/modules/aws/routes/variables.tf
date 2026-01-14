variable "region" {
  default     = "us-east-1"
  description = "Region where the Infraestructure will be created"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "routes" {
  description = "Route's Table List"
  type = map(object({
    destination_cidr_block = string
    gateway_id             = string
  }))
}

variable "subnets_route_association" {
  description = "Route's List for the Route Table"
  type        = map(string)
}
