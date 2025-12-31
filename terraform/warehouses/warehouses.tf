resource "snowflake_warehouse" "warehouses" {
  provider = snowflake.sysadmin
  for_each = local.warehouses_config

  name    = "${each.value.name}_${upper(each.value.warehouse_size)}"
  comment = try(each.value.comment, null)

  warehouse_size                      = upper(try(each.value.warehouse_size, "xsmall"))
  auto_resume                         = try(each.value.auto_resume, true)
  initially_suspended                 = try(each.value.initially_suspended, true)
  auto_suspend                        = try(each.value.auto_suspend, 1800)
  warehouse_type                      = try(each.value.warehouse_type, null) # STANDARD | SNOWPARK-OPTIMIZED
  scaling_policy                      = try(each.value.scaling_policy, null) # STANDARD | ECONOMY
  min_cluster_count                   = try(each.value.min_cluster_count, null)
  max_cluster_count                   = try(each.value.max_cluster_count, null)
  max_concurrency_level               = try(each.value.warehouse_type, null) == "SNOWPARK-OPTIMIZED" ? 1 : null                                                      # as per tip in docs https://docs.snowflake.com/en/user-guide/warehouses-snowpark-optimized
  enable_query_acceleration           = try(each.value.warehouse_type, null) == "SNOWPARK-OPTIMIZED" ? null : try(each.value.enable_query_acceleration, true)        # snowpark doesn't support query acceleration
  query_acceleration_max_scale_factor = try(each.value.warehouse_type, null) == "SNOWPARK-OPTIMIZED" ? null : try(each.value.query_acceleration_max_scale_factor, 8) # snowpark doesn't support query acceleration
  statement_timeout_in_seconds = lookup(
    lookup(local.warehouse_query_timeouts, try(each.value.warehouse_timeout_config, try(each.value.warehouse_type, "STANDARD")), {}),
    upper(each.value.warehouse_size),
    60 # default if not found
  )

  lifecycle {
    ignore_changes = [warehouse_size]
  }
}
