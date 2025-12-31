#!/bin/bash

# usage: ./plan.sh <ENVIRONMENT>

set -euo pipefail

# change to parent directory of this script so the context is correct
cd $(dirname $(dirname "$0"))

#do manually to change verions
#terragrunt init -upgrade --terragrunt-working-dir=environments/snowflake-prod
