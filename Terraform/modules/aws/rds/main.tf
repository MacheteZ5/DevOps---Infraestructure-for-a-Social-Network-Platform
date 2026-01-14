provider "aws" {
  profile                  = "<user credentials>"
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = var.region
}

resource "aws_db_instance" "default" {

  for_each             = var.rds_instances
  identifier           = each.value.identifier
  allocated_storage    = each.value.allocated_storage
  engine               = each.value.engine
  engine_version       = each.value.engine_version
  instance_class       = each.value.instance_class
  username             = each.value.username
  password             = each.value.password
  parameter_group_name = each.value.parameter_group_name
  skip_final_snapshot  = each.value.skip_final_snapshot
}
