#allows raw layer views to access underlying snapshots tables
resource "snowflake_grant_account_role" "grant_snapshot_read_to_raw_sfull" {
  provider         = snowflake.useradmin
  for_each         = toset([for source in local.source_systems : source.name])
  role_name        = "SNAPSHOTS_${each.value}_SR"
  parent_role_name = "RAW_${each.value}_SFULL"
}

#grant raw reader roles access to snapshots
resource "snowflake_grant_account_role" "grant_snapshot_read_to_raw_sr" {
  provider         = snowflake.useradmin
  for_each         = toset([for source in local.source_systems : source.name])
  role_name        = "SNAPSHOTS_${each.value}_SR"
  parent_role_name = "RAW_${each.value}_SR"
}

#generate a set of source system names and staging schema names
# to be used for granting access for staging layer to the snapshots schema 
locals {
  source_systems_set             = toset([for source in local.source_systems : source.name])
  staging_schemas_set            = toset([for schema in local.staging_schemas.staging_schemas : schema.name])
  source_systems_staging_schemas = setproduct(local.source_systems_set, local.staging_schemas_set)
}

#allows staging layer views to access underlying snapshots tables
resource "snowflake_grant_account_role" "grant_snapshot_read_to_staging_sfull" {
  provider = snowflake.useradmin
  #for_each  = toset([for source in local.source_systems : source.name])
  for_each = {
    for pair in local.source_systems_staging_schemas :
    "${pair[0]}-${pair[1]}" => {
      source  = pair[0]
      staging = pair[1]
    }
  }
  role_name        = "SNAPSHOTS_${each.value.source}_SR"
  parent_role_name = "STAGING_${each.value.staging}_SFULL"
}
