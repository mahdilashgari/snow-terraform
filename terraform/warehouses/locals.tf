locals {

  read_file = yamldecode(
    file(
      "${var.snowflake_config_filepath}/warehouses.yml"
    )
  )

  warehouses = local.read_file.warehouses

  warehouses_config = merge([
    for warehouse in local.warehouses :
    {
      for size in warehouse.warehouse_sizes : "${warehouse.name}_${upper(size)}" => merge(
      { "warehouse_size" = size }, warehouse)
    }
  ]...)

  warehouse_query_timeouts = yamldecode(file("${var.snowflake_config_filepath}/warehouse_query_timeouts.yml"))
}
