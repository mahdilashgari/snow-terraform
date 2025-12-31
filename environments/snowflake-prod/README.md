# Snowflake Configuration Files

This directory contains the `.yml` files that control most of our Snowflake configuration as well as the Terraform related files `terraform.lock.hcl` and `terragrunt.hcl` that are required by the deployment pipeline.

## Available Configuration Files

The following list provides an overview of the files and their purpose:

- `databases.yml`
  - change and create databases
  - change and create schemas
  - create access roles for each schema
- `grants_user_role.yml`
  - grant/revoke functional roles to/from users
- `roles_access_privileges.yml`
  - adjust privileges granted to each schema access role
- `roles_functional.yml`
  - define functional roles
  - assign access roles to them
- `stages.yml`
  - change and create stages
- `users_technical.yml`
  - change and create technical users
- `warehouses.yml`
  - change and create warehouses
  - assign functional roles to warehouses