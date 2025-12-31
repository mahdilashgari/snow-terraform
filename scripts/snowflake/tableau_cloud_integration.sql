--docs: https://docs.snowflake.com/en/sql-reference/sql/create-security-integration-oauth-snowflake#examples

use role ACCOUNTADMIN;

create security integration oauth_tableau_desktop
  type = oauth
  enabled = true
  oauth_client = tableau_desktop
  blocked_roles_list = (
    'ACCOUNTADMIN','ORGADMIN','SECURITYADMIN',
    'BI_DBT','BI_ADHOC','BI_FULL','DBT_PIPELINE',
    'BU_XING_ADHOC','BU_XING_DBT',
    'BU_ONLYFY_ADHOC', 'BU_ONLYFY_IMPORTER','BU_ONLYFY_DBT',
    'BU_XMS_ADHOC','BU_XMS_DBT',
    'BU_HONEYPOT_ADHOC','GITHUB_PIPELINE', 'PUBLIC_SNOWFLAKE'
  );
  
create security integration oauth_tableau_cloud
  type = oauth
  enabled = true
  oauth_client = tableau_server
  blocked_roles_list = (
    'ACCOUNTADMIN','ORGADMIN','SECURITYADMIN',
    'BI_DBT','BI_ADHOC','BI_FULL','DBT_PIPELINE',
    'BU_XING_ADHOC','BU_XING_DBT',
    'BU_ONLYFY_ADHOC', 'BU_ONLYFY_IMPORTER','BU_ONLYFY_DBT',
    'BU_XMS_ADHOC','BU_XMS_DBT',
    'BU_HONEYPOT_ADHOC','GITHUB_PIPELINE', 'PUBLIC_SNOWFLAKE'
  );
  
  --drop security integration tableau_desktop_oauth;

show security integrations;

describe security integration OAUTH_TABLEAU_DESKTOP;