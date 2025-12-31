resource "snowflake_grant_account_role" "grants_role_role" {
  provider = snowflake.useradmin
  for_each = local.hierarchy_config

  role_name = each.value.source_role

  parent_role_name = each.value.target_role
  #enable_multiple_grants = true
}
