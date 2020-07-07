terraform {
  backend "s3" {
  }
}

provider "aws" {
  version = "~> 2.68"
}

data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id
  count         = var.instance_count
  instance_type = var.instance_type
}
