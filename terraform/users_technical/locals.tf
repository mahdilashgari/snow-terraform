locals {

  read_file = yamldecode(file("${var.snowflake_config_filepath}/users_technical.yml"))

  users_technical = local.read_file.users_technical

  users_technical_config = {
    for user in local.users_technical :
    user.name => {
      for k, v in user : k => v
    }
  }

}