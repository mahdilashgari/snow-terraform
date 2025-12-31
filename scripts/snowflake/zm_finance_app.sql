-- streamlit privileges are not yet available in our current
-- Terraform Snowflake provider version. It is only supported
-- after version 0.94.0 which contains many breaking changes
-- and has to be investigated thoroughly before upgrading.
-- For now, this workaround was used.
use role sysadmin;
grant create streamlit on schema "ANALYTICS"."FINANCE" to role ANALYTICS_FINANCE_SFULL;

GRANT usage ON streamlit identifier('"ANALYTICS"."FINANCE"."R8V5L5LC7B6Z_7CS"') TO ROLE identifier('"BI_READER_FINANCE"')