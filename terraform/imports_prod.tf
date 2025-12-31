#aws
# import {
#   to = aws_iam_role.github_action_role
#   id = "nw-role-github-actions-snowflake"
# }

# import {
#   to = aws_iam_policy.terraform_policy
#   id = "arn:aws:iam::489344626188:policy/terraform_policy"
# }

# import {
#   to = aws_iam_role_policy_attachment.terraform_github_attachment
#   id = "nw-role-github-actions-snowflake/arn:aws:iam::489344626188:policy/terraform_policy"
# }

# #technical users
# import {
#   to = module.users_technical.snowflake_user.users_technical["AIRFLOW_USER"]
#   id = "\"AIRFLOW_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["APPFLOW_USER"]
#   id = "\"APPFLOW_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["DBT_USER"]
#   id = "\"DBT_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["GITHUB_USER"]
#   id = "\"GITHUB_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["HONEYPOT_USER"]
#   id = "\"HONEYPOT_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["NEW_WORK_SE_USER"]
#   id = "\"NEW_WORK_SE_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["NEW_WORK_SE_USER_TEST_ML"]
#   id = "\"NEW_WORK_SE_USER_TEST_ML\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["NEW_WORK_SE_USER_TEST_MOH"]
#   id = "\"NEW_WORK_SE_USER_TEST_MOH\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["ONLYFY_IMPORT_USER"]
#   id = "\"ONLYFY_IMPORT_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["TABLEAU_BI_ACCOUNTING_USER"]
#   id = "\"TABLEAU_BI_ACCOUNTING_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["TABLEAU_BI_FINANCE_USER"]
#   id = "\"TABLEAU_BI_FINANCE_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["TABLEAU_BI_HUMAN_RESOURCES_USER"]
#   id = "\"TABLEAU_BI_HUMAN_RESOURCES_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["TABLEAU_BI_IMPORT_USER"]
#   id = "\"TABLEAU_BI_IMPORT_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["TABLEAU_BI_USER"]
#   id = "\"TABLEAU_BI_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["TABLEAU_BSTEERING_USER"]
#   id = "\"TABLEAU_BSTEERING_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["TABLEAU_KUNUNU_USER"]
#   id = "\"TABLEAU_KUNUNU_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["TABLEAU_ONLYFY_USER"]
#   id = "\"TABLEAU_ONLYFY_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["TABLEAU_PB_USER"]
#   id = "\"TABLEAU_PB_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["TABLEAU_XING_USER"]
#   id = "\"TABLEAU_XING_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["TABLEAU_XMS_USER"]
#   id = "\"TABLEAU_XMS_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["XING_IMPORT_USER"]
#   id = "\"XING_IMPORT_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["XMS_IMPORT_USER"]
#   id = "\"XMS_IMPORT_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["REPORTING_POC"]
#   id = "\"REPORTING_POC\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["CDP_SEGMENT_USER"]
#   id = "\"CDP_SEGMENT_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["POC_ATS_USER"]
#   id = "\"POC_ATS_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["ASTRO_USER"]
#   id = "\"ASTRO_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["SELECT_DEV_USER"]
#   id = "\"SELECT_DEV_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["THOUGHTSPOT_USER"]
#   id = "\"THOUGHTSPOT_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["ACTIVE_SOURCING_USER"]
#   id = "\"ACTIVE_SOURCING_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["ANALYTICS_HACKWEEK_USER"]
#   id = "\"ANALYTICS_HACKWEEK_USER\""
# }

# import {
#   to = module.users_technical.snowflake_user.users_technical["SALESFORCE_DATA_CLOUD_USER"]
#   id = "\"SALESFORCE_DATA_CLOUD_USER\""
# }


# # network policies
# import {
#   to = snowflake_network_policy.active_sourcing_policy
#   id = "\"ACTIVE_SOURCING_POLICY\""
# }

# import {
#   to = snowflake_network_policy.appflow_policy
#   id = "\"APPFLOW_POLICY\""
# }

# import {
#   to = snowflake_network_policy.astronomer_policy
#   id = "\"ASTRONOMER_POLICY\""
# }

# import {
#   to = snowflake_network_policy.cdp_segment_policy
#   id = "\"CDP_SEGMENT_POLICY\""
# }

