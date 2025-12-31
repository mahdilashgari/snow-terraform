use role securityadmin;
CREATE USER "<terraform-user-name-here>" RSA_PUBLIC_KEY='<ssh public key here>' DEFAULT_ROLE=PUBLIC MUST_CHANGE_PASSWORD=FALSE;

use role accountadmin;

GRANT ROLE SYSADMIN to USER "<terraform-user-name-here>";
GRANT ROLE USERADMIN to USER "<terraform-user-name-here>";
GRANT ROLE SECURITYADMIN to USER "<terraform-user-name-here>";
GRANT ROLE COMPLIANCE_ADMIN to USER "<terraform-user-name-here>";

GRANT ROLE GOVERNANCE_ADMIN to USER "<terraform-user-name-here>";

-- network policy is attached to user during first execution of terraform apply