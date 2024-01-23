#!/bin/bash
CONFIG_PATH=config
# Cluster definition
CLUSTER_NAME=default
HOST=localhost
CLUSTER_CA_CERT_PATH=certs/ca.crt
CLUSTER_CA_KEY_PATH=certs/ca.key
# User definition
USERNAME=someuser
USERGROUP=dev
touch $CONFIG_PATH
KUBECONFIG=${CONFIG_PATH} kubectl config set-cluster ${CLUSTER_NAME} --server=${HOST}:6443 --certificate-authority ${CLUSTER_CA_CERT_PATH} --embed-certs

DIR=certs/${USERNAME}
mkdir -p ${DIR}
CERTS_PREFIX=${DIR}/${USERNAME}
# Generate cert request
openssl genrsa -out ${CERTS_PREFIX}.key 2048
openssl req -new -key ${CERTS_PREFIX}.key -out ${CERTS_PREFIX}.csr -subj "/CN=${USERNAME}/O=${USERGROUP}"
# Generate user cert
openssl x509 -req -in ${CERTS_PREFIX}.csr -CA ${CLUSTER_CA_CERT_PATH} -CAkey ${CLUSTER_CA_KEY_PATH}  -CAcreateserial -out ${CERTS_PREFIX}.crt -days 365

# Generate a new user in the kubeconfig
KUBECONFIG=${CONFIG_PATH} kubectl config set-credentials ${USERNAME} --client-certificate ${CERTS_PREFIX}.crt --client-key ${CERTS_PREFIX}.key --embed-certs
# Assign a new context for the new user
KUBECONFIG=${CONFIG_PATH} kubectl config set-context ${USERNAME} --user=${USERNAME} --cluster=${CLUSTER_NAME} --namespace=default
# Set context to current user
KUBECONFIG=${CONFIG_PATH} kubectl config use-context ${USERNAME}

