# Snowflake Configuration Terraform Resources

This directory contains the Terraform code that applies our configuration to Snowflake using the Snowflake Terraform [Provider](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs).

For the majority of changes, it it not necessary to touch these files. Please follow the guide in the [Readme](../README.md) and use the provided `.yml` files to manage Snowflake.

## If you need to change the code

The terraform directory contains of multiple modules for the most important and most frequently used Snowflake components:

- databases
- grants
- roles
- stages
- users_technical
- warehouses

All the other resources have dedicated `.tf` files. The modules are imported in the `main.tf` file. 

If there are new types of components that need to be added either 

- create a dedicated `.tf` file if you only expect a few instances that will not change often or
- create a new module and provide a new `.yml` file for it.

Make sure to run `make fmt` after you created or changed a `.tf` file to format it nicely and to ensure that the lint check succeeds for you pull-request.

The modules all follow a similar structure:

```
├── module_name
│   ├── component_1.tf -> creates an instance for each entry in list
│   ├── component_2.tf -> does the same for another type of resource
│   ├── locals.tf -> imports .yml file and creates the lists to loop through
│   ├── main.tf
│   └── variables.tf -> provides access to environment vars
```

For example the database module contains code to do the following:
1. import the file database.yml and create two lists out of it:
   1. a list of each database
   2. a list of each schema
2. loop through the database list and create a terraform resource for each item in the list
3. loop through the schema list and create a terraform resource for each item in the list