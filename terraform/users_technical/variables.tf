variable "snowflake_config_filepath" {
  type = string
}

variable "snowflake_default_password" {
  type      = string
  sensitive = true
}