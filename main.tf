variable "aws_region" {
    type = string
    description = "Region to use for AWS instance"
    default = "us-east-1"
    sensitive = false
}

variable "instance_tag_name" {
    type = string
    description = "Instance Name"
    default = "no-name"
    sensitive = false
}

variable "instance_type" {
    type = string
    description = "Instance type"
    default = "t1.micro"
    sensitive = false
}

variable "ami_id" {
    type = string
    description = "AMI id"
    default = "ami-0889a44b331db0194"
    sensitive = false
}

variable "availability_zone" {
    type = string
    description = "AZ"
    default = "us-east-1b"
    sensitive = false
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.49.0"
    }
  }
  cloud {
    organization = "mmoglia"
    workspaces {
      name = "aws-ec2"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "myec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  availability_zone = var.availability_zone

  tags = {
    Name = var.instance_tag_name
    Env = "dev"
  }
}
