-- execute governance module for role creation
-- then apply these account level privileges
-- then execute governance module again

USE ROLE ACCOUNTADMIN;

GRANT APPLY TAG ON ACCOUNT TO ROLE governance_admin;
GRANT APPLY TAG ON ACCOUNT TO ROLE governance_engineer;

grant apply masking policy on account to role governance_admin;