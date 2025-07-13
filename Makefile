VERSION ?= v0.1.0
COMMIT ?= $(shell git rev-parse HEAD)

.PHONY: default
default: test

.terraform:
	terraform init

.PHONY: test
test: .terraform
	terraform init
	terraform test

.PHONY: check-fmt
check-fmt:
	find . -type f -name '*.tf' -or -name '*.tfvars' -or -name '*.tftest.hcl' | xargs -n1 terraform fmt -check -diff

release:
	gh release create $(VERSION) --title "Release $(VERSION)" --target $(COMMIT) --generate-notes
