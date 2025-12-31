terraform {
  required_version = "~> 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~> 2.3"
    }

  }


  # Backend is defined in the Terragrunt configuration
  # See ../environments/staging/terragrunt.hcl
  backend "s3" {
  }
}

provider "aws" {
  region = "eu-central-1"

  # Provide tags for all resources maintained by Terraform
  # See https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html#tag-categories
  default_tags {
    tags = local.default_tags
  }
}

provider "snowflake" {
  alias                    = "securityadmin"
  user                     = var.snowflake_username
  account_name             = var.snowflake_account
  organization_name        = var.snowflake_org
  private_key              = var.snowflake_private_key
  authenticator            = "SNOWFLAKE_JWT"
  role                     = "SECURITYADMIN"
  preview_features_enabled = ["snowflake_network_policy_attachment_resource", "snowflake_stage_resource"]
}

provider "snowflake" {
  alias                    = "useradmin"
  user                     = var.snowflake_username
  account_name             = var.snowflake_account
  organization_name        = var.snowflake_org
  private_key              = var.snowflake_private_key
  authenticator            = "SNOWFLAKE_JWT"
  role                     = "USERADMIN"
  preview_features_enabled = ["snowflake_network_policy_attachment_resource", "snowflake_stage_resource"]
}

provider "snowflake" {
  alias                    = "sysadmin"
  user                     = var.snowflake_username
  account_name             = var.snowflake_account
  organization_name        = var.snowflake_org
  private_key              = var.snowflake_private_key
  authenticator            = "SNOWFLAKE_JWT"
  role                     = "SYSADMIN"
  preview_features_enabled = ["snowflake_network_policy_attachment_resource", "snowflake_stage_resource"]
}

provider "snowflake" {
  alias                    = "governance_admin"
  user                     = var.snowflake_username
  account_name             = var.snowflake_account
  organization_name        = var.snowflake_org
  private_key              = var.snowflake_private_key
  authenticator            = "SNOWFLAKE_JWT"
  role                     = "GOVERNANCE_ADMIN"
  warehouse                = "BI_DBT_WH_XSMALL"
  preview_features_enabled = ["snowflake_network_policy_attachment_resource", "snowflake_stage_resource"]
}
