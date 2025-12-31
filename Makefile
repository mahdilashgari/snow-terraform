# USAGE
define USAGE
Usage: make [help | install | login | lint | fmt | security env=[environment] | compliance env=[environment] | plan env=[environment] | apply env=[environment] | destroy env=[environment]]
endef
export USAGE

TF_DIR := ./terraform
UNAME := $(shell uname -s)

help:
	@echo "$$USAGE"

install:
	tfenv install
	tgenv install

lint:
	./scripts/lint.sh

fmt:
	./scripts/fmt.sh

compliance: login
	./scripts/compliance.sh $(env)

init:
	./scripts/init.sh $(env)

replace:
	./scripts/replace_provider.sh $(env)

plan: init
	./scripts/plan.sh $(env)

apply:
	./scripts/apply.sh $(env)

destroy:
	./scripts/destroy.sh $(env)

login:
	aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 154603002500.dkr.ecr.eu-central-1.amazonaws.com

security: init
	./scripts/security.sh $(env)