resource "snowflake_network_policy_attachment" "user_attach" {
  provider            = snowflake.securityadmin
  for_each            = local.users_technical_config
  network_policy_name = each.value.network_policy
  set_for_account     = false
  users               = [each.value.name]

  depends_on = [snowflake_user.users_technical]
}