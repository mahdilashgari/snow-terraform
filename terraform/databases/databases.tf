resource "snowflake_database" "databases" {
  provider = snowflake.sysadmin
  name     = each.value.name
  for_each = local.databases_config

  lifecycle {
    prevent_destroy = true
  }

}