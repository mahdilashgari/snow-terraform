locals {

  ### ACCESS ROLE GRANTS FOR _SR, _SRW, _SFULL
  ### For now, we just loop through the schemas and source schemas
  ### and assign a set of privileges to the roles in each schema

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

  ### staging 

  staging_schemas = yamldecode(
    file(
      "${var.snowflake_config_filepath}/staging_schemas.yml"
    )
  )

  staging_databases = {
    for database in local.databases : database.name => database if try(database.create_staging_schemas, false)
  }

  staging_schemas_roles_access_config = merge([
    for db in local.staging_databases :
    {
      for schema in local.staging_schemas.staging_schemas : "${db.name}_${schema.name}" =>
      {
        "database_name" = db.name,
        "schema_name"   = schema.name
      }
    }
  ]...)

  ### intermediate

  intermediate_schemas = yamldecode(
    file(
      "${var.snowflake_config_filepath}/intermediate_schemas.yml"
    )
  )

  intermediate_databases = {
    for database in local.databases : database.name => database if try(database.create_intermediate_schemas, false)
  }

  intermediate_schemas_roles_access_config = merge([
    for db in local.intermediate_databases :
    {
      for schema in local.intermediate_schemas.intermediate_schemas : "${db.name}_${schema.name}" =>
      {
        "database_name" = db.name,
        "schema_name"   = schema.name
      }
    }
  ]...)

  roles_access_config = merge(local.custom_schemas_roles_access_config, local.source_schemas_roles_access_config, local.staging_schemas_roles_access_config, local.intermediate_schemas_roles_access_config)


  ### ACCESS ROLE GRANTS FOR _ALL_SOURCES_SR, _ALL_SOURCES_SRW, _ALL_SOURCES_SFULL

  all_sources_roles_access_config = merge([
    for db in local.source_system_databases :
    {
      for source in local.source_systems : "${db.name}_${source.name}" =>
      {
        "database_name" = db.name,
        "schema_name"   = source.name
      } if try(source.exclude_from_all_sources_access, false) == false
    }
  ]...)

  ### ACCESS ROLE GRANTS FOR _ALL_STAGING_SR, _ALL_STAGING_SRW, _ALL_STAGING_SFULL

  all_staging_roles_access_config = merge([
    for db in local.staging_databases :
    {
      for schema in local.staging_schemas.staging_schemas : "${db.name}_${schema.name}" =>
      {
        "database_name" = db.name,
        "schema_name"   = schema.name
      } if try(schema.exclude_from_all_access, false) == false
    }
  ]...)

  ### ACCESS ROLE GRANTS FOR _ALL_INTERMEDIATE_SR, _ALL_INTERMEDIATE_SRW, _ALL_INTERMEDIATE_SFULL

  all_intermediate_roles_access_config = merge([
    for db in local.intermediate_databases :
    {
      for schema in local.intermediate_schemas.intermediate_schemas : "${db.name}_${schema.name}" =>
      {
        "database_name" = db.name,
        "schema_name"   = schema.name
      } if try(schema.exclude_from_all_access, false) == false
    }
  ]...)

  ### ACCESS ROLE GRANTS CREATE SCHEMA
  ### We create this role for each schema

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

  ### ACCESS ROLE PRIVILEGES

  read_roles_access_privileges = yamldecode(
    file(
      "${var.snowflake_config_filepath}/roles_access_privileges.yml"
    )
  )

  roles_access_privileges = local.read_roles_access_privileges


  ### WAREHOUSE GRANTS
  read_grants_warehouse = yamldecode(file("${var.snowflake_config_filepath}/warehouses.yml"))

  grants_warehouse = local.read_grants_warehouse.warehouses

  grants_warehouse_config = merge([
    for warehouse in local.grants_warehouse :
    merge([
      for size in warehouse.warehouse_sizes :
      {
        for grant in warehouse.warehouse_grants : "${warehouse.name}_${upper(size)}_${grant.role}" =>
        {
          "warehouse_name" : "${warehouse.name}_${upper(size)}",
          "role" : grant.role,
          "privileges" : grant.privileges
        }
      }
    ]...)
  ]...)

  ### ROLE USER GRANTS

  read_grants_user_role = yamldecode(file("${var.snowflake_config_filepath}/grants_user_role.yml"))

  grants_user_role = local.read_grants_user_role.grants_user_role

  grants_user_role_config = {
    for role in local.grants_user_role :
    role.role => {
      for k, v in role : k => v
    }
  }

  ### ROLE ROLE GRANTS

  read_roles_functional = yamldecode(
    file(
      "${var.snowflake_config_filepath}/roles_functional.yml"
    )
  )

  roles_functional = local.read_roles_functional.roles_functional

  hierarchy_config = merge([
    for role in local.roles_functional :
    {
      for access_role in merge(
        role, { "access_roles" : try(role.access_roles, []) } # add empty array if no roles assigned
        ).access_roles : "${role.name}_${access_role}" => {
        "source_role" : access_role,
        "target_role" : role.name
      }
    }
  ]...)

}
