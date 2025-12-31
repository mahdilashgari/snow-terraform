### DATABASE

resource "snowflake_grant_privileges_to_account_role" "grants_database_sfull" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_account_object {
    object_type = "DATABASE"
    object_name = each.value.database_name
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  privileges        = local.roles_access_privileges.schema_full.database
  with_grant_option = false
}

### SCHEMA

resource "snowflake_grant_privileges_to_account_role" "grants_schema_sfull" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema {
    schema_name = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
  }

  privileges        = local.roles_access_privileges.schema_full.schema
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull]
}

### TABLES

# resource "snowflake_grant_privileges_to_account_role" "grants_all_tables_sfull" {
#   provider = snowflake.sysadmin

#   for_each = local.roles_access_config

#   on_schema_object {
#     all {
#       object_type_plural = "TABLES"
#       in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
#     }
#   }

#   privileges        = local.roles_access_privileges.schema_full.tables
#   account_role_name         = "${each.value.database_name}_${each.value.schema_name}_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
# }

# ownership grant is now a separate resource:

resource "snowflake_grant_ownership" "grants_all_tables_sfull" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on {
    all {
      object_type_plural = "TABLES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  depends_on        = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}


# grant evolve schema role to RAW_LOADER
resource "snowflake_grant_privileges_to_account_role" "grants_all_tables_evolve_schema_raw_loader" {
  provider = snowflake.sysadmin

  for_each = local.source_schemas_roles_access_config

  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = "LANDING_ZONE.\"${each.value.schema_name}\""
    }
  }

  privileges        = ["EVOLVE SCHEMA"]
  account_role_name = "RAW_LOADER"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

resource "snowflake_grant_privileges_to_account_role" "grants_future_tables_evolve_schema_raw_loader" {
  provider = snowflake.securityadmin

  for_each = local.source_schemas_roles_access_config

  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = "LANDING_ZONE.\"${each.value.schema_name}\""
    }
  }

  privileges        = ["EVOLVE SCHEMA"]
  account_role_name = "RAW_LOADER"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

# resource "snowflake_grant_privileges_to_account_role" "grants_future_tables_sfull" {
#   provider = snowflake.securityadmin

#   for_each = local.roles_access_config

#   on_schema_object {
#     future {
#       object_type_plural = "TABLES"
#       in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
#     }
#   }

#   privileges        = local.roles_access_privileges.schema_full.tables
#   account_role_name         = "${each.value.database_name}_${each.value.schema_name}_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
# }

