#allows analytics layer to be created as views on top of staging layer
resource "snowflake_grant_account_role" "grant_staging_read_to_analytics_sfull" {
  provider = snowflake.useradmin
  for_each = toset([
    "CENTRAL", "XING", "ONLYFY", "XMS"
  ])
  role_name        = "ANALYTICS_${each.value}_STAGING_SR"
  parent_role_name = "ANALYTICS_${each.value}_SFULL"
}

# allows staging layer to be created as views on top of raw layer
resource "snowflake_grant_account_role" "grant_raw_read_to_staging_sfull" {
  provider = snowflake.useradmin
  for_each = toset([
    "CENTRAL", "XING", "ONLYFY", "XMS"
  ])
  role_name        = "RAW_ALL_SOURCES_SR"
  parent_role_name = "ANALYTICS_${each.value}_STAGING_SFULL"
}

# allows analytics layer to be created as views on top of raw layer
resource "snowflake_grant_account_role" "grant_raw_read_to_analytics_sfull" {
  provider = snowflake.useradmin
  for_each = toset([
    "CENTRAL", "XING", "ONLYFY", "XMS", "FINANCE"
  ])
  role_name        = "RAW_ALL_SOURCES_SR"
  parent_role_name = "ANALYTICS_${each.value}_SFULL"
}

resource "snowflake_grant_account_role" "grant_read_dbt_metadata_to_analytics_cenral_sfull" {
  provider         = snowflake.useradmin
  role_name        = "RAW_DBT_METADATA_SR"
  parent_role_name = "ANALYTICS_CENTRAL_SFULL"
}

resource "snowflake_grant_account_role" "grant_read_dbt_metadata_to_analytics_cenral_staging_sfull" {
  provider         = snowflake.useradmin
  role_name        = "RAW_DBT_METADATA_SR"
  parent_role_name = "ANALYTICS_CENTRAL_STAGING_SFULL"
}

# allows to read and process the latest metadata from landing_zone
resource "snowflake_grant_account_role" "grant_read_dbt_metadata_to_raw_sfull" {
  provider         = snowflake.useradmin
  role_name        = "LANDING_ZONE_DBT_METADATA_SR"
  parent_role_name = "RAW_DBT_METADATA_SFULL"
}

resource "snowflake_grant_account_role" "grant_read_snowflake_metadata_to_raw_sfull" {
  provider         = snowflake.useradmin
  role_name        = "LANDING_ZONE_SNOWFLAKE_METADATA_SR"
  parent_role_name = "RAW_SNOWFLAKE_METADATA_SFULL"
}