# import {
#   to = snowflake_network_policy.dbt_cloud_policy
#   id = "\"DBT_CLOUD_POLICY\""
# }

# import {
#   to = snowflake_network_policy.empty_policy
#   id = "\"EMTPY_POLICY\""
# }

# import {
#   to = snowflake_network_policy.github_runner_policy
#   id = "\"GITHUB_RUNNER_POLICY\""
# }

# import {
#   to = snowflake_network_policy.nwse_policy
#   id = "\"NWSE_POLICY\""
# }

# import {
#   to = snowflake_network_policy.poc_ats_policy
#   id = "\"POC_ATS_POLICY\""
# }

# import {
#   to = snowflake_network_policy.salesforce_data_cloud_policy
#   id = "\"SALESFORCE_DATA_CLOUD_POLICY\""
# }

# import {
#   to = snowflake_network_policy.select_dev_policy
#   id = "\"SELECT_DEV_POLICY\""
# }

# import {
#   to = snowflake_network_policy.tableau_cloud_policy
#   id = "\"TABLEAU_CLOUD_POLICY\""
# }

# import {
#   to = snowflake_network_policy.thoughtspot_policy
#   id = "\"THOUGHTSPOT_POLICY\""
# }

# #network policies attached to users
# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["AIRFLOW_USER"]
#   id = "\"NWSE_POLICY\"|\"AIRFLOW_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["APPFLOW_USER"]
#   id = "\"APPFLOW_POLICY\"|\"APPFLOW_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["DBT_USER"]
#   id = "\"DBT_CLOUD_POLICY\"|\"DBT_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["GITHUB_USER"]
#   id = "\"GITHUB_RUNNER_POLICY\"|\"GITHUB_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["HONEYPOT_USER"]
#   id = "\"NWSE_POLICY\"|\"HONEYPOT_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["NEW_WORK_SE_USER"]
#   id = "\"NWSE_POLICY\"|\"NEW_WORK_SE_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["NEW_WORK_SE_USER_TEST_ML"]
#   id = "\"NWSE_POLICY\"|\"NEW_WORK_SE_USER_TEST_ML\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["NEW_WORK_SE_USER_TEST_MOH"]
#   id = "\"NWSE_POLICY\"|\"NEW_WORK_SE_USER_TEST_MOH\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["ONLYFY_IMPORT_USER"]
#   id = "\"NWSE_POLICY\"|\"ONLYFY_IMPORT_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["TABLEAU_BI_ACCOUNTING_USER"]
#   id = "\"TABLEAU_CLOUD_POLICY\"|\"TABLEAU_BI_ACCOUNTING_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["TABLEAU_BI_FINANCE_USER"]
#   id = "\"TABLEAU_CLOUD_POLICY\"|\"TABLEAU_BI_FINANCE_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["TABLEAU_BI_HUMAN_RESOURCES_USER"]
#   id = "\"TABLEAU_CLOUD_POLICY\"|\"TABLEAU_BI_HUMAN_RESOURCES_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["TABLEAU_BI_IMPORT_USER"]
#   id = "\"TABLEAU_CLOUD_POLICY\"|\"TABLEAU_BI_IMPORT_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["TABLEAU_BI_USER"]
#   id = "\"TABLEAU_CLOUD_POLICY\"|\"TABLEAU_BI_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["TABLEAU_BSTEERING_USER"]
#   id = "\"TABLEAU_CLOUD_POLICY\"|\"TABLEAU_BSTEERING_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["TABLEAU_KUNUNU_USER"]
#   id = "\"TABLEAU_CLOUD_POLICY\"|\"TABLEAU_KUNUNU_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["TABLEAU_ONLYFY_USER"]
#   id = "\"TABLEAU_CLOUD_POLICY\"|\"TABLEAU_ONLYFY_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["TABLEAU_PB_USER"]
#   id = "\"TABLEAU_CLOUD_POLICY\"|\"TABLEAU_PB_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["TABLEAU_XING_USER"]
#   id = "\"TABLEAU_CLOUD_POLICY\"|\"TABLEAU_XING_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["TABLEAU_XMS_USER"]
#   id = "\"TABLEAU_CLOUD_POLICY\"|\"TABLEAU_XMS_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["XING_IMPORT_USER"]
#   id = "\"NWSE_POLICY\"|\"XING_IMPORT_USER\""
# }

# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["XMS_IMPORT_USER"]
#   id = "\"NWSE_POLICY\"|\"XMS_IMPORT_USER\""
# }
# #REPORTING_POC
# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["REPORTING_POC"]
#   id = "\"EMTPY_POLICY\"|\"REPORTING_POC\""
# }
# #CDP_SEGMENT_USER
# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["CDP_SEGMENT_USER"]
#   id = "\"CDP_SEGMENT_POLICY\"|\"CDP_SEGMENT_USER\""
# }
# #POC_ATS_USER
# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["POC_ATS_USER"]
#   id = "\"POC_ATS_POLICY\"|\"POC_ATS_USER\""
# }
# #ASTRO_USER
# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["ASTRO_USER"]
#   id = "\"ASTRONOMER_POLICY\"|\"ASTRO_USER\""
# }
# #SELECT_DEV_USER
# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["SELECT_DEV_USER"]
#   id = "\"SELECT_DEV_POLICY\"|\"SELECT_DEV_USER\""
# }
# #THOUGHTSPOT_USER
# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["THOUGHTSPOT_USER"]
#   id = "\"THOUGHTSPOT_POLICY\"|\"THOUGHTSPOT_USER\""
# }
# #ACTIVE_SOURCING_USER
# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["ACTIVE_SOURCING_USER"]
#   id = "\"ACTIVE_SOURCING_POLICY\"|\"ACTIVE_SOURCING_USER\""
# }
# #ANALYTICS_HACKWEEK_USER
# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["ANALYTICS_HACKWEEK_USER"]
#   id = "\"NWSE_POLICY\"|\"ANALYTICS_HACKWEEK_USER\""
# }
# #SALESFORCE_DATA_CLOUD_USER
# import {
#   to = module.users_technical.snowflake_network_policy_attachment.user_attach["SALESFORCE_DATA_CLOUD_USER"]
#   id = "\"SALESFORCE_DATA_CLOUD_POLICY\"|\"SALESFORCE_DATA_CLOUD_USER\""
# }

#roles:

# import {
#   for_each = local.roles_access_config
#   to       = module.roles.snowflake_account_role.roles_access_sr["${each.value.database_name}_${each.value.schema_name}"]
#   id       = "\"${each.value.database_name}_${each.value.schema_name}_SR\""
# }

# import {
#   for_each = local.roles_access_config
#   to       = module.roles.snowflake_account_role.roles_access_srw["${each.value.database_name}_${each.value.schema_name}"]
#   id       = "\"${each.value.database_name}_${each.value.schema_name}_SRW\""
# }

