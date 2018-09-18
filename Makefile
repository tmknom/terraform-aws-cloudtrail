.DEFAULT_GOAL := help

# https://gist.github.com/tadashi-aikawa/da73d277a3c1ec6767ed48d1335900f3
.PHONY: $(shell grep -E '^[a-zA-Z_-]+:' $(MAKEFILE_LIST) | sed 's/://')


# Constant definitions
MINIMAL_DIR := $(CURDIR)/examples/minimal

# Macro definitions
define brew_install
	if type ${1} >/dev/null 2>&1; then \
		echo "Already installed: ${1}"; \
	else \
		if [ -n "{3}" ]; then \
			brew tap ${3}; \
		fi; \
		echo "Start: brew install ${2}"; \
		brew install ${2}; \
	fi
endef

define plan
	terraform init > /dev/null; \
	terraform fmt $(CURDIR) > /dev/null; \
	terraform plan | tee -a /dev/stderr | landscape
endef


# Phony Targets

install: ## install development requirements
	@$(call brew_install,tfenv,tfenv)
	@$(call brew_install,landscape,terraform_landscape)
	@$(call brew_install,terraform-docs,terraform-docs)
	@$(call brew_install,tflint,tflint,wata727/tflint)
	@tfenv install

fmt: ## format code
	terraform fmt

doc: ## create markdown document
	terraform-docs md .

minimal_plan: ## terraform plan of examples/minimal
	cd ${MINIMAL_DIR}; $(call plan)

minimal_apply: ## terraform apply of examples/minimal
	cd ${MINIMAL_DIR}; terraform apply

minimal_destroy: ## terraform destroy of examples/minimal
	cd ${MINIMAL_DIR}; terraform destroy


# https://postd.cc/auto-documented-makefile/
help: ## show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
