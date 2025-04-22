# Main Terraform configuration file for AWS infrastructure
# This file defines the core provider settings and references other modules

provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}

# You can include modular .tf files like:
# - rds_with_secrets.tf
# - ecs_service.tf
# Those will be automatically picked up
