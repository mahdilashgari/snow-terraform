-- the following statements were used to provide DIS snowflake account
--with access through replication to our SNAPSHOTS and INTERNAL DBs in BI snowflake account

use role accountadmin;

--used to disable the 50TB limit on the replication set by default
alter account set INITIAL_REPLICATION_SIZE_LIMIT_IN_TB = 0.0;

SHOW REPLICATION ACCOUNTS;

CREATE SHARE bi_prod_dis_share;

desc share bi_prod_dis_share;

ALTER SHARE  bi_prod_dis_share set secure_objects_only = false;

GRANT USAGE ON DATABASE SNAPSHOTS TO SHARE bi_prod_dis_share;

CREATE REPLICATION GROUP dis_replication
  OBJECT_TYPES = databases, shares
  ALLOWED_DATABASES = SNAPSHOTS
  ALLOWED_SHARES = bi_prod_dis_share
  ALLOWED_ACCOUNTS = NWSE.DATA_PLATFORM;

--add INTERNAL DB as it contains the tags and masking policies needed in raw and snapshot DBs
  alter replication group dis_replication
  set OBJECT_TYPES = databases, shares
  ALLOWED_DATABASES = SNAPSHOTS, INTERNAL
  ALLOWED_SHARES = bi_prod_dis_share;

-- after using the direct data share (after migration to ireland):
ALTER SHARE BI_PROD_DIS_SHARE ADD ACCOUNT = NWSE.DATA_PLATFORM;
GRANT USAGE ON ALL SCHEMAS IN DATABASE SNAPSHOTS TO SHARE BI_PROD_DIS_SHARE;
GRANT SELECT ON ALL TABLES IN DATABASE SNAPSHOTS TO SHARE BI_PROD_DIS_SHARE;
