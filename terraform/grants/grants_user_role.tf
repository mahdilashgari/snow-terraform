locals {
  grants_user_role_config_pairs = flatten([
    for role_key, role_config in local.grants_user_role_config : [
      for user in role_config.users : {
        role = role_config.role
        user = user
      }
    ]
  ])

  grants_user_role_config_pairs_map = {
    for pair in local.grants_user_role_config_pairs :
    "${pair.role}_${pair.user}" => pair
  }

}

resource "snowflake_grant_account_role" "grants_user_role" {
  provider = snowflake.useradmin
  for_each = local.grants_user_role_config_pairs_map

  role_name = each.value.role
  user_name = each.value.user

}
