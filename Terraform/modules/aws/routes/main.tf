provider "aws" {
  profile                  = "<user credentials>"
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = var.region
}

resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id
  tags = {
    Name = "route-table"
  }
}

resource "aws_route" "routes" {
  for_each               = var.routes
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = each.value.destination_cidr_block
  gateway_id             = each.value.gateway_id
}

resource "aws_route_table_association" "public_1_route_association" {
  for_each       = var.subnets_route_association
  subnet_id      = each.value
  route_table_id = aws_route_table.route_table.id
}
