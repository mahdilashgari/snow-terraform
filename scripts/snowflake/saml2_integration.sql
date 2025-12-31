use role ACCOUNTADMIN;

DROP INTEGRATION IF EXISTS AzureAD;

CREATE OR REPLACE SECURITY INTEGRATION
AzureAD
TYPE = SAML2
ENABLED = TRUE
SAML2_ISSUER = 'https://sts.windows.net/a0e43afe-ad2b-4714-8244-a7b82df24eb4/'
SAML2_SSO_URL = 'https://login.microsoftonline.com/a0e43afe-ad2b-4714-8244-a7b82df24eb4/saml2'
SAML2_PROVIDER = 'CUSTOM'
SAML2_X509_CERT = '<cert_here>'
SAML2_ENABLE_SP_INITIATED = TRUE
;

 CREATE USER svc_snowflake_prov PASSWORD = '' LOGIN_NAME = 'svc-snowflake-prov@xing.com' DISPLAY_NAME = 'svc-snowflake-prov';
  
 alter account set sso_login_page = true;
 
 
 create role if not exists aad_provisioner;
 grant create user on account to role aad_provisioner;
 grant create role on account to role aad_provisioner;
grant role aad_provisioner to role accountadmin;
grant role aad_provisioner to role useradmin;
 create or replace security integration aad_provisioning
     type = scim
     scim_client = 'azure'
     run_as_role = 'AAD_PROVISIONER';
 select system$generate_scim_access_token('AAD_PROVISIONING');
 
 alter INTEGRATION azuread
 set saml2_snowflake_issuer_url = 'https://nwse-dwh.snowflakecomputing.com'
saml2_snowflake_acs_url = 'https://nwse-dwh.snowflakecomputing.com/fed/login'
;