# AWS-IaC

# AWS Web Server Infrastructure Deployment

## Overview

This repository contains Terraform code for deploying a basic web server infrastructure on AWS. The setup includes provisioning a VPC, Internet Gateway, Route Table, Subnet, Security Group, Network Interface, an Elastic IP, and an EC2 instance for the web server.

The project is designed as an Infrastructure as Code (IaC) practice to demonstrate proficiency in automating cloud environments using Terraform.

**Note:** Certain resources like EC2 instances and Elastic IPs are commented out to prevent accidental charges. The code serves as a template and a real demonstration of deploying a production-like web server on AWS.

## Prerequisites

- AWS Account
- Terraform installed on your local machine
- AWS CLI configured with access_key and secret_key for authentication

## Terraform Version

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.43.0"
    }
  }
}
```

## Usage

1. Clone the repository to your local machine.
2. Navigate to the cloned directory.
3. Initialize the Terraform environment:

```
terraform init
```

4. (Optional) Modify the Terraform variables in `variables.tf` to fit your requirements.
5. Plan the Terraform execution:

```
terraform plan
```

6. Apply the Terraform code:

```
terraform apply
```

Confirm the apply when prompted.

## Resources Created

- **VPC** - A virtual private cloud to securely contain the AWS resources.
- **Internet Gateway** - A gateway attached to the VPC for internet connectivity.
- **Route Table** - Routing rules for directing network traffic.
- **Subnet** - A subdivision of the VPC for hosting the web server.
- **Security Group** - Firewall rules governing inbound and outbound traffic to the server.
- **Network Interface** - A network interface with a private IP within the subnet.

## Security

For authentication, you need to provide your AWS access and secret keys. Do not store your credentials in your code. Instead, use environment variables or the AWS CLI configuration file to manage credentials securely.

```hcl
provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key_var
  secret_key = var.secret_key_var
}
```

## Tags

Each resource is tagged appropriately to ensure clear identification and management within the AWS console.


## License

[MIT](https://choosealicense.com/licenses/mit/)

---

