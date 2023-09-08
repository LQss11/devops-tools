IGNORE = Makefile .gitignore README.md

# Find all directories (excluding ignored files/directories)
DIRECTORIES := $(filter-out $(IGNORE), $(wildcard *))

list:
	@echo $(DIRECTORIES)