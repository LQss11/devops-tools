#!/bin/bash


# Common funtions
# Function to checks file existance
check_file_existence() {
    if [ -e "$1" ]; then
        echo "File '$1' exists."
    else
        echo "File '$1' does not exist."
        exit 1
    fi
}

generate_user_keys() {
    if [ -d "$USER_CERTS_DIR" ]; then
        read -p "Certs directory for user '$USERNAME' already exists. Do you want to generate new key? (y/n): " GENERATE_NEW_KEY
        if [ "$GENERATE_NEW_KEY" == "y" ]; then
            echo "Generating .key and .csr files."
            rm -rf $USER_CERTS_DIR/*
            # Generate key and cert request
            openssl genrsa -out ${USER_CERTS_DIR}/${USERNAME}.key 2048
            elif [ "$GENERATE_NEW_KEY" == "n" ]; then
            # Generate new csr only
            echo "Generating csr only."
            rm -rf $USER_CERTS_DIR/*.csr
            rm -rf $USER_CERTS_DIR/*.crt
        fi
    else
        mkdir -p ${USER_CERTS_DIR}
        # Generate cert request
        openssl genrsa -out ${USER_CERTS_DIR}/${USERNAME}.key 2048
    fi
    openssl req -new -key ${USER_CERTS_DIR}/${USERNAME}.key -out ${USER_CERTS_DIR}/${USERNAME}.csr -subj "/CN=${USERNAME}/O=${USERGROUP}"
}

generate_k8s_csr() {
    
    # Check if CSR already exists
    existing_csr=$(kubectl get csr/${USERNAME} --ignore-not-found=true -o jsonpath='{.metadata.name}')
    
    if [ -n "${existing_csr}" ]; then
        # CSR already exists, ask user if they want to delete or keep it
        read -p "CSR ${USERNAME} already exists. Do you want to delete it and create a new one? (y/n): " delete_existing_csr
        
        if [ "${delete_existing_csr}" == "y" ]; then
            # Delete the existing CSR
            kubectl delete csr/${USERNAME}
            echo "Deleted existing CSR ${USERNAME}"
        else
            # User wants to keep the existing CSR, exiting
            echo "Keeping existing Kubernetes CSR ${USERNAME}."
            return 0
        fi
    fi
    
    # Continue with CSR generation
    CSR_BASE64=$(cat "${USER_CERTS_DIR}/${USERNAME}.csr" | base64 | tr -d "\n")
  cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: ${USERNAME}
spec:
  request: ${CSR_BASE64}
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400 # 24 hours
  usages:
  - client auth
EOF
    
    # Get the certificate
    CERTIFICATE=$(kubectl get csr/${USERNAME} -o jsonpath='{.status.certificate}')
    echo "${CERTIFICATE}" | base64 -d > "${USER_DIR}/${USERNAME}.crt"
    
    # Approve CertificateSigningRequest
    kubectl certificate approve ${USERNAME}
}

# Function to cleanup on script interruption
cleanup() {
    echo -e "\nExiting due to sigint"
    # Add any cleanup steps here if needed
    exit 1
}

# Trap Ctrl+C and call cleanup function
trap cleanup SIGINT


CONFIGS_DIR=configs
CERTS_DIR=certs

mkdir -p ${CONFIGS_DIR}
mkdir -p ${CERTS_DIR}

# Prompt for cluster information
read -p "Enter cluster name (default to kubernetes): " CLUSTER_NAME
CLUSTER_NAME=${CLUSTER_NAME:-kubernetes}

# Prompt for user input
read -p "Enter username (default to DevUser): " USERNAME
USERNAME=${USERNAME:-DevUser}

read -p "Enter user $USERNAME group (default to dev): " USERGROUP
USERGROUP=${USERGROUP:-dev}

USER_CERTS_DIR="${CERTS_DIR}/${USERNAME}"

USER_CONFIG_PATH="${CONFIGS_DIR}/${USERNAME}-config"
# Check if user config file exists
if [ -f "$USER_CONFIG_PATH" ]; then
    read -p "Error: User Kubeconfig '$USER_CONFIG_PATH' found, seems to be already generated before. Do you want to proceed (y/n):" PROCEED
    if [ "$PROCEED" == "y" ]; then
        echo "Proceeding and recreating the new user kubeconfig."
        rm -rf $USER_CONFIG_PATH
        touch $USER_CONFIG_PATH
        elif [ "$PROCEED" == "n" ]; then
        echo "Exiting script keeping the current kubeconfig."
        exit 1  # Exit the script with an error code
    fi
fi

read -p "Do you want to generate the request and cert through cluster CSR resource or through ca certs? (csr/ca): " choice

# Check the user's choice
if [ "$choice" == "csr" ]; then
    echo "Generating request and cert through cluster CSR resource..."
    # Ask user to input kubeconfig path (default to configs/config)
    read -p "Enter the cluster kubeconfig path and ensure its user has proper permissions to assing certs and roles (default to configs/config):" KUBECONFIG_PATH
    export KUBECONFIG=${KUBECONFIG_PATH:-$CONFIGS_DIR/config}
    # Verify if the kubeconfig path specified exists or not before proceeding
    if [ ! -f "$KUBECONFIG" ]; then
        echo "Error: Kubeconfig path '$KUBECONFIG' does not exist. Exiting."
        exit 1
    fi
    
    # Generate the user keys
    generate_user_keys
    generate_k8s_csr
    echo "Done."
    
    
    elif [ "$choice" == "ca" ]; then
    echo "Generating request and cert through cluster CA certs directly..."
    read -p "Enter cluster host (IP or DNS, default to localhost): " HOST
    HOST=${HOST:-localhost}
    
    CLUSTER_CA_CERT_PATH="${CERTS_DIR}/ca.crt"
    CLUSTER_CA_KEY_PATH="${CERTS_DIR}/ca.key"
    check_file_existence "$CLUSTER_CA_CERT_PATH"
    check_file_existence "$CLUSTER_CA_KEY_PATH"
    # Generate the user keys
    generate_user_keys
    
    # Generate user cert
    echo "Generating new cert for $USERNAME"
    openssl x509 -req -in ${USER_CERTS_DIR}/${USERNAME}.csr -CA ${CLUSTER_CA_CERT_PATH} -CAkey ${CLUSTER_CA_KEY_PATH}  -CAcreateserial -out ${USER_CERTS_DIR}/${USERNAME}.crt -days 365
    
else
    # Handle invalid input
    echo "Invalid choice. Please enter 'csr' or 'ca'."
    echo "Exiting script without generating request and cert."
    exit 1  # Exit the script with an error code
fi
