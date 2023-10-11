os:
	ifeq ($(OS), Linux)
		@echo "Building my_program for Linux"
	else ifeq ($(OS), Windows_NT)
		@echo "Building my_program for Windows_NT"
	else
		@echo "Building my_program for other systems"
	endif