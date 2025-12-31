-- Changing the GDPR WH to the faster version for solving the 6 hours Github timeout for the big tables.
-- Snowflake Gen2 standard warehouses are priced at approximately 1.35 times the cost of Gen1 warehouses on AWS and 1.25 times on Azure. While more expensive, they offer improved performance and cost efficiency. 

-------------------------------------------------------------------------------------------------------------------------------------------
-- Important note: Please use Terraform for these two warehouses when we have Terraform v2.7 or above. For now, I will do it manually by SQL.
-------------------------------------------------------------------------------------------------------------------------------------------

use role ACCOUNTADMIN;

create or replace warehouse BI_GDPR_WH_GEN2_XXXLARGE
with
	warehouse_type='STANDARD'
	warehouse_size='3X-Large'
	max_cluster_count=2
	min_cluster_count=1
	scaling_policy=STANDARD
    RESOURCE_CONSTRAINT = STANDARD_GEN_2
	auto_suspend=60
	auto_resume=TRUE
	initially_suspended=TRUE
	COMMENT='Slightly extended warehouses gen 2 for gdpr related workloads'
	enable_query_acceleration=TRUE
	query_acceleration_max_scale_factor=8
	max_concurrency_level=8
	statement_queued_timeout_in_seconds=0
	statement_timeout_in_seconds=7200
;

GRANT USAGE ON WAREHOUSE BI_GDPR_WH_GEN2_XXXLARGE TO ROLE GOVERNANCE_ENGINEER;


----------------


use role ACCOUNTADMIN;

create or replace warehouse BI_GDPR_WH_GEN2_XLARGE
with
	warehouse_type='STANDARD'
	warehouse_size='X-Large'
	max_cluster_count=2
	min_cluster_count=1
	scaling_policy=STANDARD
    RESOURCE_CONSTRAINT = STANDARD_GEN_2
	auto_suspend=60
	auto_resume=TRUE
	initially_suspended=TRUE
	COMMENT='Slightly extended warehouses gen 2 for gdpr related workloads'
	enable_query_acceleration=TRUE
	query_acceleration_max_scale_factor=8
	max_concurrency_level=8
	statement_queued_timeout_in_seconds=0
	statement_timeout_in_seconds=3600
;

GRANT USAGE ON WAREHOUSE BI_GDPR_WH_GEN2_XLARGE TO ROLE GOVERNANCE_ENGINEER;