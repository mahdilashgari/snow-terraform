resource "snowflake_user" "users_technical" {
  provider             = snowflake.useradmin
  for_each             = local.users_technical_config
  name                 = each.value.name
  comment              = try(each.value.comment, null)
  password             = var.snowflake_default_password
  must_change_password = false
  rsa_public_key = try(
    each.value.rsa_public_key,
    null
  )

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      network_policy # This is to prevent the network policy from being changed by Snowflake_user resource. 
      #changes to the network policy should be done via the snowflake_network_policy_attachment resource
    ]
  }
}
