output "vpc_id" {
  value       = aws_vpc.main_vpc.id
  description = "The ID of the Internet Gateway"
}

output "public_subnets_id" {
  value       = { for subnet_id, subnet in aws_subnet.public_subnets : subnet_id => subnet.id }
  description = "A set of public subnets IDs"
}

output "private_subnets_id" {
  value       = { for subnet_id, subnet in aws_subnet.public_subnets : subnet_id => subnet.id }
  description = "A set of private subnets IDs"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.Igw.id
  description = "The ID of the Internet Gateway"
}
