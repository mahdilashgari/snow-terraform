#!/bin/bash

# usage: ./security.sh <ENVIRONMENT>

set -euo pipefail

# change to parent directory of this script so the context is correct
cd $(dirname $(dirname "$0"))

# interpret first argument as environment to set working directory
environment=$1

tfsec --minimum-severity HIGH environments/$environment
