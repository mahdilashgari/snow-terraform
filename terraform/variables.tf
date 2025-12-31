variable "application" {
  type = string

  validation {
    condition     = length(var.application) > 0
    error_message = "Provide your application name."
  }
}

variable "aws_region" {
  type = string
}

variable "environment_type" {
  type = string

  validation {
    condition     = contains(["production", "sandbox", "staging", "snowflake-prod", "preview"], var.environment_type)
    error_message = "Provide valid environment (production, sandbox, staging, snowflake-prod)."
  }
}

variable "environment_name" {
  type = string

  validation {
    condition     = length(var.environment_name) > 0
    error_message = "Provide meaningful environment name."
  }
}

variable "team_name" {
  type = string

  validation {
    condition     = length(var.team_name) > 0
    error_message = "Provide your team name."
  }
}

variable "contact_email" {
  type = string

  validation {
    condition     = length(var.contact_email) > 0
    error_message = "Provide your contact email."
  }
}

variable "business_unit" {
  type = string

  validation {
    condition     = length(var.business_unit) > 0
    error_message = "Provide business unit name."
  }
}

variable "cost_center" {
  type = string

  validation {
    condition     = length(var.cost_center) > 0
    error_message = "Provide applicable cost center."
  }
}

variable "network" {
  type = object({
    vpc_cidr        = string
    azs             = set(string)
    private_subnets = set(string)
    public_subnets  = set(string)
  })
}

variable "github_repo" {
  type = string
}

variable "remote_state_bucket" {
  type = string
}

variable "remote_state_key" {
  type = string
}

variable "remote_state_lock_table" {
  type = string
}

variable "snowflake_username" {
  type = string
}

variable "snowflake_org" {
  type = string
}

variable "snowflake_account" {
  type = string
}

variable "snowflake_region" {
  type = string
}

variable "snowflake_private_key" {
  type      = string
  sensitive = true
}

variable "snowflake_default_password" {
  type      = string
  sensitive = true
}

variable "snowflake_config_filepath" {
  type = string
}

variable "braze_xing_aws_key_id" {
  type = string
}

variable "braze_xing_aws_secret_key" {
  type      = string
  sensitive = true
}

variable "braze_onlyfy_aws_key_id" {
  type = string
}

variable "braze_onlyfy_aws_secret_key" {
  type      = string
  sensitive = true
}

variable "funnelio_aws_key_id" {
  type = string
}

variable "funnelio_aws_secret_key" {
  type      = string
  sensitive = true
}

variable "onlyfy_jobs_aws_key_id" {
  type = string
}

variable "onlyfy_jobs_aws_secret_key" {
  type      = string
  sensitive = true
}

variable "onlyfy_jobs_kms_secret_key" {
  type      = string
  sensitive = true
}

variable "onlyfy_aws_key_id" {
  type = string
}

variable "onlyfy_aws_secret_key" {
  type      = string
  sensitive = true
}

variable "onlyfy_kms_secret_key" {
  type      = string
  sensitive = true
}

variable "xing_kpi_export_prod_aws_key_id" {
  type      = string
  sensitive = true
}

variable "xing_kpi_export_prod_aws_secret_key" {
  type      = string
  sensitive = true
}

variable "xing_kpi_export_test_aws_key_id" {
  type      = string
  sensitive = true
}

variable "xing_kpi_export_test_aws_secret_key" {
  type      = string
  sensitive = true
}

variable "the_trade_desk_aws_key_id" {
  type      = string
  sensitive = true
}

variable "the_trade_desk_aws_secret_key" {
  type      = string
  sensitive = true
}