#!/bin/bash
CONFIG_PATH=configs

# Function to cleanup on script interruption
cleanup() {
    echo -e "\nExiting due to sigint"
    # Add any cleanup steps here if needed
    exit 1
}

# Trap Ctrl+C and call cleanup function
trap cleanup SIGINT


# Prompt for cluster information
read -p "Enter cluster name (default to kubernetes): " CLUSTER_NAME
CLUSTER_NAME=${CLUSTER_NAME:-kubernetes}

read -p "Enter cluster host (IP or DNS, default to localhost): " HOST
HOST=${HOST:-localhost}

# Prompt for user input
read -p "Enter username (default to DevUser): " USERNAME
USERNAME=${USERNAME:-DevUser}

read -p "Enter user $USERNAME group (default to dev): " USERGROUP
USERGROUP=${USERGROUP:-dev}

KUBECONFIG_PATH="${CONFIG_PATH}/${USERNAME}-config-${CLUSTER_NAME}"


CLUSTER_CA_CERT_PATH="certs/ca.crt"
CLUSTER_CA_KEY_PATH="certs/ca.key"

# Check if kubeconfig file exists
if [ -f "$KUBECONFIG_PATH" ]; then
    echo "Kubeconfig file '$KUBECONFIG_PATH' already exists."
fi

# Check if ca.crt file exists
if [ ! -f "$CLUSTER_CA_CERT_PATH" ]; then
    echo "Error: CA certificate file '$CLUSTER_CA_CERT_PATH' not found."
    exit 1
fi

# Check if ca.key file exists
if [ ! -f "$CLUSTER_CA_KEY_PATH" ]; then
    echo "Error: CA key file '$CLUSTER_CA_KEY_PATH' not found."
    exit 1
fi


CERTS_DIR=certs

# Check if user already has certs
USER_CERTS_DIR="${CERTS_DIR}/${USERNAME}"
if [ -d "$USER_CERTS_DIR" ]; then
    read -p "Certs directory for user '$USERNAME' already exists. Do you want to generate new ones? (y/n): " GENERATE_NEW_CERTS_RESPONSE
    if [ "$GENERATE_NEW_CERTS_RESPONSE" == "y" ]; then
        echo "Generating scripts."
        # Generate cert request
        openssl genrsa -out ${USER_CERTS_DIR}/${USERNAME}.key 2048
        openssl req -new -key ${USER_CERTS_DIR}/${USERNAME}.key -out ${USER_CERTS_DIR}/${USERNAME}.csr -subj "/CN=${USERNAME}/O=${USERGROUP}"
        echo 
    fi
else
    USER_CERTS_DIR="${CERTS_DIR}/${USERNAME}"
    mkdir -p ${USER_CERTS_DIR}
    # Generate cert request
    openssl genrsa -out ${USER_CERTS_DIR}/${USERNAME}.key 2048
    openssl req -new -key ${USER_CERTS_DIR}/${USERNAME}.key -out ${USER_CERTS_DIR}/${USERNAME}.csr -subj "/CN=${USERNAME}/O=${USERGROUP}"
fi

# Generate user cert
echo "Generating new cert for $USERNAME"
openssl x509 -req -in ${USER_CERTS_DIR}/${USERNAME}.csr -CA ${CLUSTER_CA_CERT_PATH} -CAkey ${CLUSTER_CA_KEY_PATH}  -CAcreateserial -out ${USER_CERTS_DIR}/${USERNAME}.crt -days 365

# User definition
mkdir -p $CONFIG_PATH
KUBECONFIG=${KUBECONFIG_PATH} kubectl config set-cluster ${CLUSTER_NAME} --server=https://${HOST}:6443 --certificate-authority ${CLUSTER_CA_CERT_PATH} --embed-certs

# Generate a new user in the kubeconfig
KUBECONFIG=${KUBECONFIG_PATH} kubectl config set-credentials ${USERNAME} --client-certificate ${USER_CERTS_DIR}/${USERNAME}.crt --client-key ${USER_CERTS_DIR}/${USERNAME}.key --embed-certs

# Assign a new context for the new user
KUBECONFIG=${KUBECONFIG_PATH} kubectl config set-context ${USERNAME} --user=${USERNAME} --cluster=${CLUSTER_NAME} --namespace=default

# Set context to the current user
KUBECONFIG=${KUBECONFIG_PATH} kubectl config use-context ${USERNAME}
