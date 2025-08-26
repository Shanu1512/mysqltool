variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "ubuntu_ami" {
  description = "Ubuntu 24 LTS AMI for us-east-1"
  default     = "ami-0e86e20dae9224db8"
}


# VPC CIDR
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Public Subnet
variable "public_subnet_a" {
  description = "CIDR block for Public Subnet in AZ A"
  type        = string
  default     = "10.0.1.0/24"
}

# Private Subnets
variable "private_subnet_a" {
  description = "CIDR block for Private Subnet in AZ A"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_b" {
  description = "CIDR block for Private Subnet in AZ B"
  type        = string
  default     = "10.0.3.0/24"
}

# Instance Type
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# SSH Key Pair
variable "key_name" {
  description = "Name of the existing AWS key pair to use"
  type        = string
}
