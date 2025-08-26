# Assignment 4: Terraform Infrastructure Deployment

## Overview

In this assignment, we deployed an AWS infrastructure environment using Terraform with the help of provided tool (MySql). The setup included:

- **VPC** with public and private subnets
- **Security Groups**
- **RDS MySQL Database**
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

## Commands to Deploy

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




---
