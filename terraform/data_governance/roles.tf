resource "snowflake_account_role" "role_governance_admin" {
  provider = snowflake.useradmin
  name     = "GOVERNANCE_ADMIN"
  comment  = "Create Tags and Policies"
}

resource "snowflake_account_role" "role_governance_engineer" {
  provider = snowflake.useradmin
  name     = "GOVERNANCE_ENGINEER"
  comment  = "Apply tags"
}

resource "snowflake_account_role" "role_governance_viewer" {
  provider = snowflake.useradmin
  name     = "GOVERNANCE_VIEWER"
  comment  = "View Governance Dashboard"
}

resource "snowflake_account_role" "role_governance_pii_viewer" {
  provider = snowflake.useradmin
  name     = "GOVERNANCE_PII_VIEWER"
  comment  = "Access Role that can view unmasked PII data"
}

resource "snowflake_account_role" "role_governance_pii_viewer_kununu" {
  provider = snowflake.useradmin
  name     = "GOVERNANCE_PII_VIEWER_KUNUNU"
  comment  = "Access Role that can view unmasked PII data for Kununu masking policy"
}

resource "snowflake_account_role" "role_governance_pii_viewer_amqp" {
  provider = snowflake.useradmin
  name     = "GOVERNANCE_PII_VIEWER_AMQP"
  comment  = "Access Role that can view unmasked PII data for AMQP logins masking policy"
}

resource "snowflake_account_role" "role_governance_pii_viewer_salesforce_onlyfy" {
  provider = snowflake.useradmin
  name     = "GOVERNANCE_PII_VIEWER_SALESFORCE_ONLYFY"
  comment  = "Access Role that can view unmasked PII data for SALESFORCE_ONLYFY masking policy"
}

resource "snowflake_account_role" "role_governance_pii_viewer_kafka_dp_ingestion" {
  provider = snowflake.useradmin
  name     = "GOVERNANCE_PII_VIEWER_KAFKA_DP_INGESTION"
  comment  = "Access Role that can view unmasked PII data for KAFKA_DP_INGESTION masking policy"
}

resource "snowflake_account_role" "role_governance_pii_viewer_central_profilebackend" {
  provider = snowflake.useradmin
  name     = "GOVERNANCE_PII_VIEWER_CENTRAL_PROFILEBACKEND"
  comment  = "Access Role that can view unmasked PII data for Central & Profilebackend masking policy"
}
