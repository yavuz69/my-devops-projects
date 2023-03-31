terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }

    github = {
      source = "integrations/github"
      version = "~> 5.0"
  }
}
}

provider "aws" {
  region     = "us-east-1"
}

provider "github" {
   token = var.git-token
}

 

data "aws_vpc" "default" {
  default = true
}

resource "github_repository" "my-repo" {
  name = "Docker-bookstore-project"
  auto_init = true
  visibility = "public"
}
resource "github_branch_default" "main" {
  branch = "main"  
  repository = github_repository.my-repo.name
}

resource "github_repository_file" "myfiles" {
  for_each = toset(var.files)
  content = file(each.value)
  file = each.value
  repository = github_repository.my-repo.name
  branch = "main"
  commit_message = "managed by terraform"
  overwrite_on_create = true
}

resource "aws_instance" "bookstore" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"
  key_name = var.keyname
  vpc_security_group_ids = [aws_security_group.bookstore-sec.id]
  tags = {
    "Name" = "web server of bookstore"
  }
  user_data = file("${path.module}/userdata.sh")
}
resource "aws_security_group" "bookstore-sec" {
  name = "bookstore-sec"
  description = "Allow HTTP and SSH traffic via Terraform"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "amazon-linux-2" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

variable "git-token" {
  default     = "enter your token"
}


variable "keyname" {
  default     = "first-key"
}

variable "files" {
  default     = ["docker-compose.yml", "Dockerfile", "bookstore-api.py", "README.md", "requirements.txt"]
}

output "website" {
  value       = "http://${aws_instance.bookstore.public_ip}"
}
