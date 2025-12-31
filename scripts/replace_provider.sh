#!/bin/bash

# usage: ./plan.sh <ENVIRONMENT>

set -euo pipefail

# change to parent directory of this script so the context is correct
cd $(dirname $(dirname "$0"))

# interpret first argument as environment to set working directory
terragrunt_environment=$1

TF_CLI_ARGS=${TF_CLI_ARGS:-}

cd environments/$terragrunt_environment || { echo "Directory not found 2"; exit 1; }

pwd

terragrunt state replace-provider -auto-approve Snowflake-Labs/snowflake snowflakedb/snowflake