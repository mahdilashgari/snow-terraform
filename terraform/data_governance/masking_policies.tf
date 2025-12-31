resource "snowflake_masking_policy" "masking_policy_mask_pii" {
  provider = snowflake.governance_admin
  name     = "MASK_PII"
  database = "INTERNAL"
  schema   = "GOVERNANCE"
  argument {
    name = "val"
    type = "string"
  }
  body = <<-EOF
    case
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_DATABASE() = 'ANALYTICS'
      and CURRENT_SCHEMA() = 'ONLYFY'
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_kununu.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_DATABASE() = 'ANALYTICS'
      and CURRENT_SCHEMA() = 'CENTRAL'
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_central_profilebackend.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_DATABASE() in ('SNAPSHOTS', 'RAW')
      and CURRENT_SCHEMA() = 'MYSQL_PROFILEBACKEND'
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_central_profilebackend.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_SCHEMA() in ('SALESFORCE_ONLYFY')
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_salesforce_onlyfy.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_SCHEMA() in ('KAFKA_DP_INGESTION')
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_kafka_dp_ingestion.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_SCHEMA() in ('AMQP', 'KAFKA_AMQP')
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_amqp.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and not ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        IFF(val is NULL,NULL,'***MASKED***')
      else
        val
    end
  EOF

  return_data_type      = "string"
  exempt_other_policies = false
}

#deprecated in the new version 2.2
# resource "snowflake_tag_masking_policy_association" "policy_association_mask_pii_" {
#   provider = snowflake.governance_admin
#   #tag_id            = "\"INTERNAL\".\"GOVERNANCE\"".snowflake_tag.tag_governance_pii_privacy_category.id
#   tag_id = "\"${snowflake_tag.tag_governance_pii_privacy_category.database}\".\"${snowflake_tag.tag_governance_pii_privacy_category.schema}\".\"${snowflake_tag.tag_governance_pii_privacy_category.name}\""
#   #masking_policy_id = "\"INTERNAL\".\"GOVERNANCE\"".snowflake_masking_policy.masking_policy_mask_pii.id
#   masking_policy_id = "\"${snowflake_masking_policy.masking_policy_mask_pii.database}\".\"${snowflake_masking_policy.masking_policy_mask_pii.schema}\".\"${snowflake_masking_policy.masking_policy_mask_pii.name}\""
# }

resource "snowflake_masking_policy" "masking_policy_date_mask_pii" {
  provider = snowflake.governance_admin
  name     = "MASK_DATE_PII"
  database = "INTERNAL"
  schema   = "GOVERNANCE"
  argument {
    name = "val"
    type = "DATE"
  }
  body = <<-EOF
    case
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_DATABASE() = 'ANALYTICS'
      and CURRENT_SCHEMA() = 'ONLYFY'
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_kununu.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_DATABASE() = 'ANALYTICS'
      and CURRENT_SCHEMA() = 'CENTRAL'
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_central_profilebackend.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_DATABASE() in ('SNAPSHOTS', 'RAW')
      and CURRENT_SCHEMA() = 'MYSQL_PROFILEBACKEND'
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_central_profilebackend.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_SCHEMA() in ('SALESFORCE_ONLYFY')
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_salesforce_onlyfy.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_SCHEMA() in ('KAFKA_DP_INGESTION')
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_kafka_dp_ingestion.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_SCHEMA() in ('AMQP', 'KAFKA_AMQP')
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_amqp.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and not ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        IFF(val is NULL,NULL,to_date('1111-01-01'))
      else
        val
    end
  EOF

  return_data_type      = "DATE"
  exempt_other_policies = false
}

# resource "snowflake_tag_masking_policy_association" "policy_association_date_mask_pii_" {
#   provider = snowflake.governance_admin
#   #tag_id            = "\"INTERNAL\".\"GOVERNANCE\"".snowflake_tag.tag_governance_pii_privacy_category.id
#   tag_id = "\"${snowflake_tag.tag_governance_pii_privacy_category.database}\".\"${snowflake_tag.tag_governance_pii_privacy_category.schema}\".\"${snowflake_tag.tag_governance_pii_privacy_category.name}\""
#   #masking_policy_id = "\"INTERNAL\".\"GOVERNANCE\"".snowflake_masking_policy.masking_policy_date_mask_pii.id
#   masking_policy_id = "\"${snowflake_masking_policy.masking_policy_date_mask_pii.database}\".\"${snowflake_masking_policy.masking_policy_date_mask_pii.schema}\".\"${snowflake_masking_policy.masking_policy_date_mask_pii.name}\""
# }

