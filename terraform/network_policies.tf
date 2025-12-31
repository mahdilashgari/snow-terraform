resource "snowflake_network_policy" "dbt_cloud_policy" {
  name    = "DBT_CLOUD_POLICY"
  comment = "dbt Cloud EMEA IP addresses https://docs.getdbt.com/docs/cloud/about-cloud/regions-ip-addresses."

  allowed_ip_list = [
    "3.72.153.148", "3.123.45.39", "3.126.140.248"
  ]

  provider = snowflake.securityadmin
}

resource "snowflake_network_policy" "nwse_policy" {
  name    = "NWSE_POLICY"
  comment = "New Work datacenter, office, VPN external IP addresses"

  allowed_ip_list = [
    "185.169.112.0/22", "80.255.14.110/30", "84.207.224.90/29", "31.12.7.10/29", "83.68.131.116/28", "83.68.131.119/28", "31.7.176.24/29",
    # ips for astronomer
    "34.253.245.99", "34.241.212.72",
    # Odyssey
    "54.171.211.109", "54.228.79.70", "34.240.224.112"
  ]

  provider = snowflake.securityadmin
}

resource "snowflake_network_policy" "tableau_cloud_policy" {
  name    = "TABLEAU_CLOUD_POLICY"
  comment = "Tableau Cloud Europe - Germany addresses https://ip-ranges.salesforce.com/ip-ranges.json + NWSE VPN and datacenter ranges"

  allowed_ip_list = concat(
    [
      "34.246.62.141", "34.246.62.203", "34.246.74.86", "52.215.158.213",
      # New Tableau ip range after migration to AWS Frankfurt / Salesforce Cloud Germany
      "145.224.208.0/23",
      # dbt Cloud EMEA IP addresses added to query dbt Semantic Layer (via Tableau User)
      "3.72.153.148", "3.123.45.39", "3.126.140.248",
    ],
    # NWSE Office, VPN, Datacenter IP addresses"
    tolist(snowflake_network_policy.nwse_policy.allowed_ip_list)
  )

  provider = snowflake.securityadmin
}



# Removed due to the end of POC
# resource "snowflake_network_policy" "reporting_poc_policy" {
#   name    = "REPORTING_POC_POLICY"
#   comment = "POC of a new reporting tool, currently PowerBI / Fabric ServiceFabric.GermanyWestCentral IP addresses added for testing"

#   allowed_ip_list = [
#     # # dbt Lightdash_POC enviroment for Lightdash tests
#     # "3.123.45.39",
#     # "3.126.140.248",
#     # "3.72.153.148",
#     # # hex
#     # "3.129.36.245",
#     # "3.18.79.139",
#     # "3.13.16.99",

#     # "54.76.153.135",
#     # "34.240.244.7",
#     # "52.17.12.97",
#     # # apache preset eu-north-1 (eu5a)
#     # "13.48.95.3",
#     # "13.51.212.165",
#     # "16.170.49.24",
#     # # thoughtspot
#     # "44.209.73.62",
#     # # sigma
#     # "44.229.241.60",
#     # "3.228.152.31",
#     # "35.168.4.93",
#     # "44.207.120.40",
#     # "54.188.54.135",
#     # # lightdash
#     # "35.245.81.252"
#   ]

#   provider = snowflake.securityadmin
# }

resource "snowflake_network_policy" "github_runner_policy" {
  name    = "GITHUB_RUNNER_POLICY"
  comment = "IP of internally hosted GitHub runner: https://confluence.xing.hh/x/XxEHK"

  allowed_ip_list = ["3.126.33.67/32", "20.253.40.120/29", "31.7.176.26", "40.65.75.32/29"]

  provider = snowflake.securityadmin

  lifecycle {
    ignore_changes = [allowed_ip_list]
  }
}

