.DEFAULT_GOAL := help

# https://gist.github.com/tadashi-aikawa/da73d277a3c1ec6767ed48d1335900f3
.PHONY: $(shell grep -E '^[a-zA-Z_-]+:' $(MAKEFILE_LIST) | sed 's/://')


# Constant definitions
MINIMAL_DIR := $(CURDIR)/examples/minimal

# Function macros
define plan
	terraform init > /dev/null; \
	terraform fmt $(CURDIR) > /dev/null; \
	terraform plan | tee -a /dev/stderr | landscape
endef


# Phony Targets

fmt: ## format code
	terraform fmt

minimal_plan: ## terraform plan of examples/minimal
	cd ${MINIMAL_DIR}; $(call plan)

minimal_apply: ## terraform apply of examples/minimal
	cd ${MINIMAL_DIR}; terraform apply

minimal_destroy: ## terraform destroy of examples/minimal
	cd ${MINIMAL_DIR}; terraform destroy


# https://postd.cc/auto-documented-makefile/
help: ## show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
