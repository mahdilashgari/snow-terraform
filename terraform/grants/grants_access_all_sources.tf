# grant all source system access roles to a consolidated role
resource "snowflake_grant_account_role" "grant_schema_access_to_all_access_sr" {
  provider         = snowflake.useradmin
  for_each         = local.all_sources_roles_access_config
  role_name        = "${each.value.database_name}_${each.value.schema_name}_SR"
  parent_role_name = "${each.value.database_name}_ALL_SOURCES_SR"
}

resource "snowflake_grant_account_role" "grant_schema_access_to_all_access_srw" {
  provider         = snowflake.useradmin
  for_each         = local.all_sources_roles_access_config
  role_name        = "${each.value.database_name}_${each.value.schema_name}_SRW"
  parent_role_name = "${each.value.database_name}_ALL_SOURCES_SRW"
}

resource "snowflake_grant_account_role" "grant_schema_access_to_all_access_sfull" {
  provider         = snowflake.useradmin
  for_each         = local.all_sources_roles_access_config
  role_name        = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  parent_role_name = "${each.value.database_name}_ALL_SOURCES_SFULL"
}
