#!/bin/bash

# Function to create a certificate request
create_certificate_request() {
    read -p "Enter the common name (CN): " common_name
    read -p "Enter the organization (O): " organization
    read -p "Enter the private key path (client): " key_path
    openssl req -new -key "${key_path}" -subj "/CN=${common_name}/O=${organization}" -out req.csr
    echo "Certificate request created successfully."
}

# Function to display certificate details
display_certificate_details() {
    read -p "Enter the certificate path: " cert_path
    openssl x509 -in "${cert_path}" -text -noout
}

# Function to generate a private key
generate_private_key() {
    read -p "Enter the key name (client, server): " key_name
    openssl genrsa -out "${key_name}.key" 2048
    echo "Private key generated successfully."
}

# Function to generate a server certificate
generate_server_certificate() {
    read -p "Enter the private key path: " key_path
    openssl req -new -x509 -key "${key_path}" -out ca.crt -days 365
    echo "Server certificate generated successfully."
}

# Function to approve a certificate request
approve_certificate_request() {
    read -p "Enter the csr certificate request path: " request_path
    read -p "Enter the signing (ca private) key path: " signing_key_path
    read -p "Enter the final signed certificate path: " signed_cert_path

    if [ -f "${signing_key_path}" ] && [ -f "ca.crt" ]; then
        openssl x509 -req -in "${request_path}" -CAkey "${signing_key_path}" -CA ca.crt -CAcreateserial -out "${signed_cert_path}" -days 365
        echo "Certificate request approved and signed certificate generated successfully."
    else
        echo "Signing key or CA certificate not found. Please ensure 'ca.crt' and signing key exist."
    fi
}

# Main menu loop
while true; do
    echo "Select an option:"
    echo "1. Create a certificate request"
    echo "2. Display certificate details"
    echo "3. Generate a private key"
    echo "4. Generate a server certificate"
    echo "5. Approve a certificate request"
    echo "6. Exit"

    read -p "Option: " option

    case $option in
        1)
            create_certificate_request
            ;;
        2)
            display_certificate_details
            ;;
        3)
            generate_private_key
            ;;
        4)
            generate_server_certificate
            ;;
        5)
            approve_certificate_request
            ;;
        6)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac

    echo
done
