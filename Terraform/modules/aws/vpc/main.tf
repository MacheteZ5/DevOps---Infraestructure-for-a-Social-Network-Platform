provider "aws" {
  profile                  = "<user credentials>"
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = var.region
}

resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_Subnet_${each.key}"
  }
}

resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az
  tags = {
    Name = "Private_Subnet_${each.key}"
  }
}

resource "aws_internet_gateway" "Igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main-gw"
  }
}
