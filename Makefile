VERSION = 0.1

PHONY: tag
tag:
	git tag $(VERSION)
	git push origin $(VERSION)

PHONY: docs
docs:
	docker-compose run --rm terraform-utils terraform-docs markdown table .
	@echo "This does not automatically update README.md. You need to manually copy and paste to the required sections :("