
##################################################
# VPC
##################################################
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "assignment4-vpc"
  }
}

##################################################
# Internet Gateway
##################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "assignment4-igw"
  }
}

##################################################
# Public Subnet (1 AZ)
##################################################
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_a
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-a"
  }
}

##################################################
# Private Subnets (2 AZs)
##################################################
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_a
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-subnet-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_b
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-subnet-b"
  }
}

##################################################
# Elastic IP for NAT
##################################################
resource "aws_eip" "nat" {

  tags = {
    Name = "nat-eip"
  }
}

##################################################
# NAT Gateway
##################################################
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name = "nat-gateway"
  }
}

##################################################
# Route Tables
##################################################
# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_a_assoc" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private_a_assoc" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b_assoc" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}

##################################################
# Bastion Host (Public)
##################################################
resource "aws_instance" "bastion" {
  ami           = var.ubuntu_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_a.id
  key_name      = var.key_name

  tags = {
    Name = "bastion-host"
  }
}

##################################################
# Security Group for MySQL
##################################################
resource "aws_security_group" "mysql_sg" {
  name        = "mysql-sg"
  description = "Allow MySQL access from bastion"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for Bastion
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.main.id

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

##################################################
# MySQL EC2 Instances (Private Subnets)
##################################################
resource "aws_instance" "mysql_a" {
  ami                    = var.ubuntu_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_a.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.mysql_sg.id]

 user_data = file("${path.module}/scripts/mysql_primary.sh")

  tags = {
    Name = "mysql-primary"
  }
}

resource "aws_instance" "mysql_b" {
  ami                    = var.ubuntu_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_b.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.mysql_sg.id]

  user_data = file("${path.module}/scripts/mysql_replica.sh")

  tags = {
    Name = "mysql-replica"
  }
}
