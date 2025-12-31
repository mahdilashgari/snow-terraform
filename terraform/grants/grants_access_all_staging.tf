# grant all source system access roles to a consolidated role
resource "snowflake_grant_account_role" "grant_schema_access_to_all_staging_access_sr" {
  provider         = snowflake.useradmin
  for_each         = local.all_staging_roles_access_config
  role_name        = "${each.value.database_name}_${each.value.schema_name}_SR"
  parent_role_name = "${each.value.database_name}_ALL_SCHEMAS_SR"
}

resource "snowflake_grant_account_role" "grant_schema_access_to_all_staging_access_srw" {
  provider         = snowflake.useradmin
  for_each         = local.all_staging_roles_access_config
  role_name        = "${each.value.database_name}_${each.value.schema_name}_SRW"
  parent_role_name = "${each.value.database_name}_ALL_SCHEMAS_SRW"
}

resource "snowflake_grant_account_role" "grant_schema_access_to_all_staging_access_sfull" {
  provider         = snowflake.useradmin
  for_each         = local.all_staging_roles_access_config
  role_name        = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  parent_role_name = "${each.value.database_name}_ALL_SCHEMAS_SFULL"
}
