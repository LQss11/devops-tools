# List of files/directories to ignore
IGNORE = Makefile .gitignore docker-compose.yaml README.md .gitlab-ci.yml .global.env

# Find all directories (excluding ignored files/directories)
DIRECTORIES := $(filter-out $(IGNORE), $(wildcard *))
loop:
	@$(foreach dir,$(DIRECTORIES),$(file >  $(dir)/.env,$(file < .global.env)))