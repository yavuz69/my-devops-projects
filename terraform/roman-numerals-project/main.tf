terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon-linux-2
  instance_type = "t2.micro".id
  security_groups = ["allow_tls"]
  user_data = file("${path.module}/userdata.sh")
  key_name = "first-key"
}

data "aws_ami" "amazon-linux-2" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}