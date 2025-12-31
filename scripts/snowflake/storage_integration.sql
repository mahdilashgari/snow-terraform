use role accountadmin;

CREATE OR REPLACE STORAGE INTEGRATION S3_BI
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::489344626188:role/snowflake_s3_role'
  STORAGE_ALLOWED_LOCATIONS = (
        's3://nwse-bi-staging-prod/', 
        's3://bi-kpi-export-prod/',
        's3://bi-kununu-export-prod/',
        's3://nwse-bi-marketing-prod/',
        's3://bi-snowflake-export-prod/'
  );

-- required in order to create stages through Terraform
grant usage on integration S3_BI to role SYSADMIN;

CREATE OR REPLACE STORAGE INTEGRATION S3_BI_PREVIEW
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::588342202244:role/snowflake_s3_role'
  STORAGE_ALLOWED_LOCATIONS = (
        's3://nwse-bi-staging-test/',
        's3://bi-kpi-export-test/',
        's3://bi-kununu-export-test/',
        's3://bi-snowflake-export-test/'
    );

  -- required in order to create stages through Terraform
grant usage on integration S3_BI_PREVIEW to role SYSADMIN;
