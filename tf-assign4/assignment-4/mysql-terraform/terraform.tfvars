# VPC and Subnets
vpc_cidr         = "10.0.0.0/16"
public_subnet_a  = "10.0.1.0/24"
private_subnet_a = "10.0.2.0/24"
private_subnet_b = "10.0.3.0/24"

# Instance Type
instance_type = "t2.micro"

# Your EC2 Key Pair (must exist in AWS console)
key_name = "tfkey"
