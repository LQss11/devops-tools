example:
	@echo hello world
# Declare phony targets (targets without file dependencies)
.PHONY: example

# Define the 'help' command to list available targets with descriptions
help:
	@echo "Available targets:"
	@echo "  example   - Some example command."


# Make 'help' the default target when running 'make' without arguments
.DEFAULT_GOAL := help
