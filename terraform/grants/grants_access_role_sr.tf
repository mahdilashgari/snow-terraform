
### DATABASE

resource "snowflake_grant_privileges_to_account_role" "grants_database_sr" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_account_object {
    object_type = "DATABASE"
    object_name = each.value.database_name
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SR"
  privileges        = local.roles_access_privileges.schema_r.database
  with_grant_option = false
}

### SCHEMA

resource "snowflake_grant_privileges_to_account_role" "grants_schema_sr" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema {
    schema_name = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
  }

  privileges        = local.roles_access_privileges.schema_r.schema
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SR"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sr]
}

### TABLES

resource "snowflake_grant_privileges_to_account_role" "grants_all_tables_sr" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_r.tables
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SR"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sr, snowflake_grant_privileges_to_account_role.grants_schema_sr]
}

resource "snowflake_grant_privileges_to_account_role" "grants_future_tables_sr" {
  provider = snowflake.securityadmin

  for_each = local.roles_access_config

  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_r.tables
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SR"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sr, snowflake_grant_privileges_to_account_role.grants_schema_sr]
}

### VIEWS

resource "snowflake_grant_privileges_to_account_role" "grants_all_views_sr" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema_object {
    all {
      object_type_plural = "VIEWS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_r.views
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SR"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sr, snowflake_grant_privileges_to_account_role.grants_schema_sr]
}

resource "snowflake_grant_privileges_to_account_role" "grants_future_views_sr" {
  provider = snowflake.securityadmin

  for_each = local.roles_access_config

  on_schema_object {
    future {
      object_type_plural = "VIEWS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_r.views
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SR"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sr, snowflake_grant_privileges_to_account_role.grants_schema_sr]
}

### STAGES

resource "snowflake_grant_privileges_to_account_role" "grants_all_stages_sr" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema_object {
    all {
      object_type_plural = "STAGES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_r.stages
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SR"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sr, snowflake_grant_privileges_to_account_role.grants_schema_sr]
}

resource "snowflake_grant_privileges_to_account_role" "grants_future_stages_sr" {
  provider = snowflake.securityadmin

  for_each = local.roles_access_config

  on_schema_object {
    future {
      object_type_plural = "STAGES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_r.stages
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SR"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sr, snowflake_grant_privileges_to_account_role.grants_schema_sr]
}

### FILE FORMATS

resource "snowflake_grant_privileges_to_account_role" "grants_all_file_formats_sr" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema_object {
    all {
      object_type_plural = "FILE FORMATS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_r.file_formats
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SR"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sr, snowflake_grant_privileges_to_account_role.grants_schema_sr]
}

resource "snowflake_grant_privileges_to_account_role" "grants_future_file_formats_sr" {
  provider = snowflake.securityadmin

  for_each = local.roles_access_config

  on_schema_object {
    future {
      object_type_plural = "FILE FORMATS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_r.file_formats
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SR"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sr, snowflake_grant_privileges_to_account_role.grants_schema_sr]
}

### STREAMS

resource "snowflake_grant_privileges_to_account_role" "grants_all_streams_sr" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema_object {
    all {
      object_type_plural = "STREAMS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_r.streams
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SR"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sr, snowflake_grant_privileges_to_account_role.grants_schema_sr]
}

resource "snowflake_grant_privileges_to_account_role" "grants_future_streams_sr" {
  provider = snowflake.securityadmin

  for_each = local.roles_access_config

  on_schema_object {
    future {
      object_type_plural = "STREAMS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_r.streams
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SR"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sr, snowflake_grant_privileges_to_account_role.grants_schema_sr]
}

### FUNCTIONS

resource "snowflake_grant_privileges_to_account_role" "grants_all_functions_sr" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema_object {
    all {
      object_type_plural = "FUNCTIONS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_r.functions
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SR"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sr, snowflake_grant_privileges_to_account_role.grants_schema_sr]
}

resource "snowflake_grant_privileges_to_account_role" "grants_future_functions_sr" {
  provider = snowflake.securityadmin

  for_each = local.roles_access_config

  on_schema_object {
    future {
      object_type_plural = "FUNCTIONS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_r.functions
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SR"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sr, snowflake_grant_privileges_to_account_role.grants_schema_sr]
}

