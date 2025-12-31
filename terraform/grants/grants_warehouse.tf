# resource "snowflake_warehouse_grant" "grants_warehouse" {
#   provider       = snowflake.sysadmin
#   for_each       = local.grants_warehouse_config
#   warehouse_name = each.value.warehouse_name
#   privilege      = each.value.privilege

#   roles = [each.value.role]

#   enable_multiple_grants = true
#   with_grant_option      = false
# }

resource "snowflake_grant_privileges_to_account_role" "grants_warehouse" {
  provider = snowflake.sysadmin
  for_each = local.grants_warehouse_config

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = each.value.warehouse_name
  }

  account_role_name = each.value.role
  privileges        = each.value.privileges
  with_grant_option = false
}
