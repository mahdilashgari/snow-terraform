locals {

  read_file = yamldecode(
    file(
      "${var.snowflake_config_filepath}/databases.yml"
    )
  )

  databases = local.read_file.databases

  read_source_systems = yamldecode(
    file(
      "${var.snowflake_config_filepath}/source_systems.yml"
    )
  )

  source_systems = local.read_source_systems.source_systems

  landing_zone_databases = {
    for database in local.databases : database.name => database if database.name == "LANDING_ZONE"
  }

  source_system_schemas_config = merge([
    for database in local.landing_zone_databases :
    {
      for source in local.source_systems : "${database.name}_${source.name}" => merge(
        { "database" : database.name,
          "is_transient" : database.is_transient,
      "data_retention_time_in_days" : database.data_retention_time_in_days }, source)
    }
  ]...)

}