resource "snowflake_network_policy" "appflow_policy" {
  name    = "APPFLOW_POLICY"
  comment = "IP of AWS Appflow used to load data directly into Snowflake: https://docs.aws.amazon.com/appflow/latest/userguide/what-is-appflow.html# ; AWS ip list: https://ip-ranges.amazonaws.com/ip-ranges.json"

  allowed_ip_list = ["3.127.48.244/30", "3.127.48.248/30", "3.68.251.176/30"]

  provider = snowflake.securityadmin

}

resource "snowflake_network_policy" "cdp_segment_policy" {
  name    = "CDP_SEGMENT_POLICY"
  comment = "IP of the CDP segment communicated via https://new-work.atlassian.net/browse/BI-18355"

  allowed_ip_list = ["3.251.148.96/29"]

  provider = snowflake.securityadmin

}

resource "snowflake_network_policy_attachment" "attach" {
  network_policy_name = snowflake_network_policy.github_runner_policy.name
  set_for_account     = false
  users               = [var.snowflake_username]

  provider = snowflake.securityadmin
}

resource "snowflake_network_policy" "poc_ats_policy" {
  name    = "POC_ATS_POLICY"
  comment = "IP of the CDP segment communicated via https://new-work.atlassian.net/browse/BI-18325"

  allowed_ip_list = ["3.65.101.208", "18.192.64.158", "44.218.85.113"]

  provider = snowflake.securityadmin

}

resource "snowflake_network_policy" "empty_policy" {
  name    = "EMTPY_POLICY"
  comment = "network policy with no IP addresses"
  #network policy require at least an IP address. I assigned this IP address from our NWSE subnet to avoid the error
  allowed_ip_list = ["185.169.113.251"]

  provider = snowflake.securityadmin

}

resource "snowflake_network_policy" "astronomer_policy" {
  name    = "ASTRONOMER_POLICY"
  comment = "network policy for astronomer"
  #network policy require at least an IP address. I assigned this IP address from our NWSE subnet to avoid the error
  allowed_ip_list = ["34.253.245.99", "34.241.212.72"]

  provider = snowflake.securityadmin

}

resource "snowflake_network_policy" "select_dev_policy" {
  name            = "SELECT_DEV_POLICY"
  comment         = "network policy for https://select.dev/security"
  allowed_ip_list = ["34.23.79.180", "34.139.189.198", "35.229.105.183", "35.243.245.125", "34.138.184.161", "34.73.135.174", "34.148.143.80", "34.23.67.112"]

  provider = snowflake.securityadmin
}

resource "snowflake_network_policy" "thoughtspot_policy" {
  name            = "THOUGHTSPOT_POLICY"
  comment         = "network policy for https://www.thoughtspot.com/de"
  allowed_ip_list = ["10.230.8.0/25", "3.65.180.103"]

  provider = snowflake.securityadmin
}

resource "snowflake_network_policy" "active_sourcing_policy" {
  name            = "ACTIVE_SOURCING_POLICY"
  comment         = "network policy for ACTIVE SOURCING TEAM based on ODYSSEY ips, contact Matthias Lüdtke"
  allowed_ip_list = ["54.171.211.109", "54.228.79.70", "34.240.224.112", "57.133.100.80/29", "188.227.132.225", "31.7.176.24/29", "213.86.90.248/29", "88.157.87.67", "83.68.131.112/28", "84.207.224.88/29", "185.169.115.0/24"]

  provider = snowflake.securityadmin
}

resource "snowflake_network_policy" "salesforce_data_cloud_policy" {
  name            = "SALESFORCE_DATA_CLOUD_POLICY"
  comment         = "network policy for salesforce data cloud"
  allowed_ip_list = ["18.156.144.84/32", "18.159.12.44/32", "35.156.54.210/32", "18.156.161.183/32", "18.192.111.185/32", "35.157.176.56/32", "18.193.163.242/32", "3.126.68.114/32", "35.158.17.154/32", "18.198.246.75/32", "18.198.9.100/32", "3.64.2.81/32"]

  provider = snowflake.securityadmin
}