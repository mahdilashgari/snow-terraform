terraform {
  source = "../..//terraform"
}

locals {
  account_id              = get_aws_account_id()
  aws_region              = ""
  environment_type        = "production"
  environment_name        = "snowflake-prod"
  application             = "snowflake-terraform-configuration"
  team_name               = "business-intelligence"
  contact_email           = "bicc@xingag.onmicrosoft.com"
  business_unit           = "central-services"
  cost_center             = "60123"
  # do not adjust these
  github_repo             = "new-work/bi-snowflake-terraform"
  remote_state_bucket     = "nw-bucket-terraform-state-nw-${local.account_id}-${local.environment_name}"
  remote_state_key        = "${local.application}/${local.environment_name}_version_2/terraform.tfstate"
  remote_state_lock_table = "nw-ddbtable-terraform-state-snowflake_version_2"

  snowflake_config_filepath  = "${get_terragrunt_dir()}"

  tags = {
    application         = local.application
    environment_type    = local.environment_type
    environment_name    = local.environment_name
    team_name           = local.team_name
    contact_email       = local.contact_email
    business_unit       = local.business_unit
    cost_center         = local.cost_center
    data_classification = "private"
    provisioned_by      = "terragrunt"
  }
}

remote_state {
  backend = "s3"
  config = {
    bucket              = local.remote_state_bucket
    key                 = local.remote_state_key
    s3_bucket_tags      = local.tags
    region              = "eu-central-1"
    dynamodb_table      = local.remote_state_lock_table
    dynamodb_table_tags = local.tags
    encrypt             = true
    acl                 = "private"
  }
}

prevent_destroy = false

inputs = {
  application                         = local.application
  aws_region                          = local.aws_region
  environment_type                    = local.environment_type
  environment_name                    = local.environment_name
  team_name                           = local.team_name
  contact_email                       = local.contact_email
  business_unit                       = local.business_unit
  cost_center                         = local.cost_center
  github_repo                         = local.github_repo
  remote_state_bucket                 = local.remote_state_bucket
  remote_state_key                    = local.remote_state_key
  remote_state_lock_table             = local.remote_state_lock_table
  snowflake_username                  = get_env("TF_VAR_SNOWFLAKE_USERNAME")
  snowflake_account                   = get_env("TF_VAR_SNOWFLAKE_ACCOUNT")
  snowflake_org                       = get_env("TF_VAR_SNOWFLAKE_ORG_NAME")
  snowflake_private_key               = get_env("TF_VAR_SNOWFLAKE_PRIVATE_KEY")
  snowflake_default_password          = get_env("TF_VAR_SNOWFLAKE_DEFAULT_PASSWORD")
  snowflake_region                    = local.aws_region # same as aws
  snowflake_config_filepath           = local.snowflake_config_filepath
  braze_xing_aws_key_id               = get_env("TF_VAR_BRAZE_XING_AWS_KEY_ID")
  braze_xing_aws_secret_key           = get_env("TF_VAR_BRAZE_XING_AWS_SECRET_KEY")
  braze_onlyfy_aws_key_id             = get_env("TF_VAR_BRAZE_ONLYFY_AWS_KEY_ID")
  braze_onlyfy_aws_secret_key         = get_env("TF_VAR_BRAZE_ONLYFY_AWS_SECRET_KEY")
  funnelio_aws_key_id                 = get_env("TF_VAR_FUNNELIO_AWS_KEY_ID")
  funnelio_aws_secret_key             = get_env("TF_VAR_FUNNELIO_AWS_SECRET_KEY")
  onlyfy_jobs_aws_key_id              = get_env("TF_VAR_ONLYFY_JOBS_AWS_KEY_ID")
  onlyfy_jobs_aws_secret_key          = get_env("TF_VAR_ONLYFY_JOBS_AWS_SECRET_KEY")
  onlyfy_jobs_kms_secret_key          = get_env("TF_VAR_ONLYFY_JOBS_KMS_SECRET_KEY")
  onlyfy_aws_key_id                   = get_env("TF_VAR_ONLYFY_AWS_KEY_ID")
  onlyfy_aws_secret_key               = get_env("TF_VAR_ONLYFY_AWS_SECRET_KEY")
  onlyfy_kms_secret_key               = get_env("TF_VAR_ONLYFY_KMS_SECRET_KEY")
  xing_kpi_export_prod_aws_key_id     = get_env("TF_VAR_XING_KPI_EXPORT_PROD_AWS_KEY_ID")
  xing_kpi_export_prod_aws_secret_key = get_env("TF_VAR_XING_KPI_EXPORT_PROD_AWS_SECRET_KEY")
  xing_kpi_export_test_aws_key_id     = get_env("TF_VAR_XING_KPI_EXPORT_TEST_AWS_KEY_ID")
  xing_kpi_export_test_aws_secret_key = get_env("TF_VAR_XING_KPI_EXPORT_TEST_AWS_SECRET_KEY")  
  the_trade_desk_aws_key_id           = get_env("TF_VAR_THE_TRADE_DESK_AWS_KEY_ID")
  the_trade_desk_aws_secret_key       = get_env("TF_VAR_THE_TRADE_DESK_AWS_SECRET_KEY")

  network = {
    vpc_cidr                = "172.16.0.0/16"
    azs                     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
    private_subnets         = ["172.16.10.0/24", "172.16.20.0/24", "172.16.30.0/24"]
    public_subnets          = ["172.16.100.0/24", "172.16.120.0/24", "172.16.130.0/24"]
  }
}
