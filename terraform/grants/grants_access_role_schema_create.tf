### DATABASE

# resource "snowflake_database_grant" "grants_schema_create" {
#   provider = snowflake.sysadmin
#   for_each = merge([
#     for db in local.roles_access_schema_create_config :
#     {
#       for i, privilege in local.roles_access_privileges.schema_create.database :
#       "${i}_${db.name}_SCHEMA_CREATE_${privilege}" => merge(db,
#         {
#           "privilege" : privilege
#       })
#     }
#   ]...)

#   database_name = each.value.name
#   privilege     = each.value.privilege

#   roles = ["${each.value.name}_SCHEMA_CREATE"]

#   enable_multiple_grants = true
#   with_grant_option      = false
# }

resource "snowflake_grant_privileges_to_account_role" "grants_schema_create" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_schema_create_config

  on_account_object {
    object_type = "DATABASE"
    object_name = each.value.name
  }

  account_role_name = "${each.value.name}_SCHEMA_CREATE"
  privileges        = local.roles_access_privileges.schema_create.database
  with_grant_option = false
}