# import {
#   for_each = local.roles_access_config
#   to       = module.roles.snowflake_account_role.roles_access_sfull["${each.value.database_name}_${each.value.schema_name}"]
#   id       = "\"${each.value.database_name}_${each.value.schema_name}_SFULL\""
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_all_source_schemas_sfull["LANDING_ZONE"]
#   id = "LANDING_ZONE_ALL_SOURCES_SFULL"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_all_source_schemas_sr["LANDING_ZONE"]
#   id = "LANDING_ZONE_ALL_SOURCES_SR"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_all_source_schemas_srw["LANDING_ZONE"]
#   id = "LANDING_ZONE_ALL_SOURCES_SRW"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_all_source_schemas_sfull["RAW"]
#   id = "RAW_ALL_SOURCES_SFULL"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_all_source_schemas_sr["RAW"]
#   id = "RAW_ALL_SOURCES_SR"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_all_source_schemas_srw["RAW"]
#   id = "RAW_ALL_SOURCES_SRW"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_all_source_schemas_sfull["SNAPSHOTS"]
#   id = "SNAPSHOTS_ALL_SOURCES_SFULL"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_all_source_schemas_sr["SNAPSHOTS"]
#   id = "SNAPSHOTS_ALL_SOURCES_SR"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_all_source_schemas_srw["SNAPSHOTS"]
#   id = "SNAPSHOTS_ALL_SOURCES_SRW"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_all_staging_schemas_sfull["STAGING"]
#   id = "STAGING_ALL_SCHEMAS_SFULL"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_all_staging_schemas_sr["STAGING"]
#   id = "STAGING_ALL_SCHEMAS_SR"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_all_staging_schemas_srw["STAGING"]
#   id = "STAGING_ALL_SCHEMAS_SRW"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_all_intermediate_schemas_sfull["INTERMEDIATE"]
#   id = "INTERMEDIATE_ALL_INTERMEDIATE_SFULL"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_all_intermediate_schemas_sr["INTERMEDIATE"]
#   id = "INTERMEDIATE_ALL_INTERMEDIATE_SR"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_all_intermediate_schemas_srw["INTERMEDIATE"]
#   id = "INTERMEDIATE_ALL_INTERMEDIATE_SRW"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_db_create
#   id = "DB_CREATE"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_schema_create["SNAPSHOTS"]
#   id = "SNAPSHOTS_SCHEMA_CREATE"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_schema_create["STAGING"]
#   id = "STAGING_SCHEMA_CREATE"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_schema_create["ANALYTICS"]
#   id = "ANALYTICS_SCHEMA_CREATE"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_schema_create["ANALYTICS_WORKAREA"]
#   id = "ANALYTICS_WORKAREA_SCHEMA_CREATE"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_schema_create["INTERNAL"]
#   id = "INTERNAL_SCHEMA_CREATE"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_schema_create["LANDING_ZONE"]
#   id = "LANDING_ZONE_SCHEMA_CREATE"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_schema_create["RAW"]
#   id = "RAW_SCHEMA_CREATE"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_schema_create["REPORTING"]
#   id = "REPORTING_SCHEMA_CREATE"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_schema_create["ATS_REPORTING"]
#   id = "ATS_REPORTING_SCHEMA_CREATE"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_schema_create["DBT_DEV"]
#   id = "DBT_DEV_SCHEMA_CREATE"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_schema_create["INTERMEDIATE"]
#   id = "INTERMEDIATE_SCHEMA_CREATE"
# }

# import {
#   to = module.roles.snowflake_account_role.roles_access_schema_create["EXPORT"]
#   id = "EXPORT_SCHEMA_CREATE"
# }

# import {
#   for_each = local.roles_functional_config
#   to       = module.roles.snowflake_account_role.roles_functional["${each.value.name}"]
#   id       = "\"${each.value.name}\""
# }

#databases:
# import {
#   for_each = local.databases_config
#   to       = module.databases.snowflake_database.databases["${each.value.name}"]
#   id       = "\"${each.value.name}\""
# }

# import {
#   for_each = merge(local.schemas_config, local.source_system_schemas_config) #, local.staging_schemas_config, local.intermediate_schemas_config
#   to       = module.databases.snowflake_schema.schemas["${each.value.database}_${each.value.name}"]
#   id       = "\"${each.value.database}\".\"${each.value.name}\""
# }

# import {
#   for_each = merge(local.staging_schemas_config, local.intermediate_schemas_config)
#   to       = module.databases.snowflake_schema.schemas["${each.value.database_name}_${each.value.schema_name}"]
#   id       = "\"${each.value.database_name}\".\"${each.value.schema_name}\""
# }

#warehouses
# import {
#   for_each = local.warehouses_config
#   to       = module.warehouses.snowflake_warehouse.warehouses["${each.value.name}_${each.value.warehouse_size}"]
#   id       = "\"${each.value.name}_${each.value.warehouse_size}\""
# }

#stages:
# import {
#   for_each = local.source_system_schemas_config_for_stages
#   to       = module.stages.snowflake_stage.landing_zone_stages["LANDING_ZONE_${each.value.name}"]
#   id       = "\"LANDING_ZONE|${each.value.name}|BI_STAGE\""
# }

# import {
#   for_each = toset(["CENTRAL", "ONLYFY", "XMS", "XING"])
#   to       = module.stages.snowflake_stage.bi_kpi_export_prod_stages["${each.value}"]
#   id       = "\"ANALYTICS|${each.value}|S3_BI_KPI_EXPORT_PROD_STAGE\""
# }

# import {
#   for_each = toset(["CENTRAL", "ONLYFY", "XMS", "XING"])
#   to       = module.stages.snowflake_stage.bi_kpi_export_test_stages["${each.value}"]
#   id       = "\"ANALYTICS|${each.value}|S3_BI_KPI_EXPORT_TEST_STAGE\""
# }

