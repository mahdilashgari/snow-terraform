# compliance admin needs to be able to use db internal and compliance schema

# compliance admin needs to be able to create masking policies in compliance schema
# compliance admin needs to be able to create tags in compliance schema
# compliance admin needs to be able to assiociate masking policies with tags

# compliance engineer needs to be able to apply tags

resource "snowflake_grant_privileges_to_account_role" "internal_db_usage_admin" {
  provider = snowflake.sysadmin

  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.role_governance_admin.name

  on_account_object {
    object_type = "DATABASE"
    object_name = "INTERNAL"
  }

  with_grant_option = false
}

resource "snowflake_grant_privileges_to_account_role" "internal_db_usage_engineer" {
  provider = snowflake.sysadmin

  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.role_governance_engineer.name

  on_account_object {
    object_type = "DATABASE"
    object_name = "INTERNAL"
  }

  with_grant_option = false
}

resource "snowflake_grant_privileges_to_account_role" "internal_db_usage_viewer" {
  provider = snowflake.sysadmin

  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.role_governance_viewer.name

  on_account_object {
    object_type = "DATABASE"
    object_name = "INTERNAL"
  }

  with_grant_option = false
}

resource "snowflake_grant_privileges_to_account_role" "governance_schema_privileges_admin" {
  provider = snowflake.sysadmin

  privileges        = ["USAGE", "CREATE TAG", "CREATE MASKING POLICY"]
  account_role_name = snowflake_account_role.role_governance_admin.name

  on_schema {
    schema_name = "\"INTERNAL\".\"GOVERNANCE\""
  }

  with_grant_option = false
}


resource "snowflake_grant_account_role" "governance_schema_sfull_engineer" {
  provider = snowflake.useradmin

  role_name = "INTERNAL_GOVERNANCE_SFULL"

  parent_role_name = "GOVERNANCE_ENGINEER"
  # enable_multiple_grants = true
}

resource "snowflake_grant_privileges_to_account_role" "governance_schema_privileges_viewer" {
  provider = snowflake.sysadmin

  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.role_governance_viewer.name

  on_schema {
    schema_name = "\"INTERNAL\".\"GOVERNANCE\""
  }

  with_grant_option = false
}

resource "snowflake_grant_account_role" "governance_grant_pii_viewer" {
  provider = snowflake.useradmin

  role_name = snowflake_account_role.role_governance_pii_viewer.name
  for_each = toset([
    "DBT_PIPELINE",
    "BI_READER",
    "BI_DBT",
    "BI_FULL",
    "BU_XING_READER",
    "BU_XING_DBT",
    "BU_ONLYFY_DBT",
    "BU_ONLYFY_READER",
    "BU_XMS_DBT",
    "BU_XMS_READER",
    "BU_XMS_IMPORTER",
    "BU_ONLYFY_IMPORTER",
    "BU_XING_IMPORTER",
    "BI_DIS_PII_VIEWER"
  ])
  parent_role_name = each.key

  # enable_multiple_grants = true
}

resource "snowflake_grant_account_role" "governance_grant_pii_viewer_kununu" {
  provider = snowflake.useradmin

  role_name = snowflake_account_role.role_governance_pii_viewer_kununu.name
  for_each  = toset(["BU_KUNUNU_PII_VIEWER", "BU_KUNUNU_ADHOC"])
  # roles = [
  #   "BU_KUNUNU_PII_VIEWER",
  #   "BU_KUNUNU_ADHOC"
  # ]
  parent_role_name = each.key
  #enable_multiple_grants = true
}

resource "snowflake_grant_account_role" "governance_grant_pii_viewer_amqp" {
  provider = snowflake.useradmin

  role_name = snowflake_account_role.role_governance_pii_viewer_amqp.name
  for_each  = toset(["NWSE_PII_VIEWER", "BU_NWSE_ADHOC"])
  # roles = [
  #   "NWSE_PII_VIEWER",
  #   "BU_NWSE_ADHOC"
  # ]
  parent_role_name = each.key
  # enable_multiple_grants = true
}

resource "snowflake_grant_account_role" "governance_grant_pii_viewer_salesforce_onlyfy" {
  provider = snowflake.useradmin

  role_name        = snowflake_account_role.role_governance_pii_viewer_salesforce_onlyfy.name
  for_each         = toset(["SALESFORCE_ONLYFY_PII_VIEWER", "BU_ONLYFY_ADHOC"])
  parent_role_name = each.key
}

resource "snowflake_grant_account_role" "governance_grant_pii_viewer_kafka_dp_ingestion" {
  provider = snowflake.useradmin

  role_name        = snowflake_account_role.role_governance_pii_viewer_kafka_dp_ingestion.name
  for_each         = toset(["KAFKA_DP_INGESTION_PII_VIEWER"])
  parent_role_name = each.key
}

resource "snowflake_grant_account_role" "governance_grant_pii_viewer_central_profilebackend" {
  provider = snowflake.useradmin

  role_name = snowflake_account_role.role_governance_pii_viewer_central_profilebackend.name
  for_each  = toset(["CENTRAL_PROFILEBACKEND_PII_VIEWER"])

  parent_role_name = each.key
}
