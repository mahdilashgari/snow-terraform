locals {

  ### DATABASES AND CUSTOM SCHEMAS

  read_file = yamldecode(
    file(
      "${var.snowflake_config_filepath}/databases.yml"
    )
  )

  databases = local.read_file.databases

  databases_config = {
    for database in local.databases :
    database.name => {
      for k, v in database : k => v if k != "schemas"
    }
  }

  schemas_config = merge([
    for database in local.databases :
    {
      for schema in merge(database, { "schemas" : try(database.schemas, []) }).schemas : "${database.name}_${schema.name}" => merge(
        { "database" : database.name,
          "is_transient" : database.is_transient,
      "data_retention_time_in_days" : database.data_retention_time_in_days }, schema)
    }
  ]...)

  ### AUTO GENERATES SOURCE SYSTEM SCHEMAS

  read_source_systems = yamldecode(
    file(
      "${var.snowflake_config_filepath}/source_systems.yml"
    )
  )

  source_systems = local.read_source_systems.source_systems

  source_system_databases = {
    for database in local.databases : database.name => database if try(database.create_source_system_schemas, false)
  }

  source_system_schemas_config = merge([
    for database in local.source_system_databases :
    {
      for source in local.source_systems : "${database.name}_${source.name}" => merge(
        { "database" : database.name,
          "is_transient" : (
            database.name == "LANDING_ZONE" && try(source.non_transient_landing_zone, false) ? false : database.is_transient
          ),
      "data_retention_time_in_days" : database.data_retention_time_in_days }, source)
    }
  ]...)

  ### AUTO GENERATES STAGING SCHEMAS

  read_staging_schemas = yamldecode(
    file(
      "${var.snowflake_config_filepath}/staging_schemas.yml"
    )
  )

  staging_databases = {
    for database in local.databases : database.name => database if try(database.create_staging_schemas, false)
  }

  staging_schemas_config = merge([
    for database in local.staging_databases :
    {
      for schema in local.read_staging_schemas.staging_schemas : "${database.name}_${schema.name}" => merge(
        {
          "database" : database.name,
          "is_transient" : database.is_transient,
          "data_retention_time_in_days" : database.data_retention_time_in_days
      }, schema)
    }
  ]...)



  ### AUTO GENERATES INTERMEDIATE SCHEMAS

  read_intermediate_schemas = yamldecode(
    file(
      "${var.snowflake_config_filepath}/intermediate_schemas.yml"
    )
  )

  intermediate_databases = {
    for database in local.databases : database.name => database if try(database.create_intermediate_schemas, false)
  }

  intermediate_schemas_config = merge([
    for database in local.intermediate_databases :
    {
      for schema in local.read_intermediate_schemas.intermediate_schemas : "${database.name}_${schema.name}" => merge(
        {
          "database" : database.name,
          "is_transient" : database.is_transient,
          "data_retention_time_in_days" : database.data_retention_time_in_days
      }, schema)
    }
  ]...)

}
