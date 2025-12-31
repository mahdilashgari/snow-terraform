# BI Snowflake Terraform Configuration <!-- omit in toc -->

![linter](../../actions/workflows/lint.yml/badge.svg?branch=main)
![security](../../actions/workflows/tfsec.yml/badge.svg?branch=main)
![terraform apply](../../actions/workflows/tf-deploy.yml/badge.svg?branch=main)

This repository contains the configuration of our cloud based Data Warehouse [Snowflake](https://app.snowflake.com/eu-central-1/ya22848).

The configuration is described via simple `.yml` files in the directory `environments/snowflake-prod`. An automated deployment pipeline detects any changes present in the files and applies these changes to the Data Warehouse using [Terraform](https://www.terraform.io/) together with [Terragrunt](https://terragrunt.gruntwork.io/) in the background.

## Table of Contents <!-- omit in toc -->
- [The Deployment Process](#the-deployment-process)
- [The Snowflake Components configured by this Repository](#the-snowflake-components-configured-by-this-repository)
- [The role based access concept (RBAC)](#the-role-based-access-concept-rbac)
  - [Overview](#overview)
  - [Available access roles](#available-access-roles)
- [How to apply changes (add a schema, grant a role etc.)](#how-to-apply-changes-add-a-schema-grant-a-role-etc)
  - [Add a user](#add-a-user)
  - [Grant a functional role to a user](#grant-a-functional-role-to-a-user)
  - [Create a functional role](#create-a-functional-role)
  - [Grant an access role to a functional role](#grant-an-access-role-to-a-functional-role)
  - [Manage role privileges](#manage-role-privileges)
  - [Add a schema](#add-a-schema)
  - [Manage warehouses and warehouse access](#manage-warehouses-and-warehouse-access)
  - [Add a stage](#add-a-stage)
  - [Other changes](#other-changes)
- [What Terraform is and why we use it](#what-terraform-is-and-why-we-use-it)
- [Further Information](#further-information)
  - [Useful links](#useful-links)
  - [AWS accounts](#aws-accounts)
  - [Contribution](#contribution)

## The Deployment Process

### Direct to Snowflake Prod

When the changes are directly done on the production evnironment yml files (under the directory `environments/snowflake-prod`), you could directly create a pr to main branch. This would trigger the github actions jobs to do terraform plan on prod directly. Once the terraform plan (and other checks) are successful, merge the pr. It will start a new github actions job that will do terraform apply to these changes. Once completed, the changes are reflected in the db, if successful.


### Direct to Snowflake Preview

When the changes are directly done on the preview evnironment yml files (under the directory `environments/snowflake-preview`), you could directly create a pr to preview branch. This would trigger the github actions jobs to deploy to preview directly. Please note that the github action will do both terraform plan and terraform apply within the same job for Snowflake Preview.


### Deploy to Snowflake Preview and then Snowflake prod

When you have "bigger" changes that include changes to the terraform files or you want to test the changes on preview before deploying them to prod, first make sure that the preview branch is up-to-date with main. Then, create a pr from your branch to preview branch. This would start the deployment to preview github actions jobs. Once successful, merge the preview branch pr. Then open a new pr to main. Once the checks in github actions are successful and you merge the pr, the github action job will start and it will apply the terraform changes.

## The Snowflake Components configured by this Repository

We distinguish between three groups of Snowflake components, based on their volatility and the privileges required to create or manipulate them:

| Volatility     | Components                                                               | Required role / privileges                 | Created / manipulated by                                     |
| -------------- | ------------------------------------------------------------------------ | ------------------------------------------ | ------------------------------------------------------------ |
| `High`         | e.g. tables, views, dev schemas...                                       | `Schema Full` or `Schema r/w`              | dbt & Users                                                  |
| `Medium - Low` | e.g. warehouses, prod schemas, roles, grants, technical users, stages... | `Useradmin`, `Sysadmin` or `Securityadmin` | This Repo (**Terraform**)                                    |
| `Very Low`     | e.g. storage integrations, usage monitors...                             | `Accountadmin`                             | Administrators (using [these](./scripts/snowflake/) scripts) |

 As this table indicates, we use this terraform repository to configure **any Snowflake component** except
 - highly volatile database objects - we rather use [dbt](https://github.com/new-work/dbt) for that - or
 - components that require **admin privileges** - it's better to restrict access to those high impact components and store their configuration as [scripts](/scripts/snowflake/)
 
 Please refer to the table below for a full overview of the Snowflake components and their creators / manipulators:
| Kind             | Component                   | Terraform | dbt & Users | Admin | Azure AD |
| ---------------- | --------------------------- | :-------: | :---------: | :---: | :------: |
| Users            |                             |           |             |       |          |
|                  | Human User                  |           |             |       |    ✔️     |
|                  | Technical User              |     ✔️     |             |       |          |
|                  | Terraform User              |           |             |   ✔️   |          |
| Databases        |                             |           |             |       |          |
|                  | RAW, ANALYTICS, WORKAREA... |     ✔️     |             |       |          |
|                  | RAW_TEST                    |           |      ✔️      |       |          |
| Schemas          |                             |           |             |       |          |
|                  | dbt Dev Schemas             |           |      ✔️      |       |          |
|                  | Other Schemas               |     ✔️     |             |       |          |
| Database Objects |                             |           |             |       |          |
|                  | Tables, Views...            |           |      ✔️      |       |          |
|                  | Stages                      |     ✔️     |             |       |          |
| Warehouses       |                             |     ✔️     |             |       |          |
|                  | Warehouse Scaling           |     ✔️     |      ✔️      |       |          |
| Roles            |                             |     ✔️     |             |       |          |
| Grants           |                             |     ✔️     |             |       |          |
| Policies         |                             |     ✔️     |             |       |          |
| Integrations     |                             |           |             |       |          |
|                  | SAML2 Integration           |           |             |   ✔️   |          |
|                  | Storage Integrations        |           |             |   ✔️   |          |
| Monitors         |                             |           |             |       |          |
|                  | Resource Monitors           |           |             |   ✔️   |          |
|                  | Monitor Assignment          |           |             |   ✔️   |          |

## The role based access concept (RBAC)

### Overview

![Our RBAC design](/docs/rbac.jpeg)

As shown in the figure above, we distinguish between two types of roles:

1. **Access Roles** - these roles have a set of privileges to operate on a specific schema and three different access roles are **created automatically** for each schema; they must not be granted to a user directly
2. **Functional Roles** - these roles bundle a collection of access roles in order to represent a specific user type (e.g. all the privileges necessary to load data into the RAW database) and they are the roles that are granted to users

### Available access roles

The following access roles are available in our concept and are created automatically.

For each schema:

1. {DATABASE_NAME}_{SCHEMA_NAME}_SR - access role with `read` privileges to the schema
2. {DATABASE_NAME}_{SCHEMA_NAME}_SRW - access role with `read/write` privileges to the schema
3. {DATABASE_NAME}_{SCHEMA_NAME}_SFULL - access role with `all` privileges to the schema

In addition to that:

1. DB_CREATE - enables dbt Users to create and refresh dev databases in dbt e.g. RAW_TEST
2. {DATABASE_NAME}_SCHEMA_CREATE - enables Users to create dev schemas in dbt

## How to apply changes (add a schema, grant a role etc.)

⚠️ For database objects **below schema level** e.g. tables & views and for **development databases & schemas** e.g. *FIRSTNAME_LASTNAME_TEST*, please refer to our [dbt - Repo](https://github.com/new-work/dbt). 

⚠️ For **account admin level components**, please refer to the collection of scripts in [scripts/snowflake/](./scripts/snowflake/).

In order to apply changes to the Snowflake configuration, please do the following:

1. **Clone** the repo and make sure your local `main` branch is **up to date**.
2. Create a **feature branch** from `main` and check it out.
3. Apply the necessary changes to the `.yml` files in the directory `environments/snowflake-prod` following the [**use cases**](#add-a-technical-user) below.
4. Commit your changes, push them and create a **pull-request**.
5. Once the pull-request has been made, the **deployment pipeline** starts and runs a few [checks](./.github/workflows/). Observe the pull-request on Github and check if any [errors occur](./.github/workflows/).
6. The deployment pipeline creates a plan of all the **detected changes** to the Snowflake configuration and attaches it to the pull-request. Verify that the changes in the plan are correct and ask a teammate to **review** it and to accept the pull-request.
7. After the pull-request has been accepted and merged, the deployment pipeline applies the detected changes to the Snowflake Data Warehouse. The result of this process is shown in the pull-request on Github. Make sure that the process has been **successful** and respond to any errors.

### Add a user

⚠️ Please note that **human users** are being created through the [id-portal](https://id-portal.xing.hh/) using our active directory and not through Terraform and this repository.

⚠️ **Before** the user can be used, the **password** of any new users needs to be reset and assigned by an admin.

⚠️ All technical users must be restricted by an existing network-policy, otherwise the user creation fails. Currently, the following network-policies are available:

- `NWSE_POLICY` - users that require access to Snowflake from the NWSE Datacenter
- `TABLEAU_CLOUD_POLICY` - if the user will access Snowflake from Tableau Cloud
- `DBT_CLOUD_POLICY` - if the user will access Snowflake from dbt Cloud

Only technical users (such as users that are used in Tableau cloud to query data for a dashboard) are being created within this repository. Open the file `environments/snowflake-prod/users_technical.yml` and append the user to the list:

``` yaml
users_technical:
  -
    name: AN_EXISTING_USER
    comment: "Just an example"
    network_policy: A_VALID_NETWORK_POLICY
# just append a new user to the existing list:
  -
    name: MY_NEW_TABLEAU_USER
    comment: "Used to query Data for Reporting"
    network_policy: TABLEAU_CLOUD_POLICY
```

Following the principle of least privileges, a newly created user does not have any privileges. Make sure to [assign a functional role](#grant-a-functional-role-to-a-user) to the new user.

### Grant a functional role to a user

By default, new users do not have any privileges. It is necessary to assign a functional role to them that contains the required set of privileges. To do so, just open the file `environments/snowflake-prod/grants_user_role.yml` and assign the user to the role needed:

``` yaml
grants_user_role:
  -
    role: RAW_LOADER
    users:
      - APPFLOW_USER
      # Just add the user to the role that should be granted to them
      - MY_NEW_USER
```

⚠️  Please be as restrictive as possible when granting functional roles to users.

### Create a functional role

As mentioned in the RBAC, access roles are created automatically. All you need to do is to adjust the existing functional roles by adding missing access roles or to create a new functional role. This is done in the file `environments/snowflake-prod/roles_functional.yml`:

``` yaml
roles_functional:
  -
    name: RAW_LOADER
    comment: "Appflow"
    access_roles:
      - RAW_LANDING_ZONE_SFULL
  - # just append the new functional role to the list
    name: MY_NEW_FUNCTIONAL_ROLE
    comment: "an optional comment"
    access_roles: # add a list of access roles following the naming pattern
      - {DATABASE_NAME}_{SCHEMA_NAME}_{SR,SRW or SFULL}
      - MY_DATABASE_MY_SCHEMA_SR
```

⚠️  Before you create a new functional role check if there is already an existing role that might fit. Also be as restrictive as possible when adding access roles to a functional role.

⚠️  And lastly, do not forget to grant the functional roles to the users that require it.

### Grant an access role to a functional role

Please refer to the use case [create a functional role](#create-a-functional-role).

### Manage role privileges

As noted in the RBAC, access roles with the necessary privileges to operate on each database schema are created automatically for each schema. You only need to [assign those access roles to the functional roles](#grant-an-access-role-to-a-functional-role) that require them.

If it is necessary to adjust the privileges granted to the access roles, please set the privileges in the file `environments/snowflake-prod/roles_access_privileges.yml`.

If you need to grant access to a warehouse, please follow the [use case below](#manage-warehouses-and-warehouse-access).

### Add a schema

⚠️ Volatile schemas such as dbt development schemas (FIRSTNAME_LASTNAME_TEST) are created through dbt and not in this repository.

For other schemas, open the file `environments/snowflake-prod/databases.yml` and add the new schema to the target database's schema list:

``` yaml
databases:
  -
    name: MY_DATABASE
    schemas:
      - 
        name: MY_EXISTING_SCHEMA
        comment: "a schema"
        is_transient: true
        is_managed: false
        data_retention_days: 0
      - # just append a new schema to the existing list:
        name: MY_NEW_SCHEMA
        comment: "A comment" # this is optional
        is_transient: false
        is_managed: false
        data_retention_days: 3
```

In addition to the new schema itself, the three available access roles for this schema are created automatically by the deployment pipeline.

Make sure to [add the newly created access roles](#grant-an-access-role-to-a-functional-role) to the functional roles that require access to the new schema.

### Manage warehouses and warehouse access

Warehouses have their own `.yml` file that contains both the configuration for each warehouse as well as the functional roles that have been granted any privileges to them. Use the file `environments/snowflake-prod/warehouses.yml` to manage warehouses:

``` yaml
warehouses:
  -
    name: BI_STAGE_WH
    comment: "For Airbyte etc."
    warehouse_sizes: [xsmall]
    auto_resume: true
    initially_suspended: true
    auto_suspend: 1800
    warehouse_grants:
      -
        role: RAW_LOADER
        privileges: ["USAGE"]
  - # just add a new warehouse to the list
    name: MY_NEW_WAREHOUSE
    comment: "An optional comment."
    warehouse_sizes: [xsmall]
    auto_resume: true
    initially_suspended: true
    auto_suspend: 1800
    warehouse_grants:
      - # enter functional roles and their privileges
        role: MY_NEW_FUNCTIONAL_ROLE
        privileges: ["USAGE", "MODIFY"]
```

Please note that for each size in the `warehouse_sizes` list, a warehouse will be created with the name `{warehouse_name}_{size}`.

### Add a stage

If it is required to add or change a stage, please refer to the file `environments/snowflake-prod/stages.yml`.

### Other changes

The `.yml` files in the `environments/snowflake-prod` directory were designed to capture the majority of changes to the Snowflake configuration. Additional changes need to be done in the Terraform files directly. For those changes, please check out the [readme](./terraform/README.md) and the `.tf` files in the `/terraform` directory.

## What Terraform is and why we use it

Terraform is a widely used Infrastructure-as-Code (IaC) solution that supports various cloud infrastructure [providers](https://registry.terraform.io/browse/providers). Using the IaC approach is [obligatory](https://cloud.nwse.io/guardrails/requirements.html#infrastructure-as-code) for any cloud resource at NWSE. While this repository does not manage any cloud infrastructure itself, it leverages Snowflake's Terraform provider to apply the benefits of IaC to our Snowflake Data Warehouse configuration. Some of these benefits include:

- Versioning: Since all the configuration is version controlled in the Github-Repo, it is easy to track the origin of changes and to rollback to an earlier version.
- Simplicity: Rather than performing a sequence of clicks in a UI or executing various commands, the required resources are just added to a collection of simple lists.
- Security: Powerful roles are not granted to users directly and changes can only be made through pull-requests that need to pass checks
- Automation: DRY code that leverages for each loops. The correct statements are derived from the detected changes and are executed whenever a pull-request is merged.
- Documentation: All the Snowflake components are listed in readable text files.

## Further Information

### Useful links

- [Snowflake guidelines](https://confluence.xing.hh/x/pQZyJw)
- [RBAC design](https://confluence.xing.hh/x/NA_VJw)
- [dbt](https://github.com/new-work/dbt)
- [Terraform Snowflake Provider](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs)
- [CPT Terraform and Github Actions blueprint](https://github.com/new-work/terraform-blueprint)
- [Operations provided Github Runner](https://confluence.xing.hh/x/XxEHK)

### AWS accounts

| Environment  | Type       | Account ID     | Account alias     |
| ------------ | ---------- | -------------- | ----------------- |
| `production` | production | `334417613650` | `nw-1692047-prod` |

### Contribution

Feedback is always welcome, please feel free to address issues
or provide a Pull request.
In order to contribute, please follow the following steps:
- Create your own branch 
- Please note that changes to snowflake-preview directory under environments directory will only affect preview environment and, respectively, changes to snowflake-prod directory under environments directory will only affect production environment
- Please note that changes done to other directories (outside environments) will affect both environments (preview and production)
- When you push to your own branch, a github actions job will start. This job will do terragrunt plan and terragrunt apply on preview environment. Make sure everything is successful there before creating a PR into main branch
- Once you create a PR into main, a github action that does terragrunt plan on production environment will start as a check, after it finishes successfully, you can merge the PR. After you merge the PR, a github actions job will start that will do the terragrunt apply on the production environment and apply your changes.