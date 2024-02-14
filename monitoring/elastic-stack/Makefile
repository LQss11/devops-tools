# Default app variables
PROJECT_NAME=elastic-stack
NAMESPACE=$(PROJECT_NAME)-logs-monitoring
DOTENV=dotenv

# Make 'help' the default target when running 'make' without arguments
.DEFAULT_GOAL := help

# List of files/directories to ignore
IGNORE = misc java-example Makefile .gitignore docker-compose.yaml README.md .gitlab-ci.yml .global.env curator

# Find all directories (excluding ignored files/directories)
DIRECTORIES := $(filter-out $(IGNORE), $(wildcard *))

COMMANDS_WITH_ARGS=docker-run docker-build docker-stop
ifeq (1, $(words $(filter $(firstword $(MAKECMDGOALS)), $(COMMANDS_WITH_ARGS))))
  ARG := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
  $(eval $(ARG):;@:)
endif

ifeq ($(DISABLE_DOTENV),true)
    DOTENV := 
endif

# Declare phony targets (targets without file dependencies)
.PHONY: docker-run docker-build docker-stop docker-init docker-clean httpd pwgen help dotenv


##############################################################################################################################
#                                        																					 #
#                                              🐳 Essential Docker Commands 🐳   	                                        #
#                                        																					 #
##############################################################################################################################

##########################################
#      🌟 Basic Docker Commands 🌟      #
##########################################

# Define a rule to build a specific service
docker-build: dotenv
	@echo "🔨 Building $(ARG)..."
	@docker-compose -p $(PROJECT_NAME) -f $(ARG)/docker/docker-compose.yaml build

# Define a rule to start and build a specific service
docker-run: $(DOTENV)
	@echo "🚀 Stopping and creating $(ARG)..."
	@docker-compose --project-name $(PROJECT_NAME) -f $(ARG)/docker/docker-compose.yaml rm -v -s -f
	@docker-compose -p $(PROJECT_NAME) -f $(ARG)/docker/docker-compose.yaml up --build -d

# Define a rule to stop a specific service
docker-stop: dotenv
	@echo "🛑 Stopping $(ARG)..."
	@docker-compose --project-name $(PROJECT_NAME) -f $(ARG)/docker/docker-compose.yaml rm -v -s -f

##########################################
#    🌟 Dynamic docker init/clean 🌟    #
##########################################

# Define a rule to run the 'docker' rule for each directory
docker_%: %
	@$(MAKE) docker-run $*

# Define a target that will run the 'docker' rule for each directory
docker-init: $(patsubst %,docker_%,$(DIRECTORIES))

# Define a rule to clean up the entire Docker stack
docker-clean:
	@echo "🧹 Cleaning up the Docker stack..."
	@docker-compose --project-name $(PROJECT_NAME) -f docker-compose.yaml down -v --remove-orphans


##############################################################################################################################
#                                        																					 #
#                                                   🌀 Miscellaneous 🌀   	                                		         #
#                                        																					 #
##############################################################################################################################

# Define a rule to create an HTTPD user with a password
httpd:
	@echo "🔐 Creating an HTTPD user with a password..."
	@docker run --rm httpd:alpine htpasswd -Bbn admin $(password)

# Define a rule to generate a password
pwgen:
	@echo "🔑 Generating a password..."
	@docker run -it --rm alpine sh -c "echo $(KEY)=$$(tr -dc A-Za-z0-9_ < /dev/urandom | head -c 12)"

dotenv:
	@echo "⚙️ Generating dotenv ..."
    ifeq ($(OS), Windows_NT)
		@$(foreach dir,$(DIRECTORIES),$(file >  $(dir)/docker/.env,$(file < .global.env)))
    else
		@$(foreach dir,$(DIRECTORIES),cat .global.env > $(dir)/docker/.env;)
    endif

##############################################################################################################################
#                                        																					 #
#                                               📜 Additional Commands 📜   	                             		        #
#                                        																					 #
##############################################################################################################################


# Define the 'help' command to list available targets with descriptions
help:
	@echo "🌟 Available targets: 🌟"
	@echo ""
	@echo "🐳 Essential Docker Commands 🐳"
	@echo "  docker-build <service>      - Build a specific service."
	@echo "  docker-run <service>        - Start and build a specific service."
	@echo "  docker-stop <service>       - Stop a specific service."
	@echo "  docker-init                 - Initialize all Docker services."
	@echo "  docker-clean                - Clean up the entire Docker stack."
	@echo ""
	@echo "🌀 Miscellaneous 🌀"
	@echo "  httpd                      - Create an HTTPD user with a password."
	@echo "  pwgen                      - Generate a password."
	@echo "  dotenv                     - Generating dotenv files in all directories."
	@echo ""
	@echo "Additional Commands:"
	@echo "  help                       - Show this help message."

