# resource "snowflake_account_grant" "grant" {
#   provider = snowflake.sysadmin
#   for_each = {
#     for i, privilege in local.roles_access_privileges.db_create.account :
#     "${i}" => { "privilege" : privilege }
#   }

#   roles                  = ["DB_CREATE"]
#   privilege              = each.value.privilege
#   with_grant_option      = false
#   enable_multiple_grants = true
# }

resource "snowflake_grant_privileges_to_account_role" "grants_db_create" {
  provider = snowflake.sysadmin

  account_role_name = "DB_CREATE"
  privileges        = local.roles_access_privileges.db_create.account
  on_account        = true
  with_grant_option = false
}