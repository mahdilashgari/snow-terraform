resource "snowflake_schema" "schemas" {
  provider = snowflake.sysadmin
  for_each = merge(local.schemas_config, local.source_system_schemas_config, local.staging_schemas_config, local.intermediate_schemas_config)

  database = each.value.database
  name     = each.value.name
  comment  = try(each.value.comment, null)

  is_transient                = try(each.value.is_transient, true)
  with_managed_access         = try(each.value.is_managed, false)
  data_retention_time_in_days = try(each.value.data_retention_time_in_days, 0)

  depends_on = [snowflake_database.databases]

  lifecycle {
    prevent_destroy = true
  }
}
