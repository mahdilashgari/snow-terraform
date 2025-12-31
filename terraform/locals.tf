locals {
  default_tags = {
    application      = var.application
    environment_type = var.environment_type
    environment_name = var.environment_name
    team_name        = var.team_name
    contact_email    = var.contact_email
    business_unit    = var.business_unit
    cost_center      = var.cost_center
    provisioned_by   = "terraform"
    map-migrated     = "d-server-03s3zvveibw473" # add this tag for a migrated workload
  }

  # for roles module imports:
  ### Create Access Roles _SR, _SRW, _SFULL
  ### For now, we just create the same three access roles for each schema in the databases file

  read_databases = yamldecode(
    file(
      "${var.snowflake_config_filepath}/databases.yml"
    )
  )

  databases_for_roles = local.read_databases.databases

  custom_schemas_roles_access_config = merge([
    for db in local.databases_for_roles :
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
    for database in local.databases_for_roles : database.name => database if try(database.create_source_system_schemas, false)
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


  # for databases module imports:


  ### DATABASES AND CUSTOM SCHEMAS

  read_file = yamldecode(
    file(
      "${var.snowflake_config_filepath}/databases.yml"
    )
  )



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

  # warehouses locals:
  read_file_warehouses = yamldecode(
    file(
      "${var.snowflake_config_filepath}/warehouses.yml"
    )
  )

  warehouses = local.read_file_warehouses.warehouses

  warehouses_config = merge([
    for warehouse in local.warehouses :
    {
      for size in warehouse.warehouse_sizes : "${warehouse.name}_${upper(size)}" => merge(
      { "warehouse_size" = size }, warehouse)
    }
  ]...)

  warehouse_query_timeouts = yamldecode(file("${var.snowflake_config_filepath}/warehouse_query_timeouts.yml"))

  #stages locals:
  read_file_stages = yamldecode(
    file(
      "${var.snowflake_config_filepath}/databases.yml"
    )
  )

  databases_for_stages = local.read_file_stages.databases

  read_source_systems_for_stages = yamldecode(
    file(
      "${var.snowflake_config_filepath}/source_systems.yml"
    )
  )

  source_systems_for_stages = local.read_source_systems_for_stages.source_systems

  landing_zone_databases = {
    for database in local.databases_for_stages : database.name => database if database.name == "LANDING_ZONE"
  }

  source_system_schemas_config_for_stages = merge([
    for database in local.landing_zone_databases :
    {
      for source in local.source_systems_for_stages : "${database.name}_${source.name}" => merge(
        { "database" : database.name,
          "is_transient" : database.is_transient,
      "data_retention_time_in_days" : database.data_retention_time_in_days }, source)
    }
  ]...)


  ######
  ##GRANTS MODULE IMPORTS
  ######
  # read_databases = yamldecode(
  #   file(
  #     "${var.snowflake_config_filepath}/databases.yml"
  #   )
  # )

  databases = local.read_databases.databases

  # custom_schemas_roles_access_config = merge([
  #   for db in local.databases :
  #   {
  #     for schema in merge(db, { "schemas" : try(db.schemas, []) }).schemas : "${db.name}_${schema.name}" =>
  #     {
  #       "database_name" = db.name,
  #       "schema_name"   = schema.name
  #     }
  #   }
  # ]...)

  # read_source_systems = yamldecode(
  #   file(
  #     "${var.snowflake_config_filepath}/source_systems.yml"
  #   )
  # )

  # source_systems = local.read_source_systems.source_systems

  source_system_databases_for_Grants = {
    for database in local.databases : database.name => database if try(database.create_source_system_schemas, false)
  }

  source_schemas_roles_access_config_for_grants = merge([
    for db in local.source_system_databases_for_Grants :
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

  # staging_databases = {
  #   for database in local.databases : database.name => database if try(database.create_staging_schemas, false)
  # }

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

  # intermediate_databases = {
  #   for database in local.databases : database.name => database if try(database.create_intermediate_schemas, false)
  # }

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

  roles_access_config_for_grants = merge(local.custom_schemas_roles_access_config, local.source_schemas_roles_access_config_for_grants, local.staging_schemas_roles_access_config, local.intermediate_schemas_roles_access_config)


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

  # read_roles_access_schema_create = yamldecode(
  #   file(
  #     "${var.snowflake_config_filepath}/databases.yml"
  #   )
  # )

  # roles_access_schema_create = local.read_roles_access_schema_create.databases

  # roles_access_schema_create_config = {
  #   for db in local.roles_access_schema_create :
  #   db.name => {
  #     for k, v in db : k => v if k != "schemas"
  #   }
  # }

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

  # read_roles_functional = yamldecode(
  #   file(
  #     "${var.snowflake_config_filepath}/roles_functional.yml"
  #   )
  # )

  # roles_functional = local.read_roles_functional.roles_functional

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
