locals {

  ### Create Access Roles _SR, _SRW, _SFULL
  ### For now, we just create the same three access roles for each schema in the databases file

  read_databases = yamldecode(
    file(
      "${var.snowflake_config_filepath}/databases.yml"
    )
  )

  databases = local.read_databases.databases

  custom_schemas_roles_access_config = merge([
    for db in local.databases :
    {
      for schema in merge(db, { "schemas" : try(db.schemas, []) }).schemas : "${db.name}_${schema.name}" =>
      {
        "database_name" = db.name,
        "schema_name"   = schema.name
      }
    }
  ]...)

  read_source_systems = yamldecode(
    file(
      "${var.snowflake_config_filepath}/source_systems.yml"
    )
  )

  source_systems = local.read_source_systems.source_systems

  source_system_databases = {
    for database in local.databases : database.name => database if try(database.create_source_system_schemas, false)
  }

  source_schemas_roles_access_config = merge([
    for db in local.source_system_databases :
    {
      for source in local.source_systems : "${db.name}_${source.name}" =>
      {
        "database_name" = db.name,
        "schema_name"   = source.name
      }
    }
  ]...)

  ### STAGING SCHEMAS

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
      for schema in local.read_staging_schemas.staging_schemas : "${database.name}_${schema.name}" =>
      {
        "database_name" : database.name,
        "schema_name" : schema.name
      }
    }
  ]...)

  ### INTERMEDIATE SCHEMAS

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
      for schema in local.read_intermediate_schemas.intermediate_schemas : "${database.name}_${schema.name}" =>
      {
        "database_name" : database.name,
        "schema_name" : schema.name
      }
    }
  ]...)

  ### Merge all roles access configurations

  roles_access_config = merge(local.custom_schemas_roles_access_config, local.source_schemas_roles_access_config, local.staging_schemas_config, local.intermediate_schemas_config)

  ### Create Access Roles for Schema Creation

  read_roles_access_schema_create = yamldecode(
    file(
      "${var.snowflake_config_filepath}/databases.yml"
    )
  )

  roles_access_schema_create = local.read_roles_access_schema_create.databases

  roles_access_schema_create_config = {
    for db in local.roles_access_schema_create :
    db.name => {
      for k, v in db : k => v if k != "schemas"
    }
  }

  ### Create Functional Roles

  read_roles_functional = yamldecode(
    file(
      "${var.snowflake_config_filepath}/roles_functional.yml"
    )
  )

  roles_functional = local.read_roles_functional.roles_functional

  roles_functional_config = {
    for role in local.roles_functional :
    role.name => {
      for k, v in role : k => v
    }
  }

}
