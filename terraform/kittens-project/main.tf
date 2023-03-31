terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.8.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  # access_key = "xxxxxxx"
  # secret_key = "xxxxxxxx"
  ## profile = "my-profile"
}

resource "aws_instance" "tf-ec2" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.demo-sg.id]
  tags = {
    "Name" = "created-by-terraform"
  }
 
data "aws_ami" "amazon-linux-2" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

  user_data = "${file("userdata.sh")}"
}