resource "snowflake_account_role" "roles_access_sr" {
  provider = snowflake.useradmin
  for_each = local.roles_access_config
  name     = "${each.value.database_name}_${each.value.schema_name}_SR"
  comment  = "Schema Read Access"
}

resource "snowflake_account_role" "roles_access_srw" {
  provider = snowflake.useradmin
  for_each = local.roles_access_config
  name     = "${each.value.database_name}_${each.value.schema_name}_SRW"
  comment  = "Schema Read/Write Access"
}

resource "snowflake_account_role" "roles_access_sfull" {
  provider = snowflake.useradmin
  for_each = local.roles_access_config
  name     = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  comment  = "Schema Full Access"
}

# # these access roles can be used to easily grant access to all source system schemas
resource "snowflake_account_role" "roles_access_all_source_schemas_sr" {
  provider = snowflake.useradmin
  for_each = local.source_system_databases
  name     = "${each.key}_ALL_SOURCES_SR"
  comment  = "All Schemas Read Access"
}

resource "snowflake_account_role" "roles_access_all_source_schemas_srw" {
  provider = snowflake.useradmin
  for_each = local.source_system_databases
  name     = "${each.key}_ALL_SOURCES_SRW"
  comment  = "All Schemas Read/Write Access"
}

resource "snowflake_account_role" "roles_access_all_source_schemas_sfull" {
  provider = snowflake.useradmin
  for_each = local.source_system_databases
  name     = "${each.key}_ALL_SOURCES_SFULL"
  comment  = "All Schemas Full Access"
}

# # these access roles can be used to easily grant access to all staging schemas
resource "snowflake_account_role" "roles_access_all_staging_schemas_sr" {
  provider = snowflake.useradmin
  for_each = local.staging_databases
  name     = "${each.key}_ALL_SCHEMAS_SR"
  comment  = "All Staging Schemas Read Access"
}

resource "snowflake_account_role" "roles_access_all_staging_schemas_srw" {
  provider = snowflake.useradmin
  for_each = local.staging_databases
  name     = "${each.key}_ALL_SCHEMAS_SRW"
  comment  = "All Staging Schemas Read/Write Access"
}

resource "snowflake_account_role" "roles_access_all_staging_schemas_sfull" {
  provider = snowflake.useradmin
  for_each = local.staging_databases
  name     = "${each.key}_ALL_SCHEMAS_SFULL"
  comment  = "All Staging Schemas Full Access"
}


# # these access roles can be used to easily grant access to all int schemas

resource "snowflake_account_role" "roles_access_all_intermediate_schemas_sr" {
  provider = snowflake.useradmin
  for_each = local.intermediate_databases
  name     = "${each.key}_ALL_INTERMEDIATE_SR"
  comment  = "All Schemas Read Access"
}

resource "snowflake_account_role" "roles_access_all_intermediate_schemas_srw" {
  provider = snowflake.useradmin
  for_each = local.intermediate_databases
  name     = "${each.key}_ALL_INTERMEDIATE_SRW"
  comment  = "All Schemas Read/Write Access"
}

resource "snowflake_account_role" "roles_access_all_intermediate_schemas_sfull" {
  provider = snowflake.useradmin
  for_each = local.intermediate_databases
  name     = "${each.key}_ALL_INTERMEDIATE_SFULL"
  comment  = "All Schemas Full Access"
}

# ################################
resource "snowflake_account_role" "roles_access_db_create" {
  provider = snowflake.useradmin
  name     = "DB_CREATE"
  comment  = "Create DB"
}

resource "snowflake_account_role" "roles_access_schema_create" {
  provider = snowflake.useradmin
  for_each = local.roles_access_schema_create_config
  name     = "${each.value.name}_SCHEMA_CREATE"
  comment  = "Create Schema in DB"
}
