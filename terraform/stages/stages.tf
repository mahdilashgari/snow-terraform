resource "snowflake_stage" "landing_zone_stages" {
  for_each            = local.source_system_schemas_config
  provider            = snowflake.sysadmin
  name                = "BI_STAGE"
  url                 = "s3://nwse-bi-staging-prod"
  database            = "LANDING_ZONE"
  schema              = each.value.name
  comment             = "Stage that loads data from our S3 Bucket"
  storage_integration = "S3_BI" # needs to exist and needs to be created by accountadmin 

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "bi_kpi_export_prod_stages" {
  provider            = snowflake.sysadmin
  for_each            = toset(["CENTRAL", "ONLYFY", "XMS", "XING"])
  name                = "S3_BI_KPI_EXPORT_PROD_STAGE"
  url                 = "s3://bi-kpi-export-prod"
  database            = "ANALYTICS"
  schema              = each.value
  comment             = "Stage that loads data from Snowflake into prod S3 Bucket meant for exporting data"
  storage_integration = "S3_BI_KPI_EXPORT_PROD" # needs to exist and needs to be created by accountadmin 

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "bi_kpi_export_test_stages" {
  provider            = snowflake.sysadmin
  for_each            = toset(["CENTRAL", "ONLYFY", "XMS", "XING"])
  name                = "S3_BI_KPI_EXPORT_TEST_STAGE"
  url                 = "s3://bi-kpi-export-test"
  database            = "ANALYTICS"
  schema              = each.value
  comment             = "Stage that loads data from Snowflake into preview S3 Bucket meant for exporting data"
  storage_integration = "S3_BI_KPI_EXPORT_TEST" # needs to exist and needs to be created by accountadmin 

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "bi_kununu_export_prod_stages" {
  provider            = snowflake.sysadmin
  for_each            = toset(["CENTRAL"])
  name                = "S3_BI_KUNUNU_EXPORT_PROD_STAGE"
  url                 = "s3://bi-kununu-export-prod"
  database            = "ANALYTICS"
  schema              = each.value
  comment             = "Stage that loads data from Snowflake into prod S3 Bucket meant for exporting data to specifically kununu"
  storage_integration = "S3_BI_KUNUNU_EXPORT_PROD" # needs to exist and needs to be created by accountadmin 

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "bi_kununu_export_test_stages" {
  provider            = snowflake.sysadmin
  for_each            = toset(["CENTRAL"])
  name                = "S3_BI_KUNUNU_EXPORT_TEST_STAGE"
  url                 = "s3://bi-kununu-export-test"
  database            = "ANALYTICS"
  schema              = each.value
  comment             = "Stage that loads data from Snowflake into preview S3 Bucket meant for exporting data to specificly Kununu"
  storage_integration = "S3_BI_KUNUNU_EXPORT_TEST" # needs to exist and needs to be created by accountadmin 

  lifecycle {
    prevent_destroy = false
  }
}


resource "snowflake_stage" "braze_xing_stage_landing_zone" {
  provider    = snowflake.sysadmin
  for_each    = toset(["BRAZE_XING", "BRAZE_API_XING"])
  name        = "BRAZE_XING_STAGE"
  url         = "s3://xing-appboy/"
  database    = "LANDING_ZONE"
  schema      = each.value
  comment     = "Stage that connects to XING's braze s3 bucket"
  credentials = "AWS_KEY_ID='${var.braze_xing_aws_key_id}' AWS_SECRET_KEY='${var.braze_xing_aws_secret_key}'"

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "braze_onlyfy_stage_landing_zone" {
  provider    = snowflake.sysadmin
  name        = "BRAZE_ONLYFY_STAGE"
  url         = "s3://nw-bucket-production-berrymarketing/currents/dataexport.prod-01.S3.integration.637b20bfe6d41508f14d68d8/"
  database    = "LANDING_ZONE"
  schema      = "BRAZE_ONLYFY"
  comment     = "Stage that loads data"
  credentials = "AWS_KEY_ID='${var.braze_onlyfy_aws_key_id}' AWS_SECRET_KEY='${var.braze_onlyfy_aws_secret_key}'"

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "onlyfy_jobs_stage_landing_zone" {
  provider    = snowflake.sysadmin
  name        = "ONLYFY_JOBS_STAGE"
  url         = "s3://084296567691-rds-data-export/jobs-backend-database/"
  database    = "LANDING_ZONE"
  schema      = "ONLYFY_JOBS"
  comment     = "Stage that loads data"
  credentials = "AWS_KEY_ID='${var.onlyfy_jobs_aws_key_id}' AWS_SECRET_KEY='${var.onlyfy_jobs_aws_secret_key}'"
  encryption  = "TYPE='AWS_SSE_KMS' KMS_KEY_ID='${var.onlyfy_jobs_kms_secret_key}'"
  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "onlyfy_stage_landing_zone" {
  provider    = snowflake.sysadmin
  for_each    = toset(["MARIADB_PRESCREEN", "MARIADB_TALENTHUB", "MARIADB_ECOM", "MARIADB_EMPLOYER_BRANDING_PROFILE"])
  name        = "ONLYFY_STAGE"
  url         = "s3://084296567691-rds-data-export/"
  database    = "LANDING_ZONE"
  schema      = each.value
  comment     = "Connects to S3 bucket that contains Onlyfy Database exports"
  credentials = "AWS_KEY_ID='${var.onlyfy_aws_key_id}' AWS_SECRET_KEY='${var.onlyfy_aws_secret_key}'"
  encryption  = "TYPE='AWS_SSE_KMS' KMS_KEY_ID='${var.onlyfy_kms_secret_key}'"
  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "funnelio_stage_landing_zone" {
  provider    = snowflake.sysadmin
  name        = "FUNNELIO_STAGE"
  url         = "s3://nw-bucket-funnelio-import/"
  database    = "LANDING_ZONE"
  schema      = "FUNNELIO"
  comment     = "Stage that loads data from S3 bucket"
  credentials = "AWS_KEY_ID='${var.funnelio_aws_key_id}' AWS_SECRET_KEY='${var.funnelio_aws_secret_key}'"

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "the_trade_desk_stage_landing_zone" {
  provider    = snowflake.sysadmin
  for_each    = toset(["THE_TRADE_DESK"])
  name        = "THE_TRADE_DESK_STAGE"
  url         = "s3://thetradedesk-useast-partner-datafeed/dataproviders/reports/xing/"
  database    = "LANDING_ZONE"
  schema      = each.value
  comment     = "Stage that connects to S3 of marketing realtime ad partner The Trade Desk"
  credentials = "AWS_KEY_ID='${var.the_trade_desk_aws_key_id}' AWS_SECRET_KEY='${var.the_trade_desk_aws_secret_key}'"

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "landing_zone_preview_stages" {
  for_each            = local.source_system_schemas_config
  provider            = snowflake.sysadmin
  name                = "BI_STAGE_PREVIEW"
  url                 = "s3://nwse-bi-staging-test"
  database            = "LANDING_ZONE"
  schema              = each.value.name
  comment             = "Stage that loads data from our S3 Preview Bucket"
  storage_integration = "S3_BI_PREVIEW" # needs to exist and needs to be created by accountadmin 

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "xing_kpi_export_prod_stages" {
  provider    = snowflake.sysadmin
  for_each    = toset(["XING"])
  name        = "S3_XING_KPI_EXPORT_PROD_STAGE"
  url         = "s3://nw-bucket-production-jobs-statistics-reports"
  database    = "ANALYTICS"
  schema      = each.value
  comment     = "Productive Stage to export data from Snowflake into S3, Bucket meant for exporting performance metrics data by Xing teams (Xing Analytics) then shared via api with their customers"
  credentials = "AWS_KEY_ID='${var.xing_kpi_export_prod_aws_key_id}' AWS_SECRET_KEY='${var.xing_kpi_export_prod_aws_secret_key}'"

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "xing_kpi_export_test_stages" {
  provider    = snowflake.sysadmin
  for_each    = toset(["XING"])
  name        = "S3_XING_KPI_EXPORT_TEST_STAGE"
  url         = "s3://nw-bucket-preview-jobs-statistics-reports"
  database    = "ANALYTICS"
  schema      = each.value
  comment     = "Testing Stage to export data from Snowflake into S3, Bucket meant to test the exports for performance metrics data by Xing teams (Xing Analytics)"
  credentials = "AWS_KEY_ID='${var.xing_kpi_export_test_aws_key_id}' AWS_SECRET_KEY='${var.xing_kpi_export_test_aws_secret_key}'"

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "landing_zone_marketing_stages" {
  for_each            = local.source_system_schemas_config
  provider            = snowflake.sysadmin
  name                = "MARKETING_STAGE"
  url                 = "s3://nwse-bi-marketing-prod"
  database            = "LANDING_ZONE"
  schema              = each.value.name
  comment             = "Stage that loads data from our S3 Marketing Bucket"
  storage_integration = "S3_MARKETING" # needs to exist and needs to be created by accountadmin 

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "analytics_unload_stage" {
  provider  = snowflake.sysadmin
  for_each  = toset(["CENTRAL", "ONLYFY", "XMS", "XING"])
  name      = "ANALYTICS_UNLOAD_STAGE"
  database  = "ANALYTICS"
  schema    = each.value
  directory = "ENABLE = true"
  comment   = "Stage that is used to unload data from Snowflake into internal meant for exporting data locally"

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "analytics_workarea_stage" {
  provider = snowflake.sysadmin
  for_each = toset(["CENTRAL", "ONLYFY", "XMS", "XING", "GENERAL"])
  name     = "ANALYTICS_WORKAREA_STAGE"
  database = "ANALYTICS_WORKAREA"
  schema   = each.value
  comment  = "Stage that is used by public users to load data from files into Snowflake"

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "bi_snowflake_export_prod_stages" {
  provider            = snowflake.sysadmin
  for_each            = toset(["CENTRAL"])
  name                = "S3_BI_SNOWFLAKE_EXPORT_PROD_STAGE"
  url                 = "s3://bi-snowflake-export-prod"
  database            = "ANALYTICS"
  schema              = each.value
  comment             = "Stage that is used to unload data from Snowflake into S3"
  storage_integration = "S3_SNOWFLAKE_EXPORT_PROD"

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "bi_snowflake_export_test_stages" {
  provider            = snowflake.sysadmin
  for_each            = toset(["CENTRAL"])
  name                = "S3_BI_SNOWFLAKE_EXPORT_TEST_STAGE"
  url                 = "s3://bi-snowflake-export-test"
  database            = "ANALYTICS"
  schema              = each.value
  comment             = "Stage that is used to unload data from Snowflake into S3"
  storage_integration = "S3_SNOWFLAKE_EXPORT_TEST"

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "bi_snowflake_export_to_databse_prod_stages" {
  provider            = snowflake.sysadmin
  for_each            = toset(["CENTRAL", "ONLYFY", "XMS", "XING"])
  name                = "S3_BI_SNOWFLAKE_EXPORT_TO_DATABASE_PROD_STAGE"
  url                 = "s3://bi-snowflake-export-prod/snowflake_to_database"
  database            = "ANALYTICS"
  schema              = each.value
  comment             = "Stage that is used to unload data from Snowflake into S3 in order to load finally into RDS"
  storage_integration = "S3_SNOWFLAKE_EXPORT_PROD"

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "bi_snowflake_export_to_database_test_stages" {
  provider            = snowflake.sysadmin
  for_each            = toset(["CENTRAL", "ONLYFY", "XMS", "XING"])
  name                = "S3_BI_SNOWFLAKE_EXPORT_TO_DATABASE_TEST_STAGE"
  url                 = "s3://bi-snowflake-export-test/snowflake_to_database"
  database            = "ANALYTICS"
  schema              = each.value
  comment             = "Stage that is used to unload data from Snowflake into S3 in order to load finally into RDS"
  storage_integration = "S3_SNOWFLAKE_EXPORT_TEST"

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "jobs_platform_snowflake_stg_prev" {
  provider            = snowflake.sysadmin
  name                = "S3_XING_JOBS_PLATFORM_STG_PREVIEW"
  url                 = "s3://jobs-platform-snowflake-staging-prev"
  database            = "ANALYTICS"
  schema              = "XING"
  comment             = "Stage that is used to unload data from Snowflake into S3 in order to load finally into Mysql db"
  storage_integration = "S3_XING_JOBS_PLATFORM_STAGE_PREVIEW"

  lifecycle {
    prevent_destroy = false
  }
}

resource "snowflake_stage" "jobs_platform_snowflake_stg_prod" {
  provider            = snowflake.sysadmin
  name                = "S3_XING_JOBS_PLATFORM_STAGE_PRODUCTION"
  url                 = "s3://jobs-platform-snowflake-staging-prod"
  database            = "ANALYTICS"
  schema              = "XING"
  comment             = "Stage that is used to unload data from Snowflake into S3 in order to load finally into Mysql db"
  storage_integration = "S3_XING_JOBS_PLATFORM_STG_PRODUCTION"

  lifecycle {
    prevent_destroy = false
  }
}