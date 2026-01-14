provider "aws" {
  profile                  = "<user credentials>"
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = var.region
}

resource "aws_instance" "servers" {
  for_each      = var.instances
  ami           = each.value.ami
  instance_type = each.value.instance_type
  tags = {
    Name = "env-Server-${each.key}"
  }
}
