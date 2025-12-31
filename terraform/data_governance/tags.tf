resource "snowflake_tag" "tag_governance_pii_privacy_category" {
  provider = snowflake.governance_admin
  name     = "PII_PRIVACY_CATEGORY"
  database = "INTERNAL"
  schema   = "GOVERNANCE"
  allowed_values = [
    "identifier",
    "no_pii",
    "quasi_identifier"
  ]
  masking_policies = [
    "\"INTERNAL\".\"GOVERNANCE\".\"MASK_ARRAY_PII\"",
    "\"INTERNAL\".\"GOVERNANCE\".\"MASK_DATE_PII\"",
    "\"INTERNAL\".\"GOVERNANCE\".\"MASK_PII\"",
    "\"INTERNAL\".\"GOVERNANCE\".\"MASK_TIMESTAMP_PII\"",
  ]
}

resource "snowflake_tag" "tag_governance_pii_id" {
  provider = snowflake.governance_admin
  name     = "PII_ID"
  database = "INTERNAL"
  schema   = "GOVERNANCE"
  allowed_values = [
    "braze_onlyfy_user_profile",
    "braze_xing_user_profile",
    "ecom_billingdetailsid",
    "novomind_addressbookid",
    "novomind_emailid",
    "novomind_emailpropertiesid",
    "nwse_resourceid",
    "prescreen_candidate",
    "prescreen_job_application",
    "prescreen_user",
    "salesforce_onlyfy_contact",
    "salesforce_onlyfy_lead",
    "salesforce_xing_contact",
    "salesforce_xing_lead",
    "salesforce_xms_contact",
    "salesforce_xms_lead",
    "talenthub_invitationid",
    "talenthub_profileid",
    "talenthub_talentid",
    "xing_account",
    "xing_webtracking_hash",
    "zendesk_xing_userid",
  ]
}

resource "snowflake_tag" "tag_governance_production_status" {
  provider       = snowflake.governance_admin
  name           = "PRODUCTION_STATUS"
  database       = "INTERNAL"
  schema         = "GOVERNANCE"
  allowed_values = ["live", "non_live", "static"]
}