# import {
#   for_each = toset(["CENTRAL"])
#   to       = module.stages.snowflake_stage.bi_kununu_export_prod_stages["${each.value}"]
#   id       = "\"ANALYTICS|${each.value}|S3_BI_KUNUNU_EXPORT_PROD_STAGE\""
# }

# import {
#   for_each = toset(["CENTRAL"])
#   to       = module.stages.snowflake_stage.bi_kununu_export_test_stages["${each.value}"]
#   id       = "\"ANALYTICS|${each.value}|S3_BI_KUNUNU_EXPORT_TEST_STAGE\""
# }

# import {
#   for_each = toset(["BRAZE_XING", "BRAZE_API_XING"])
#   to       = module.stages.snowflake_stage.braze_xing_stage_landing_zone["${each.value}"]
#   id       = "\"LANDING_ZONE|${each.value}|BRAZE_XING_STAGE\""
# }

# import {
#   to = module.stages.snowflake_stage.braze_onlyfy_stage_landing_zone
#   id = "\"LANDING_ZONE|BRAZE_ONLYFY|BRAZE_ONLYFY_STAGE\""
# }

# import {
#   to = module.stages.snowflake_stage.onlyfy_jobs_stage_landing_zone
#   id = "\"LANDING_ZONE|ONLYFY_JOBS|ONLYFY_JOBS_STAGE\""
# }

# import {
#   for_each = toset(["MARIADB_PRESCREEN", "MARIADB_TALENTHUB", "MARIADB_ECOM", "MARIADB_EMPLOYER_BRANDING_PROFILE"])
#   to       = module.stages.snowflake_stage.onlyfy_stage_landing_zone["${each.value}"]
#   id       = "\"LANDING_ZONE|${each.value}|ONLYFY_STAGE\""
# }

# import {
#   to = module.stages.snowflake_stage.funnelio_stage_landing_zone
#   id = "\"LANDING_ZONE|FUNNELIO|FUNNELIO_STAGE\""
# }

# import {
#   to = module.stages.snowflake_stage.the_trade_desk_stage_landing_zone["THE_TRADE_DESK"]
#   id = "\"LANDING_ZONE|THE_TRADE_DESK|THE_TRADE_DESK_STAGE\""
# }

# import {
#   for_each = local.source_system_schemas_config_for_stages
#   to       = module.stages.snowflake_stage.landing_zone_preview_stages["LANDING_ZONE_${each.value.name}"]
#   id       = "\"LANDING_ZONE|${each.value.name}|BI_STAGE_PREVIEW\""
# }

# import {
#   to = module.stages.snowflake_stage.xing_kpi_export_prod_stages["XING"]
#   id = "\"ANALYTICS|XING|S3_XING_KPI_EXPORT_PROD_STAGE\""
# }

# import {
#   to = module.stages.snowflake_stage.xing_kpi_export_test_stages["XING"]
#   id = "\"ANALYTICS|XING|S3_XING_KPI_EXPORT_TEST_STAGE\""
# }

# import {
#   for_each = local.source_system_schemas_config_for_stages
#   to       = module.stages.snowflake_stage.landing_zone_marketing_stages["LANDING_ZONE_${each.value.name}"]
#   id       = "\"LANDING_ZONE|${each.value.name}|MARKETING_STAGE\""
# }

# import {
#   for_each = toset(["CENTRAL", "ONLYFY", "XMS", "XING"])
#   to       = module.stages.snowflake_stage.analytics_unload_stage["${each.value}"]
#   id       = "\"ANALYTICS|${each.value}|ANALYTICS_UNLOAD_STAGE\""
# }

# import {
#   for_each = toset(["CENTRAL", "ONLYFY", "XMS", "XING", "GENERAL"])
#   to       = module.stages.snowflake_stage.analytics_workarea_stage["${each.value}"]
#   id       = "\"ANALYTICS_WORKAREA|${each.value}|ANALYTICS_WORKAREA_STAGE\""
# }

# import {
#   to = module.stages.snowflake_stage.bi_snowflake_export_prod_stages["CENTRAL"]
#   id = "\"ANALYTICS|CENTRAL|S3_BI_SNOWFLAKE_EXPORT_PROD_STAGE\""
# }

