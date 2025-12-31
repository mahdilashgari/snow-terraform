resource "snowflake_account_role" "roles_functional" {
  provider = snowflake.useradmin
  for_each = local.roles_functional_config
  name     = each.value.name
  comment  = try(each.value.comment, null)
}