#!/bin/bash
export KUBECONFIG=configs/config
# Set user variables
USER_NAME="myexample"
EXPIRATION_SECONDS="86400"  # one day
USER_DIR="certs/${USER_NAME}"

# Create user directory
mkdir -p "${USER_DIR}"

# Generate RSA key and CSR
openssl genrsa -out "${USER_DIR}/${USER_NAME}.key" 2048
openssl req -new -key "${USER_DIR}/${USER_NAME}.key" -out "${USER_DIR}/${USER_NAME}.csr" -subj "/CN=${USER_NAME}"

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
  expirationSeconds: ${EXPIRATION_SECONDS}
  usages:
  - client auth
EOF

# Approve CertificateSigningRequest
kubectl certificate approve ${USER_NAME}

# Get the certificate
CERTIFICATE=$(kubectl get csr/${USER_NAME} -o jsonpath='{.status.certificate}')
echo "${CERTIFICATE}" | base64 -d > "${USER_DIR}/${USER_NAME}.crt"

# # Create Role and RoleBinding
# kubectl create role developer --verb=create --verb=get --verb=list --verb=update --verb=delete --resource=pods
# kubectl create rolebinding developer-binding-${USER_NAME} --role=developer --user=${USER_NAME}

# Set up user kubeconfig directory
USER_CONFIG_DIR="configs/${USER_NAME}-config"
touch ${USER_CONFIG_DIR}
export KUBECONFIG=${USER_CONFIG_DIR}

# Add to kubeconfig
kubectl config set-cluster kubernetes --server=https://localhost:6443 --certificate-authority certs/ca.crt --embed-certs
kubectl config set-credentials ${USER_NAME} --client-key="${USER_DIR}/${USER_NAME}.key" --client-certificate="${USER_DIR}/${USER_NAME}.crt" --embed-certs=true
kubectl config set-context ${USER_NAME} --cluster=kubernetes --user=${USER_NAME}
kubectl config use-context ${USER_NAME}

echo "User ${USER_NAME} created and configured successfully."

# Create Role and RoleBinding
# kubectl create role developer --verb=create --verb=get --verb=list --verb=update --verb=delete --resource=pods
# kubectl create rolebinding developer-binding-${USER_NAME} --role=developer --user=${USER_NAME}
# To test you can run kubectl get pods --kubeconfig .\configs\bisou-config