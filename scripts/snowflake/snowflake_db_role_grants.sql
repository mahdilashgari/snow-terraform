USE ROLE ACCOUNTADMIN;

-- needed to create cost reporting
grant database role snowflake.governance_viewer to role bi_reader;
grant database role snowflake.object_viewer to role bi_reader;
grant database role snowflake.organization_billing_viewer to role bi_reader;
grant database role snowflake.organization_usage_viewer to role bi_reader;
grant database role snowflake.usage_viewer to role bi_reader;

-- data governance roles
-- admin
grant database role snowflake.governance_admin to role governance_admin;
grant database role snowflake.governance_viewer to role governance_admin;
grant database role snowflake.object_viewer to role governance_admin;

-- engineer
grant database role snowflake.governance_viewer to role governance_engineer;
grant database role snowflake.object_viewer to role governance_engineer;

-- viewer
grant database role snowflake.governance_viewer to role governance_viewer;
grant database role snowflake.object_viewer to role governance_viewer;

-- temp add snowflake db roles directly to functional roles
grant database role snowflake.governance_viewer to role bi_adhoc;
grant database role snowflake.object_viewer to role bi_adhoc;

grant database role snowflake.governance_viewer to role bi_dbt;
grant database role snowflake.object_viewer to role bi_dbt;

grant database role snowflake.governance_viewer to role bi_full;
grant database role snowflake.object_viewer to role bi_full;

grant database role snowflake.governance_viewer to role bu_xing_dbt;
grant database role snowflake.object_viewer to role bu_xing_dbt;

grant database role snowflake.governance_viewer to role bu_xing_adhoc;
grant database role snowflake.object_viewer to role bu_xing_adhoc;

grant database role snowflake.governance_viewer to role bu_xms_adhoc;
grant database role snowflake.object_viewer to role bu_xms_adhoc;

grant database role snowflake.governance_viewer to role bu_xms_dbt;
grant database role snowflake.object_viewer to role bu_xms_dbt;

grant database role snowflake.governance_viewer to role bu_onlyfy_adhoc;
grant database role snowflake.object_viewer to role bu_onlyfy_adhoc;

grant database role snowflake.governance_viewer to role bu_onlyfy_dbt;
grant database role snowflake.object_viewer to role bu_onlyfy_dbt;

-- granting cortex roles
grant database role snowflake.cortex_user to role public_snowflake;

grant database role snowflake.cortex_user to role bi_adhoc;

grant database role snowflake.cortex_user to role bi_dbt;

grant database role snowflake.cortex_user to role bi_full;

grant database role snowflake.cortex_user to role bu_xing_dbt;

grant database role snowflake.cortex_user to role bu_xing_adhoc;

grant database role snowflake.cortex_user to role bu_xms_adhoc;

grant database role snowflake.cortex_user to role bu_xms_dbt;

grant database role snowflake.cortex_user to role bu_onlyfy_adhoc;

grant database role snowflake.cortex_user to role bu_onlyfy_dbt;

