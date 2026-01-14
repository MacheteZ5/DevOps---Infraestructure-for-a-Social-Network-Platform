locals {
  environment   = "dev"
  region        = "us-east-1"
  instance_size = local.environment == "prod" ? "t3.medium" : "t2.micro"
}

module "vpc_1" {
  source         = "./modules/aws/vpc"
  vpc_cidr_block = "172.16.0.0/16"
  region         = local.region
  public_subnets = {
    "1" = {
      cidr_block = "172.16.0.0/24"
    az = "${local.region}a" },
    "2" = {
      cidr_block = "172.16.1.0/24"
    az = "${local.region}b" },
  }
  private_subnets = {
    "1" = {
      cidr_block = "172.16.2.0/24"
    az = "${local.region}a" },
    "2" = {
      cidr_block = "172.16.3.0/24"
    az = "${local.region}b" },
  }
}

module "routeTable_1" {
  source = "./modules/aws/routes"
  region = local.region
  vpc_id = module.vpc_1.vpc_id
  routes = {
    "ruta_1" = {
      destination_cidr_block = "0.0.0.0/0"
    gateway_id = module.vpc_1.internet_gateway_id }
  }
  subnets_route_association = module.vpc_1.public_subnets_id
}

module "ec2s" {
  source = "./modules/aws/ec2"
  region = local.region
  instances = {
    "ec2_Windows_Server_1" = {
      ami           = "ami-06777e7ef7441deff"
      instance_type = local.instance_size
    },
    "ec2_Ubuntu_Server_1" = {
      ami           = "ami-0ecb62995f68bb549"
      instance_type = local.instance_size
    }
  }
}

module "s3_bucket_1" {
  source = "./modules/aws/s3"
  region = local.region
  s3_buckets = {
    name = "First_bucket"
  }
  s3_enable_disable_versioning = "Enabled"
}

module "s3_bucket_2" {
  source = "./modules/aws/s3"
  region = local.region
  s3_buckets = {
    name = "Second_bucket"
  }
}
module "rds_instances" {
  source = "./modules/aws/rds"
  region = local.region
  rds_instances = {
    "latest_instance" = {
      identifier           = "latest-instance"
      engine               = "mysql"
      engine_version       = "8.0.31"
      instance_class       = "db.t3.micro"
      allocated_storage    = 20
      username             = "admin"
      password             = "password"
      parameter_group_name = "default.mysql8.0"
      skip_final_snapshot  = true
    }
  }
}


output "vpc_1_module" {
  value = module.vpc_1
}