# import {
#   to = module.stages.snowflake_stage.bi_snowflake_export_test_stages["CENTRAL"]
#   id = "\"ANALYTICS|CENTRAL|S3_BI_SNOWFLAKE_EXPORT_TEST_STAGE\""
# }

# import {
#   for_each = toset(["CENTRAL", "ONLYFY", "XMS", "XING"])
#   to       = module.stages.snowflake_stage.bi_snowflake_export_to_databse_prod_stages["${each.value}"]
#   id       = "\"ANALYTICS|${each.value}|S3_BI_SNOWFLAKE_EXPORT_TO_DATABASE_PROD_STAGE\""
# }

# import {
#   for_each = toset(["CENTRAL", "ONLYFY", "XMS", "XING"])
#   to       = module.stages.snowflake_stage.bi_snowflake_export_to_database_test_stages["${each.value}"]
#   id       = "\"ANALYTICS|${each.value}|S3_BI_SNOWFLAKE_EXPORT_TO_DATABASE_TEST_STAGE\""
# }

# import {
#   to = module.stages.snowflake_stage.jobs_platform_snowflake_stg_prev
#   id = "\"ANALYTICS|XING|S3_XING_JOBS_PLATFORM_STG_PREVIEW\""
# }

# import {
#   to = module.stages.snowflake_stage.jobs_platform_snowflake_stg_prod
#   id = "\"ANALYTICS|XING|S3_XING_JOBS_PLATFORM_STAGE_PRODUCTION\""
# }


#########
#GRANTS#
#########
# format is role_name (string) | grantee_object_type (ROLE|USER) | grantee_name (string)
#terraform import snowflake_grant_account_role.example '"test_role"|ROLE|"test_parent_role"'

#grants/grants_access_all_sources.tf
# import {
#   for_each = local.all_sources_roles_access_config
#   to       = module.grants.snowflake_grant_account_role.grant_schema_access_to_all_access_sr["${each.value.database_name}_${each.value.schema_name}"]
#   id       = "\"${each.value.database_name}_${each.value.schema_name}_SR|ROLE|${each.value.database_name}_ALL_SOURCES_SR\""
# }

#######
######
#####
####
###
##
#
# grants cannot be imported because of the differences between old and new provider versions
# in the old one, the id is defined as "role_name|grantee_name" while in the new one it is "role_name|grantee_object_type|grantee_name"
# this is why the import is not working, and we have to use the new provider version
#
##
###
####
#####
######
#######
########


# #grants future ownership had to be imported manually:
# import {
#   for_each = local.roles_access_config
#   to       = module.grants.snowflake_grant_ownership.grants_future_tables_sfull["${each.value.database_name}_${each.value.schema_name}"]
#   id       = "ToAccountRole|\"${each.value.database_name}_${each.value.schema_name}_SFULL\"|COPY|OnFuture|TABLES|InSchema|\"${each.value.database_name}\".\"${each.value.schema_name}\""
# }

# import {
#   for_each = local.roles_access_config
#   to       = module.grants.snowflake_grant_ownership.grants_future_views_sfull["${each.value.database_name}_${each.value.schema_name}"]
#   id       = "ToAccountRole|\"${each.value.database_name}_${each.value.schema_name}_SFULL\"|COPY|OnFuture|VIEWS|InSchema|\"${each.value.database_name}\".\"${each.value.schema_name}\""
# }

# import {
#   for_each = local.roles_access_config
#   to       = module.grants.snowflake_grant_ownership.grants_future_file_formats_sfull["${each.value.database_name}_${each.value.schema_name}"]
#   id       = "ToAccountRole|\"${each.value.database_name}_${each.value.schema_name}_SFULL\"|COPY|OnFuture|FILE FORMATS|InSchema|\"${each.value.database_name}\".\"${each.value.schema_name}\""
# }

# import {
#   for_each = local.roles_access_config
#   to       = module.grants.snowflake_grant_ownership.grants_future_streams_sfull["${each.value.database_name}_${each.value.schema_name}"]
#   id       = "ToAccountRole|\"${each.value.database_name}_${each.value.schema_name}_SFULL\"|COPY|OnFuture|STREAMS|InSchema|\"${each.value.database_name}\".\"${each.value.schema_name}\""
# }

