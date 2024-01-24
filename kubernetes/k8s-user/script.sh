#!/bin/bash

# Ask user to input kubeconfig path (default to configs/config)
read -p "Enter the kubeconfig path (default to configs/config): " KUBECONFIG_PATH
export KUBECONFIG=${KUBECONFIG_PATH:-configs/config}

# Ask user to input username and group name (default to DevUser and dev)
read -p "Enter the username (default to DevUser): " USER_NAME
USER_NAME=${USER_NAME:-DevUser}

read -p "Enter the group name (default to dev): " USERGROUP
USERGROUP=${USERGROUP:-dev}

# Verify if the kubeconfig path specified exists or not before proceeding
if [ ! -f "$KUBECONFIG" ]; then
    echo "Error: Kubeconfig path '$KUBECONFIG' does not exist. Exiting."
    exit 1
fi

# Set user variables
USER_DIR="certs/${USER_NAME}"

# Check if the user directory exists
if [ -d "$USER_DIR" ]; then
    echo "Error: User directory '$USER_DIR' already exists. Exiting."
    exit 1
fi

# Check if CSR for the user already exists
if kubectl get csr "${USER_NAME}"; then
    echo "Error: Certificate Signing Request (CSR) for user '${USER_NAME}' already exists. Exiting."
    exit 1
fi

# Set up user kubeconfig directory
USER_CONFIG_PATH="configs/${USER_NAME}-config"
rm -rf ${USER_CONFIG_PATH}
touch ${USER_CONFIG_PATH}

# Create user directory
mkdir -p "${USER_DIR}"

# Generate RSA key and CSR
openssl genrsa -out "${USER_DIR}/${USER_NAME}.key" 2048
openssl req -new -key "${USER_DIR}/${USER_NAME}.key" -out "${USER_DIR}/${USER_NAME}.csr" -subj "/CN=${USER_NAME}/O=${USERGROUP}"

# Create CertificateSigningRequest
CSR_BASE64=$(cat "${USER_DIR}/${USER_NAME}.csr" | base64 | tr -d "\n")
cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: ${USER_NAME}
spec:
  request: ${CSR_BASE64}
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400 # 24 hours
  usages:
  - client auth
EOF

# Approve CertificateSigningRequest
kubectl certificate approve ${USER_NAME}

# Get the certificate
CERTIFICATE=$(kubectl get csr/${USER_NAME} -o jsonpath='{.status.certificate}')
echo "${CERTIFICATE}" | base64 -d > "${USER_DIR}/${USER_NAME}.crt"

# Add to kubeconfig
export KUBECONFIG=${USER_CONFIG_PATH}
kubectl config set-cluster kubernetes --server=https://localhost:6443 --certificate-authority certs/ca.crt --embed-certs
kubectl config set-credentials ${USER_NAME} --client-key="${USER_DIR}/${USER_NAME}.key" --client-certificate="${USER_DIR}/${USER_NAME}.crt" --embed-certs=true
kubectl config set-context ${USER_NAME} --cluster=kubernetes --user=${USER_NAME}
kubectl config use-context ${USER_NAME}

echo "User ${USER_NAME} created and configured successfully."

# Additional steps (uncomment if needed)
# Create Role and RoleBinding
# kubectl create role developer --verb=create --verb=get --verb=list --verb=update --verb=delete --resource=pods
# kubectl create rolebinding developer-binding-${USER_NAME} --role=developer --user=${USER_NAME}

# To test, you can run kubectl get pods --kubeconfig .\configs\youruser-config
