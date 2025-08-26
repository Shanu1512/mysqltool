# Assignment 4: Terraform Infrastructure Deployment (MySQL Setup on EC2 Using Terraform)

## Overview

This project automates the deployment of a **MySQL primary-replica setup** on AWS EC2 instances using **Terraform**.  
It includes a **bastion host**, private subnets, NAT gateway, and secure access rules. The MySQL database is fully configured via **user-data scripts**.

---

## Architecture
      Internet
         |
    Internet Gateway
         |
    Public Subnet (AZ-a)
    --------------------
    |  Bastion Host    |
    --------------------
         |
    Private Subnets (AZ-a & AZ-b)
    --------------------
    | MySQL Primary   |
    --------------------
    | MySQL Replica   |
    --------------------


In this assignment, we deployed an AWS infrastructure environment using Terraform with the help of provided tool (MySql). The setup included:

- **VPC** with public and private subnets
- **Security Groups**
- **MySQL Database**
- **Terraform State Management** with S3 and DynamoDB

The goal was to implement infrastructure as code and manage Terraform state securely using remote backends.

## Terraform State Management
- Terraform state is stored in an **S3 bucket**.
- **DynamoDB** is used for state locking to prevent concurrent modifications.


* Backend: Amazon S3 bucket

* State Locking: DynamoDB table to prevent concurrent modifications

* Bootstrap: The S3 bucket and DynamoDB table were created initially using a bootstrap setup.

* Commands for bootstrap.tf:
    terraform init
    terraform apply
After creating this s3 and dynamodb table i moved bootstrap in another location

Note: The S3 bucket and DynamoDB table were pre-created for remote state management using bootstrap scripts.


- **Bastion Host**: Provides SSH access to private EC2 instances.
- **MySQL Primary & Replica**: Two instances in separate private subnets (high availability).
- **NAT Gateway**: Enables internet access from private subnets.
- **Security Groups**: Restrict MySQL access to bastion host only.

---

## Terraform Setup

### Files
- `main.tf`: VPC, subnets, route tables, NAT, instances, and security groups.
- `providers.tf`: AWS provider configuration.
- `variables.tf`: Terraform variables.
- `terraform.tfvars`: Variable values for region, instance type, subnets, etc.
- `output.tf`: Displays private/public IPs of MySQL instances.
- `scripts/`: Contains user-data scripts:
  - `mysql_primary.sh`: Installs and configures MySQL primary.
  - `mysql_replica.sh`: Configures MySQL replica.

---

## Deployment Steps

### Commands to Deploy

1. Initialize Terraform:
    * terraform init

2. Validate configuration:
    * terraform validate

3. Plan infrastructure:
    * terraform plan -out=tfplan
    (It saves the plan to a file named tfplan.
    this plan file can be applied later, Useful in CI/CD pipelines where planning and applying are separate steps).

4. Apply infrastructure:
    * terraform apply "tfplan"

5. Destroy infrastructure (if needed):
    * terraform destroy

## Instance and resources on AWS
<img width="1667" height="363" alt="image" src="https://github.com/user-attachments/assets/01dcb25f-619a-43aa-8e51-bfe6fa66f9ff" />

<img width="1629" height="845" alt="image" src="https://github.com/user-attachments/assets/64347a01-bc23-4fea-b630-63e01f21d119" />

## SS of S3 and dynamodb table

<img width="1731" height="1007" alt="Screenshot from 2025-08-19 21-50-15" src="https://github.com/user-attachments/assets/ffadcbdb-f556-473f-aef7-8d023e603ab5" />
<img width="1731" height="1007" alt="Screenshot from 2025-08-19 21-51-05" src="https://github.com/user-attachments/assets/0e60d723-3c90-4a48-9d11-e6d06c2f5803" />


## Access MySQL

SSH into the bastion host:
* ssh -i tfkey.pem ubuntu@<bastion_public_ip>

Connect to MySQL private instances:
* mysql -h <mysql_private_ip> -u root -p

## Database Setup
<img width="1542" height="885" alt="image" src="https://github.com/user-attachments/assets/a4a3431f-dc17-4902-860b-6e237fc32139" />

<img width="1516" height="484" alt="image" src="https://github.com/user-attachments/assets/f631daf8-d0fa-43aa-bf89-f14956a15846" />

### Notes

* MySQL is fully automated via user-data scripts.

* Security groups are pre-configured for bastion-based access.

* Both MySQL instances are in private subnets, ensuring security.

* This setup supports high availability across two AZs.





---