# import {
#   for_each = local.roles_access_config
#   to       = module.grants.snowflake_grant_ownership.grants_future_procedures_sfull["${each.value.database_name}_${each.value.schema_name}"]
#   id       = "ToAccountRole|\"${each.value.database_name}_${each.value.schema_name}_SFULL\"|COPY|OnFuture|PROCEDURES|InSchema|\"${each.value.database_name}\".\"${each.value.schema_name}\""
# }

# import {
#   for_each = local.roles_access_config
#   to       = module.grants.snowflake_grant_ownership.grants_future_functions_sfull["${each.value.database_name}_${each.value.schema_name}"]
#   id       = "ToAccountRole|\"${each.value.database_name}_${each.value.schema_name}_SFULL\"|COPY|OnFuture|FUNCTIONS|InSchema|\"${each.value.database_name}\".\"${each.value.schema_name}\""
# }

# import {
#   for_each = local.roles_access_config
#   to       = module.grants.snowflake_grant_ownership.grants_future_sequences_sfull["${each.value.database_name}_${each.value.schema_name}"]
#   id       = "ToAccountRole|\"${each.value.database_name}_${each.value.schema_name}_SFULL\"|COPY|OnFuture|SEQUENCES|InSchema|\"${each.value.database_name}\".\"${each.value.schema_name}\""
# }

# import {
#   for_each = local.roles_access_config
#   to       = module.grants.snowflake_grant_ownership.grants_future_tasks_sfull["${each.value.database_name}_${each.value.schema_name}"]
#   id       = "ToAccountRole|\"${each.value.database_name}_${each.value.schema_name}_SFULL\"|COPY|OnFuture|TASKS|InSchema|\"${each.value.database_name}\".\"${each.value.schema_name}\""
# }


# ####################
# # data_governance modules #
# ####################
# import {
#   to = module.data_governance.snowflake_account_role.role_governance_admin
#   id = "\"GOVERNANCE_ADMIN\""
# }

# import {
#   to = module.data_governance.snowflake_account_role.role_governance_engineer
#   id = "\"GOVERNANCE_ENGINEER\""
# }

# import {
#   to = module.data_governance.snowflake_account_role.role_governance_pii_viewer
#   id = "\"GOVERNANCE_PII_VIEWER\""
# }

# import {
#   to = module.data_governance.snowflake_account_role.role_governance_viewer
#   id = "\"GOVERNANCE_VIEWER\""
# }

# import {
#   to = module.data_governance.snowflake_account_role.role_governance_pii_viewer_kununu
#   id = "\"GOVERNANCE_PII_VIEWER_KUNUNU\""
# }

# import {
#   to = module.data_governance.snowflake_account_role.role_governance_pii_viewer_amqp
#   id = "\"GOVERNANCE_PII_VIEWER_AMQP\""
# }

# # governance tags
# import {
#   to = module.data_governance.snowflake_tag.tag_governance_pii_privacy_category
#   id = "\"INTERNAL\".\"GOVERNANCE\".\"PII_PRIVACY_CATEGORY\""
# }

# import {
#   to = module.data_governance.snowflake_tag.tag_governance_pii_id
#   id = "\"INTERNAL\".\"GOVERNANCE\".\"PII_ID\""
# }

# import {
#   to = module.data_governance.snowflake_tag.tag_governance_production_status
#   id = "\"INTERNAL\".\"GOVERNANCE\".\"PRODUCTION_STATUS\""
# }

# # governance masking policies
# import {
#   to = module.data_governance.snowflake_masking_policy.masking_policy_mask_pii
#   id = "\"INTERNAL\".\"GOVERNANCE\".\"MASK_PII\""
# }

# import {
#   to = module.data_governance.snowflake_masking_policy.masking_policy_date_mask_pii
#   id = "\"INTERNAL\".\"GOVERNANCE\".\"MASK_DATE_PII\""
# }

# import {
#   to = module.data_governance.snowflake_masking_policy.masking_policy_timestamp_mask_pii
#   id = "\"INTERNAL\".\"GOVERNANCE\".\"MASK_TIMESTAMP_PII\""
# }

# import {
#   to = module.data_governance.snowflake_masking_policy.masking_policy_array_mask_pii
#   id = "\"INTERNAL\".\"GOVERNANCE\".\"MASK_ARRAY_PII\""
# }