resource "snowflake_grant_ownership" "grants_future_tables_sfull" {
  provider            = snowflake.sysadmin
  outbound_privileges = "COPY"
  for_each            = local.roles_access_config

  on {
    future {
      object_type_plural = "TABLES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  depends_on        = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

### VIEWS

# resource "snowflake_grant_privileges_to_account_role" "grants_all_views_sfull" {
#   provider = snowflake.sysadmin

#   for_each = local.roles_access_config

#   on_schema_object {
#     all {
#       object_type_plural = "VIEWS"
#       in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
#     }
#   }

#   privileges        = local.roles_access_privileges.schema_full.views
#   account_role_name         = "${each.value.database_name}_${each.value.schema_name}_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
# }

resource "snowflake_grant_ownership" "grants_all_views_sfull" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on {
    all {
      object_type_plural = "VIEWS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  depends_on        = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

# resource "snowflake_grant_privileges_to_account_role" "grants_future_views_sfull" {
#   provider = snowflake.securityadmin

#   for_each = local.roles_access_config

#   on_schema_object {
#     future {
#       object_type_plural = "VIEWS"
#       in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
#     }
#   }

#   privileges        = local.roles_access_privileges.schema_full.views
#   account_role_name         = "${each.value.database_name}_${each.value.schema_name}_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
# }

resource "snowflake_grant_ownership" "grants_future_views_sfull" {
  provider            = snowflake.sysadmin
  outbound_privileges = "COPY"
  for_each            = local.roles_access_config

  on {
    future {
      object_type_plural = "VIEWS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  depends_on        = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

### STAGES

resource "snowflake_grant_privileges_to_account_role" "grants_all_stages_sfull" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on_schema_object {
    all {
      object_type_plural = "STAGES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_full.stages
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

resource "snowflake_grant_privileges_to_account_role" "grants_future_stages_sfull" {
  provider = snowflake.securityadmin

  for_each = local.roles_access_config

  on_schema_object {
    future {
      object_type_plural = "STAGES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  privileges        = local.roles_access_privileges.schema_full.stages
  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  with_grant_option = false

  depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

### FILE FORMATS

# resource "snowflake_grant_privileges_to_account_role" "grants_all_file_formats_sfull" {
#   provider = snowflake.sysadmin

#   for_each = local.roles_access_config

#   on_schema_object {
#     all {
#       object_type_plural = "FILE FORMATS"
#       in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
#     }
#   }

#   privileges        = local.roles_access_privileges.schema_full.file_formats
#   account_role_name         = "${each.value.database_name}_${each.value.schema_name}_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
# }

resource "snowflake_grant_ownership" "grants_all_file_formats_sfull" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on {
    all {
      object_type_plural = "FILE FORMATS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  depends_on        = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

# resource "snowflake_grant_privileges_to_account_role" "grants_future_file_formats_sfull" {
#   provider = snowflake.securityadmin

#   for_each = local.roles_access_config

#   on_schema_object {
#     future {
#       object_type_plural = "FILE FORMATS"
#       in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
#     }
#   }

#   privileges        = local.roles_access_privileges.schema_full.file_formats
#   account_role_name         = "${each.value.database_name}_${each.value.schema_name}_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
# }

resource "snowflake_grant_ownership" "grants_future_file_formats_sfull" {
  provider            = snowflake.sysadmin
  outbound_privileges = "COPY"
  for_each            = local.roles_access_config

  on {
    future {
      object_type_plural = "FILE FORMATS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  depends_on        = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

### STREAMS

# resource "snowflake_grant_privileges_to_account_role" "grants_all_streams_sfull" {
#   provider = snowflake.sysadmin

#   for_each = local.roles_access_config

#   on_schema_object {
#     all {
#       object_type_plural = "STREAMS"
#       in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
#     }
#   }

#   privileges        = local.roles_access_privileges.schema_full.streams
#   account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
# }

resource "snowflake_grant_ownership" "grants_all_streams_sfull" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on {
    all {
      object_type_plural = "STREAMS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  depends_on        = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

# resource "snowflake_grant_privileges_to_account_role" "grants_future_streams_sfull" {
#   provider = snowflake.securityadmin

#   for_each = local.roles_access_config

#   on_schema_object {
#     future {
#       object_type_plural = "STREAMS"
#       in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
#     }
#   }

#   privileges        = local.roles_access_privileges.schema_full.streams
#   account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
# }

resource "snowflake_grant_ownership" "grants_future_streams_sfull" {
  provider            = snowflake.sysadmin
  outbound_privileges = "COPY"
  for_each            = local.roles_access_config

  on {
    future {
      object_type_plural = "STREAMS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  depends_on        = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

### PROCEDURES

# resource "snowflake_grant_privileges_to_account_role" "grants_all_procedures_sfull" {
#   provider = snowflake.sysadmin

#   for_each = local.roles_access_config

#   on_schema_object {
#     all {
#       object_type_plural = "PROCEDURES"
#       in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
#     }
#   }

#   privileges        = local.roles_access_privileges.schema_full.procedures
#   account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
# }

resource "snowflake_grant_ownership" "grants_all_procedures_sfull" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on {
    all {
      object_type_plural = "PROCEDURES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  depends_on        = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

# resource "snowflake_grant_privileges_to_account_role" "grants_future_procedures_sfull" {
#   provider = snowflake.securityadmin

#   for_each = local.roles_access_config

#   on_schema_object {
#     future {
#       object_type_plural = "PROCEDURES"
#       in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
#     }
#   }

#   privileges        = local.roles_access_privileges.schema_full.procedures
#   account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
# }

resource "snowflake_grant_ownership" "grants_future_procedures_sfull" {
  provider            = snowflake.sysadmin
  outbound_privileges = "COPY"
  for_each            = local.roles_access_config

  on {
    future {
      object_type_plural = "PROCEDURES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  depends_on        = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

### FUNCTIONS

# resource "snowflake_grant_privileges_to_account_role" "grants_all_functions_sfull" {
#   provider = snowflake.sysadmin

#   for_each = local.roles_access_config

#   on_schema_object {
#     all {
#       object_type_plural = "FUNCTIONS"
#       in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
#     }
#   }

#   privileges        = local.roles_access_privileges.schema_full.functions
#   account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
# }

resource "snowflake_grant_ownership" "grants_all_functions_sfull" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on {
    all {
      object_type_plural = "FUNCTIONS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  depends_on        = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

# resource "snowflake_grant_privileges_to_account_role" "grants_future_functions_sfull" {
#   provider = snowflake.securityadmin

#   for_each = local.roles_access_config

#   on_schema_object {
#     future {
#       object_type_plural = "FUNCTIONS"
#       in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
#     }
#   }

#   privileges        = local.roles_access_privileges.schema_full.functions
#   account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
# }

resource "snowflake_grant_ownership" "grants_future_functions_sfull" {
  provider            = snowflake.sysadmin
  outbound_privileges = "COPY"
  for_each            = local.roles_access_config

  on {
    future {
      object_type_plural = "FUNCTIONS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  depends_on        = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

### SEQUENCES

# resource "snowflake_grant_privileges_to_account_role" "grants_all_sequences_sfull" {
#   provider = snowflake.sysadmin

#   for_each = local.roles_access_config

#   on_schema_object {
#     all {
#       object_type_plural = "SEQUENCES"
#       in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
#     }
#   }

#   privileges        = local.roles_access_privileges.schema_full.sequences
#   account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
# }

resource "snowflake_grant_ownership" "grants_all_sequences_sfull" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on {
    all {
      object_type_plural = "SEQUENCES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  depends_on        = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

# resource "snowflake_grant_privileges_to_account_role" "grants_future_sequences_sfull" {
#   provider = snowflake.securityadmin

#   for_each = local.roles_access_config

#   on_schema_object {
#     future {
#       object_type_plural = "SEQUENCES"
#       in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
#     }
#   }

#   privileges        = local.roles_access_privileges.schema_full.sequences
#   account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
# }

resource "snowflake_grant_ownership" "grants_future_sequences_sfull" {
  provider            = snowflake.sysadmin
  outbound_privileges = "COPY"
  for_each            = local.roles_access_config

  on {
    future {
      object_type_plural = "SEQUENCES"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  depends_on        = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

### TASKS

# resource "snowflake_grant_privileges_to_account_role" "grants_all_tasks_sfull" {
#   provider = snowflake.sysadmin

#   for_each = local.roles_access_config

#   on_schema_object {
#     all {
#       object_type_plural = "TASKS"
#       in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
#     }
#   }

#   privileges        = local.roles_access_privileges.schema_full.tasks
#   account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
# }

resource "snowflake_grant_ownership" "grants_all_tasks_sfull" {
  provider = snowflake.sysadmin

  for_each = local.roles_access_config

  on {
    all {
      object_type_plural = "TASKS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  depends_on        = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}


# resource "snowflake_grant_privileges_to_account_role" "grants_future_tasks_sfull" {
#   provider = snowflake.securityadmin

#   for_each = local.roles_access_config

#   on_schema_object {
#     future {
#       object_type_plural = "TASKS"
#       in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
#     }
#   }

#   privileges        = local.roles_access_privileges.schema_full.tasks
#   account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
# }

resource "snowflake_grant_ownership" "grants_future_tasks_sfull" {
  provider            = snowflake.sysadmin
  outbound_privileges = "COPY"
  for_each            = local.roles_access_config

  on {
    future {
      object_type_plural = "TASKS"
      in_schema          = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
    }
  }

  account_role_name = "${each.value.database_name}_${each.value.schema_name}_SFULL"
  depends_on        = [snowflake_grant_privileges_to_account_role.grants_database_sfull, snowflake_grant_privileges_to_account_role.grants_schema_sfull]
}

# deprecated grants

### DATABASE

# resource "snowflake_database_grant" "grants_sfull" {
#   provider = snowflake.sysadmin
#   for_each = merge([
#     for role in local.roles_access_config :
#     {
#       for privilege in local.roles_access_privileges.schema_full.database :
#       "${role.database_name}_${role.schema_name}_${privilege}" => merge(role,
#         {
#           "privilege" : privilege
#       })
#     }
#   ]...)

#   database_name = each.value.database_name
#   privilege     = each.value.privilege

#   roles = ["${each.value.database_name}_${each.value.schema_name}_SFULL"]

#   enable_multiple_grants = true
#   with_grant_option      = false
# }

### SCHEMA

# resource "snowflake_schema_grant" "grants_sfull" {
#   provider = snowflake.sysadmin
#   for_each = merge([
#     for role in local.roles_access_config :
#     {
#       for privilege in local.roles_access_privileges.schema_full.schema :
#       "${role.database_name}_${role.schema_name}_${privilege}" => merge(role,
#         {
#           "privilege" : privilege
#       })
#     }
#   ]...)

#   database_name = each.value.database_name
#   schema_name   = each.value.schema_name
#   privilege     = each.value.privilege
#   roles         = ["${each.value.database_name}_${each.value.schema_name}_SFULL"]

#   enable_multiple_grants = true
#   with_grant_option      = false
# }

# ### TABLES

# resource "snowflake_table_grant" "grants_all_sfull" {
#   provider = snowflake.sysadmin
#   for_each = merge([
#     for role in local.roles_access_config :
#     {
#       for privilege in local.roles_access_privileges.schema_full.tables :
#       "${role.database_name}_${role.schema_name}_${privilege}" => merge(role,
#         {
#           "privilege" : privilege
#       })
#     }
#   ]...)

#   database_name = each.value.database_name
#   schema_name   = each.value.schema_name
#   privilege     = each.value.privilege
#   roles         = ["${each.value.database_name}_${each.value.schema_name}_SFULL"]

#   on_all = true

#   enable_multiple_grants = true
#   with_grant_option      = false
# }

# resource "snowflake_table_grant" "grants_future_sfull" {
#   provider = snowflake.securityadmin
#   for_each = merge([
#     for role in local.roles_access_config :
#     {
#       for privilege in local.roles_access_privileges.schema_full.tables :
#       "${role.database_name}_${role.schema_name}_${privilege}" => merge(role,
#         {
#           "privilege" : privilege
#       })
#     }
#   ]...)

#   database_name = each.value.database_name
#   schema_name   = each.value.schema_name
#   privilege     = each.value.privilege
#   roles         = ["${each.value.database_name}_${each.value.schema_name}_SFULL"]

#   on_future = true

#   enable_multiple_grants = true
#   with_grant_option      = false

#   #depends_on = [snowflake_database_grant.grants_sfull, snowflake_schema_grant.grants_sfull]
# }

# ### VIEWS

# resource "snowflake_view_grant" "grants_all_sfull" {
#   provider = snowflake.sysadmin
#   for_each = merge([
#     for role in local.roles_access_config :
#     {
#       for privilege in local.roles_access_privileges.schema_full.views :
#       "${role.database_name}_${role.schema_name}_${privilege}" => merge(role,
#         {
#           "privilege" : privilege
#       })
#     }
#   ]...)

#   database_name = each.value.database_name
#   schema_name   = each.value.schema_name
#   privilege     = each.value.privilege
#   roles         = ["${each.value.database_name}_${each.value.schema_name}_SFULL"]

#   on_all = true

#   enable_multiple_grants = true
#   with_grant_option      = false
# }

# resource "snowflake_view_grant" "grants_future_sfull" {
#   provider = snowflake.securityadmin
#   for_each = merge([
#     for role in local.roles_access_config :
#     {
#       for privilege in local.roles_access_privileges.schema_full.views :
#       "${role.database_name}_${role.schema_name}_${privilege}" => merge(role,
#         {
#           "privilege" : privilege
#       })
#     }
#   ]...)

#   database_name = each.value.database_name
#   schema_name   = each.value.schema_name
#   privilege     = each.value.privilege
#   roles         = ["${each.value.database_name}_${each.value.schema_name}_SFULL"]

#   on_future = true

#   enable_multiple_grants = true
#   with_grant_option      = false
# }

# ### STAGES

# resource "snowflake_stage_grant" "grants_all_sfull" {
#   provider = snowflake.sysadmin
#   for_each = merge([
#     for role in local.roles_access_config :
#     {
#       for i, privilege in local.roles_access_privileges.schema_full.stages :
#       "${i}_${role.database_name}_${role.schema_name}_${privilege}" => merge(role,
#         {
#           "privilege" : privilege
#       })
#     }
#   ]...)

#   database_name = each.value.database_name
#   schema_name   = each.value.schema_name
#   privilege     = each.value.privilege
#   roles         = ["${each.value.database_name}_${each.value.schema_name}_SFULL"]

#   on_all = true

#   enable_multiple_grants = true
#   with_grant_option      = false
# }

# resource "snowflake_stage_grant" "grants_future_sfull" {
#   provider = snowflake.securityadmin
#   for_each = merge([
#     for role in local.roles_access_config :
#     {
#       for privilege in local.roles_access_privileges.schema_full.stages :
#       "${role.database_name}_${role.schema_name}_${privilege}" => merge(role,
#         {
#           "privilege" : privilege
#       })
#     }
#   ]...)

#   database_name = each.value.database_name
#   schema_name   = each.value.schema_name
#   privilege     = each.value.privilege
#   roles         = ["${each.value.database_name}_${each.value.schema_name}_SFULL"]

#   on_future = true

#   enable_multiple_grants = true
#   with_grant_option      = false
# }

# ### FILE FORMATS

# resource "snowflake_file_format_grant" "grants_future_sfull" {
#   provider = snowflake.securityadmin
#   for_each = merge([
#     for role in local.roles_access_config :
#     {
#       for privilege in local.roles_access_privileges.schema_full.file_formats :
#       "${role.database_name}_${role.schema_name}_${privilege}" => merge(role,
#         {
#           "privilege" : privilege
#       })
#     }
#   ]...)

#   database_name = each.value.database_name
#   schema_name   = each.value.schema_name
#   privilege     = each.value.privilege
#   roles         = ["${each.value.database_name}_${each.value.schema_name}_SFULL"]

#   on_future = true

#   enable_multiple_grants = true
#   with_grant_option      = false
# }

# ### STREAMS

# resource "snowflake_stream_grant" "grants_future_sfull" {
#   provider = snowflake.securityadmin
#   for_each = merge([
#     for role in local.roles_access_config :
#     {
#       for privilege in local.roles_access_privileges.schema_full.streams :
#       "${role.database_name}_${role.schema_name}_${privilege}" => merge(role,
#         {
#           "privilege" : privilege
#       })
#     }
#   ]...)

#   database_name = each.value.database_name
#   schema_name   = each.value.schema_name
#   privilege     = each.value.privilege
#   roles         = ["${each.value.database_name}_${each.value.schema_name}_SFULL"]

#   on_future = true

#   enable_multiple_grants = true
#   with_grant_option      = false
# }

# ### PROCEDURES

# resource "snowflake_procedure_grant" "grants_future_sfull" {
#   provider = snowflake.securityadmin
#   for_each = merge([
#     for role in local.roles_access_config :
#     {
#       for privilege in local.roles_access_privileges.schema_full.procedures :
#       "${role.database_name}_${role.schema_name}_${privilege}" => merge(role,
#         {
#           "privilege" : privilege
#       })
#     }
#   ]...)

#   database_name = each.value.database_name
#   schema_name   = each.value.schema_name
#   privilege     = each.value.privilege
#   roles         = ["${each.value.database_name}_${each.value.schema_name}_SFULL"]

#   on_future = true

#   enable_multiple_grants = true
#   with_grant_option      = false
# }

# ### FUNCTIONS

# resource "snowflake_function_grant" "grants_future_sfull" {
#   provider = snowflake.securityadmin
#   for_each = merge([
#     for role in local.roles_access_config :
#     {
#       for privilege in local.roles_access_privileges.schema_full.functions :
#       "${role.database_name}_${role.schema_name}_${privilege}" => merge(role,
#         {
#           "privilege" : privilege
#       })
#     }
#   ]...)

#   database_name = each.value.database_name
#   schema_name   = each.value.schema_name
#   privilege     = each.value.privilege
#   roles         = ["${each.value.database_name}_${each.value.schema_name}_SFULL"]

#   on_future = true

#   enable_multiple_grants = true
#   with_grant_option      = false
# }

# ### SEQUENCES

# resource "snowflake_sequence_grant" "grants_future_sfull" {
#   provider = snowflake.securityadmin
#   for_each = merge([
#     for role in local.roles_access_config :
#     {
#       for privilege in local.roles_access_privileges.schema_full.sequences :
#       "${role.database_name}_${role.schema_name}_${privilege}" => merge(role,
#         {
#           "privilege" : privilege
#       })
#     }
#   ]...)

#   database_name = each.value.database_name
#   schema_name   = each.value.schema_name
#   privilege     = each.value.privilege
#   roles         = ["${each.value.database_name}_${each.value.schema_name}_SFULL"]

#   on_future = true

#   enable_multiple_grants = true
#   with_grant_option      = false
# }

# ### TASKS

# resource "snowflake_task_grant" "grants_future_sfull" {
#   provider = snowflake.securityadmin
#   for_each = merge([
#     for role in local.roles_access_config :
#     {
#       for privilege in local.roles_access_privileges.schema_full.tasks :
#       "${role.database_name}_${role.schema_name}_${privilege}" => merge(role,
#         {
#           "privilege" : privilege
#       })
#     }
#   ]...)

#   database_name = each.value.database_name
#   schema_name   = each.value.schema_name
#   privilege     = each.value.privilege
#   roles         = ["${each.value.database_name}_${each.value.schema_name}_SFULL"]

#   on_future = true

#   enable_multiple_grants = true
#   with_grant_option      = false
# }