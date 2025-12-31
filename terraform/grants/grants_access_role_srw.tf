### DATABASE

resource "snowflake_grant_privileges_to_account_role" "grants_database_srw" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_account_object {
    object_type = "DATABASE"
    object_name = each.value.database_name
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  privileges        = local.roles_access_privileges.schema_rw.database
  with_grant_option = false
}

### SCHEMA

resource "snowflake_grant_privileges_to_account_role" "grants_schema_srw" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema {
    schema_name = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
  }

  privileges        = local.roles_access_privileges.schema_rw.schema
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw]
}

### TABLES

resource "snowflake_grant_privileges_to_account_role" "grants_all_tables_srw" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.tables
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}

resource "snowflake_grant_privileges_to_account_role" "grants_future_tables_srw" {
  provider = snowflake.securityadmin

  for_each = local.roles_access_config

  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.tables
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}

### VIEWS

resource "snowflake_grant_privileges_to_account_role" "grants_all_views_srw" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema_object {
    all {
      object_type_plural = "VIEWS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.views
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}

resource "snowflake_grant_privileges_to_account_role" "grants_future_views_srw" {
  provider = snowflake.securityadmin

  for_each = local.roles_access_config

  on_schema_object {
    future {
      object_type_plural = "VIEWS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.views
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}

### STAGES

resource "snowflake_grant_privileges_to_account_role" "grants_all_stages_srw" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema_object {
    all {
      object_type_plural = "STAGES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.stages
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}

resource "snowflake_grant_privileges_to_account_role" "grants_future_stages_srw" {
  provider = snowflake.securityadmin

  for_each = local.roles_access_config

  on_schema_object {
    future {
      object_type_plural = "STAGES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.stages
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}

### FILE FORMATS

resource "snowflake_grant_privileges_to_account_role" "grants_all_file_formats_srw" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema_object {
    all {
      object_type_plural = "FILE FORMATS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.file_formats
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}

resource "snowflake_grant_privileges_to_account_role" "grants_future_file_formats_srw" {
  provider = snowflake.securityadmin

  for_each = local.roles_access_config

  on_schema_object {
    future {
      object_type_plural = "FILE FORMATS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.file_formats
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}

### STREAMS

resource "snowflake_grant_privileges_to_account_role" "grants_all_streams_srw" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema_object {
    all {
      object_type_plural = "STREAMS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.streams
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}

resource "snowflake_grant_privileges_to_account_role" "grants_future_streams_srw" {
  provider = snowflake.securityadmin

  for_each = local.roles_access_config

  on_schema_object {
    future {
      object_type_plural = "STREAMS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.streams
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}

### PROCEDURES

resource "snowflake_grant_privileges_to_account_role" "grants_all_procedures_srw" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema_object {
    all {
      object_type_plural = "PROCEDURES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.procedures
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}

resource "snowflake_grant_privileges_to_account_role" "grants_future_procedures_srw" {
  provider = snowflake.securityadmin

  for_each = local.roles_access_config

  on_schema_object {
    future {
      object_type_plural = "PROCEDURES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.procedures
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}

### FUNCTIONS

resource "snowflake_grant_privileges_to_account_role" "grants_all_functions_srw" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema_object {
    all {
      object_type_plural = "FUNCTIONS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.functions
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}

resource "snowflake_grant_privileges_to_account_role" "grants_future_functions_srw" {
  provider = snowflake.securityadmin

  for_each = local.roles_access_config

  on_schema_object {
    future {
      object_type_plural = "FUNCTIONS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.functions
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}

### SEQUENCES

resource "snowflake_grant_privileges_to_account_role" "grants_all_sequences_srw" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema_object {
    all {
      object_type_plural = "SEQUENCES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.sequences
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}

resource "snowflake_grant_privileges_to_account_role" "grants_future_sequences_srw" {
  provider = snowflake.securityadmin

  for_each = local.roles_access_config

  on_schema_object {
    future {
      object_type_plural = "SEQUENCES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.sequences
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}

### TASKS

resource "snowflake_grant_privileges_to_account_role" "grants_all_tasks_srw" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema_object {
    all {
      object_type_plural = "TASKS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.tasks
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}

resource "snowflake_grant_privileges_to_account_role" "grants_future_tasks_srw" {
  provider = snowflake.securityadmin

  for_each = local.roles_access_config

  on_schema_object {
    future {
      object_type_plural = "TASKS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_rw.tasks
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SRW"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_srw, snowflake_grant_privileges_to_account_role.grants_schema_srw]
}