resource "snowflake_masking_policy" "masking_policy_timestamp_mask_pii" {
  provider = snowflake.governance_admin
  name     = "MASK_TIMESTAMP_PII"
  database = "INTERNAL"
  schema   = "GOVERNANCE"
  argument {
    name = "val"
    type = "TIMESTAMP_NTZ"
  }
  body = <<-EOF
    case
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_DATABASE() = 'ANALYTICS'
      and CURRENT_SCHEMA() = 'ONLYFY'
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_kununu.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_DATABASE() = 'ANALYTICS'
      and CURRENT_SCHEMA() = 'CENTRAL'
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_central_profilebackend.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_DATABASE() in ('SNAPSHOTS', 'RAW')
      and CURRENT_SCHEMA() = 'MYSQL_PROFILEBACKEND'
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_central_profilebackend.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_SCHEMA() in ('SALESFORCE_ONLYFY')
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_salesforce_onlyfy.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_SCHEMA() in ('KAFKA_DP_INGESTION')
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_kafka_dp_ingestion.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_SCHEMA() in ('AMQP', 'KAFKA_AMQP')
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_amqp.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and not ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        IFF(val is NULL,NULL,to_timestamp_ntz ('1111-01-01 00:00:00.000'))
      else
        val
    end
  EOF

  return_data_type      = "TIMESTAMP_NTZ"
  exempt_other_policies = false
}

# resource "snowflake_tag_masking_policy_association" "policy_association_timestamp_mask_pii_" {
#   provider = snowflake.governance_admin
#   #tag_id            = "\"INTERNAL\".\"GOVERNANCE\"".snowflake_tag.tag_governance_pii_privacy_category.id
#   tag_id = "\"${snowflake_tag.tag_governance_pii_privacy_category.database}\".\"${snowflake_tag.tag_governance_pii_privacy_category.schema}\".\"${snowflake_tag.tag_governance_pii_privacy_category.name}\""
#   #masking_policy_id = "\"INTERNAL\".\"GOVERNANCE\"".snowflake_masking_policy.masking_policy_timestamp_mask_pii.id
#   masking_policy_id = "\"${snowflake_masking_policy.masking_policy_timestamp_mask_pii.database}\".\"${snowflake_masking_policy.masking_policy_timestamp_mask_pii.schema}\".\"${snowflake_masking_policy.masking_policy_timestamp_mask_pii.name}\""
# }

resource "snowflake_masking_policy" "masking_policy_array_mask_pii" {
  provider = snowflake.governance_admin
  name     = "MASK_ARRAY_PII"
  database = "INTERNAL"
  schema   = "GOVERNANCE"
  argument {
    name = "val"
    type = "ARRAY"
  }
  body = <<-EOF
    case
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_DATABASE() = 'ANALYTICS'
      and CURRENT_SCHEMA() = 'ONLYFY'
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_kununu.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_DATABASE() = 'ANALYTICS'
      and CURRENT_SCHEMA() = 'CENTRAL'
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_central_profilebackend.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_DATABASE() in ('SNAPSHOTS', 'RAW')
      and CURRENT_SCHEMA() = 'MYSQL_PROFILEBACKEND'
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_central_profilebackend.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_SCHEMA() in ('SALESFORCE_ONLYFY')
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_salesforce_onlyfy.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_SCHEMA() in ('KAFKA_DP_INGESTION')
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_kafka_dp_ingestion.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and CURRENT_SCHEMA() in ('AMQP', 'KAFKA_AMQP')
      and ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer_amqp.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        val
      when SYSTEM$GET_TAG_ON_CURRENT_COLUMN('internal.governance.PII_PRIVACY_CATEGORY') = 'identifier'
      and not ARRAY_CONTAINS('${snowflake_account_role.role_governance_pii_viewer.name}'::variant, parse_json(CURRENT_AVAILABLE_ROLES()))
      then
        IFF(val is NULL,NULL,to_array(to_variant(PARSE_JSON('{"columns":"***MASKED***"}'))))
      else
        val
    end
  EOF

  return_data_type      = "ARRAY"
  exempt_other_policies = false
}

# resource "snowflake_tag_masking_policy_association" "policy_association_array_mask_pii_" {
#   provider = snowflake.governance_admin
#   #tag_id            = "\"INTERNAL\".\"GOVERNANCE\"".snowflake_tag.tag_governance_pii_privacy_category.id
#   tag_id = "\"${snowflake_tag.tag_governance_pii_privacy_category.database}\".\"${snowflake_tag.tag_governance_pii_privacy_category.schema}\".\"${snowflake_tag.tag_governance_pii_privacy_category.name}\""
#   #masking_policy_id = "\"INTERNAL\".\"GOVERNANCE\"".snowflake_masking_policy.masking_policy_array_mask_pii.id
#   masking_policy_id = "\"${snowflake_masking_policy.masking_policy_array_mask_pii.database}\".\"${snowflake_masking_policy.masking_policy_array_mask_pii.schema}\".\"${snowflake_masking_policy.masking_policy_array_mask_pii.name}\""
# }