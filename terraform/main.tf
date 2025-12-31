module "users_technical" {
  source = "./users_technical"
  providers = {
    snowflake.useradmin     = snowflake.useradmin,
    snowflake.securityadmin = snowflake.securityadmin
  }

  snowflake_config_filepath  = var.snowflake_config_filepath
  snowflake_default_password = var.snowflake_default_password

}

module "roles" {
  source = "./roles"
  providers = {
    snowflake.useradmin = snowflake.useradmin
  }
  snowflake_config_filepath = var.snowflake_config_filepath
}

module "databases" {
  source = "./databases"
  providers = {
    snowflake.sysadmin = snowflake.sysadmin
  }
  snowflake_config_filepath = var.snowflake_config_filepath

  depends_on = [
    module.roles
  ]

}

module "stages" {
  source = "./stages"
  providers = {
    snowflake.sysadmin = snowflake.sysadmin
  }
  snowflake_config_filepath           = var.snowflake_config_filepath
  braze_xing_aws_key_id               = var.braze_xing_aws_key_id
  braze_xing_aws_secret_key           = var.braze_xing_aws_secret_key
  braze_onlyfy_aws_key_id             = var.braze_onlyfy_aws_key_id
  braze_onlyfy_aws_secret_key         = var.braze_onlyfy_aws_secret_key
  funnelio_aws_key_id                 = var.funnelio_aws_key_id
  funnelio_aws_secret_key             = var.funnelio_aws_secret_key
  onlyfy_jobs_aws_key_id              = var.onlyfy_jobs_aws_key_id
  onlyfy_jobs_aws_secret_key          = var.onlyfy_jobs_aws_secret_key
  onlyfy_jobs_kms_secret_key          = var.onlyfy_jobs_kms_secret_key
  onlyfy_aws_key_id                   = var.onlyfy_aws_key_id
  onlyfy_aws_secret_key               = var.onlyfy_aws_secret_key
  onlyfy_kms_secret_key               = var.onlyfy_kms_secret_key
  xing_kpi_export_prod_aws_key_id     = var.xing_kpi_export_prod_aws_key_id
  xing_kpi_export_prod_aws_secret_key = var.xing_kpi_export_prod_aws_secret_key
  xing_kpi_export_test_aws_key_id     = var.xing_kpi_export_test_aws_key_id
  xing_kpi_export_test_aws_secret_key = var.xing_kpi_export_test_aws_secret_key
  the_trade_desk_aws_key_id           = var.the_trade_desk_aws_key_id
  the_trade_desk_aws_secret_key       = var.the_trade_desk_aws_secret_key

  depends_on = [
    module.databases
  ]

}

module "warehouses" {
  source = "./warehouses"
  providers = {
    snowflake.sysadmin = snowflake.sysadmin
  }

  depends_on = [
    module.roles
  ]
  snowflake_config_filepath = var.snowflake_config_filepath
}

module "grants" {
  source = "./grants"
  providers = {
    snowflake.sysadmin      = snowflake.sysadmin,
    snowflake.useradmin     = snowflake.useradmin,
    snowflake.securityadmin = snowflake.securityadmin
  }

  depends_on = [
    module.roles,
    module.databases,
    module.warehouses
  ]
  snowflake_config_filepath = var.snowflake_config_filepath
}

module "data_governance" {
  source = "./data_governance"
  providers = {
    snowflake.sysadmin         = snowflake.sysadmin
    snowflake.governance_admin = snowflake.governance_admin
    snowflake.useradmin        = snowflake.useradmin
  }

  depends_on = [
    module.roles,
    module.databases
  ]
  snowflake_config_filepath = var.snowflake_config_filepath
}
