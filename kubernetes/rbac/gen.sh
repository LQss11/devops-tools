#!/bin/sh
# ***
# Make sure you are in a directory where you have the ca cert and key
# ***
# Vareiables
USERNAME=${1:-DevUser}
USERDEP=${2:-development}
CLUSTER=${3:-docker-desktop}
# Create cert directory
mkdir -p ${USERDEP}/${USERNAME}
# Create key + cert request + accept cert
openssl genrsa -out ${USERDEP}/${USERNAME}/${USERNAME}.key 2048
openssl req -new -key ${USERDEP}/${USERNAME}/${USERNAME}.key -out ${USERDEP}/${USERNAME}/${USERNAME}.csr -subj "/CN=${USERNAME}/O=${USERDEP}"
openssl x509 -req -in ${USERDEP}/${USERNAME}/${USERNAME}.csr -CA ./ca.crt -CAkey ./ca.key  -CAcreateserial -out ${USERDEP}/${USERNAME}/${USERNAME}.crt -days 365
# Add user to kubeconfig
kubectl config set-credentials ${USERNAME} --client-certificate ./${USERDEP}/${USERNAME}/${USERNAME}.crt --client-key ./${USERDEP}/${USERNAME}/${USERNAME}.key
# Create a new context for the new user
kubectl config set-context ${USERNAME} --user=${USERNAME} --cluster=${CLUSTER} --namespace=default