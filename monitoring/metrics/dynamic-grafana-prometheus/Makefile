# Default app variables
PROJECT_NAME=myorg
NAMESPACE=$(PROJECT_NAME)-monitoring
DOTENV=dotenv

# Make 'help' the default target when running 'make' without arguments
.DEFAULT_GOAL := help

# List of files/directories to ignore
IGNORE = awaragi-mssql-exporter blackbox-exporter sql-exporter misc Makefile .gitignore docker-compose.yaml README.md .gitlab-ci.yml .global.env

# Find all directories (excluding ignored files/directories)
DIRECTORIES := $(filter-out $(IGNORE), $(wildcard *))

COMMANDS_WITH_ARGS=docker-run docker-build docker-stop k8s-run k8s-stop k8s-get k8s-ksm
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
#                                              ☸️ Essential Kubernetes Commands ☸️   	                                    #
#                                        																					 #
##############################################################################################################################

##########################################
#    🌟 Basic Kubernetes Commands 🌟    #
##########################################

k8s-init:
	@echo "🚀 Applying manifests for $(ARG)..."
	@kubectl create namespace $(NAMESPACE) --dry-run=client -o yaml | kubectl apply -f -
	@$(MAKE) k8s-crb
	@$(MAKE) k8s-ksm apply
	@$(MAKE) k8s-run grafana
	@$(MAKE) k8s-run prometheus

k8s-clean:
	@echo "🚀 Applying manifests for $(ARG)..."
	@kubectl delete namespace $(NAMESPACE)

k8s-get: 
	@echo "🚀 Getting $(ARG) from $(NAMESPACE) Namespace..."
	kubectl -n $(NAMESPACE) get $(ARG)

k8s-crb: 
	@echo "🚀 Creating prometheus clusterrolebinding on $(NAMESPACE) Namespace..."
	@kubectl create clusterrolebinding prometheus --clusterrole=prometheus-rbac --serviceaccount=$(NAMESPACE):prometheus-sa --dry-run=client -o yaml >./prometheus/kubernetes/rbacbinding.yaml

k8s-ksm: $(ARG)
# kubectl port-forward -n kube-system service/kube-state-metrics 8080:8080
	@echo "🚀 Running $(ARG) on Kube State Metrics resources..."
	@kubectl $(ARG) -f https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/cluster-role-binding.yaml
	@kubectl $(ARG) -f https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/cluster-role.yaml
	@kubectl $(ARG) -f https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/deployment.yaml
	@kubectl $(ARG) -f https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/service-account.yaml
	@kubectl $(ARG) -f https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/service.yaml
ifeq ($(ARG),apply)
	@kubectl patch deployment kube-state-metrics -n kube-system --type=json -p='[{"op": "add", "path": "/spec/template/spec/hostNetwork", "value":true}]'
endif
k8s-run: dotenv
	@$(MAKE) docker-build $(ARG)
	@echo "🚀 Applying manifests for $(ARG)..."
	@kubectl create namespace $(NAMESPACE) --dry-run=client -o yaml | kubectl apply -f -
	@kubectl -n $(NAMESPACE) create configmap $(ARG) --from-env-file="./$(ARG)/docker/.env" --dry-run="client" -o="yaml" >./$(ARG)/kubernetes/configmap.yaml
	kubectl -n $(NAMESPACE) apply -f "$(ARG)/kubernetes"

k8s-stop: dotenv
	@echo "🚀 Deleting resources for $(ARG)..."
	@kubectl -n $(NAMESPACE) delete -f "$(ARG)/kubernetes"


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

# TODO include here make pwgen KEY=GRAFANA_ADMIN_PASSWORD and send it to vault
grafana-enable-ldap: dotenv
	@echo "⚙️ Creating .env ..."
	@echo "" >>grafana/docker/.env
	@echo GF_AUTH_LDAP_ENABLED=true >>grafana/docker/.env
	@echo LDAP_ADMIN_PASSWORD='$(LDAP_ADMIN_PASSWORD)' >>grafana/docker/.env

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
	@echo "☸️ Essential Kubernetes Commands ☸️"
	@echo "  k8s-init                   - Initialize Kubernetes resources."
	@echo "  k8s-clean                  - Delete Kubernetes resources."
	@echo "  k8s-get <ARG>              - Get Kubernetes resources."
	@echo "  k8s-crb                    - Create Prometheus ClusterRoleBinding."
	@echo "  k8s-ksm <ARG>              - (apply/delete) to Manage Kube State Metrics resources."
	@echo "  k8s-run <service>          - Build and deploy a specific Kubernetes resource."
	@echo "  k8s-stop <service>         - Delete Kubernetes resources for a specific resource."
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
	@echo "  grafana-enable-ldap        - Generate Grafana LDAP environment vars."
	@echo "  dotenv                     - Generating dotenv files in all directories."
	@echo ""
	@echo "Additional Commands:"
	@echo "  help                       - Show this help message."

