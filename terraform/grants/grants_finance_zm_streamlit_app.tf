# These privileges are granted outside of the standardized process
# as we want to limit streamlit use to very specific use cases
# Tableau is our primary BI tool and the only one that should be used for reporting

# these resources require Terraform Snowflake provider version 0.94.0

# resource "snowflake_grant_privileges_to_role" "grants_zm_streamlit_schema_sfull" {
#   provider = snowflake.sysadmin

#   on_schema {
#     schema_name = "\"ANALYTICS\".\"FINANCE\""
#   }

#   privileges        = ["CREATE STREAMLIT"]
#   role_name         = "ANALYTICS_FINANCE_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_role.grants_database_sfull]
# }

# resource "snowflake_grant_privileges_to_role" "grants_zm_streamlit_future_streamlits_sfull" {
#   provider = snowflake.securityadmin

#   on_schema_object {
#     future {
#       object_type_plural = "STREAMLITS"
#       in_schema          = "\"ANALYTICS\".\"FINANCE\""
#     }
#   }

#   privileges        = ["OWNERSHIP"]
#   role_name         = "ANALYTICS_FINANCE_SFULL"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_role.grants_database_sfull, snowflake_grant_privileges_to_role.grants_schema_sfull]
# }

# resource "snowflake_grant_privileges_to_role" "grants_zm_streamlit_future_streamlits_sr" {
#   provider = snowflake.securityadmin

#   on_schema_object {
#     future {
#       object_type_plural = "STREAMLITS"
#       in_schema          = "\"ANALYTICS\".\"FINANCE\""
#     }
#   }

#   privileges        = ["USAGE"]
#   role_name         = "ANALYTICS_FINANCE_SR"
#   with_grant_option = false

#   depends_on = [snowflake_grant_privileges_to_role.grants_database_sr, snowflake_grant_privileges_to_role.grants_schema_sr]
# }