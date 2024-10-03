#!/bin/bash
# https://www.mongodb.com/docs/mongodb-shell/install/
# Step 1: Import the public key used by the package management system
echo "Importing MongoDB public GPG key..."
wget -qO- https://www.mongodb.org/static/pgp/server-7.0.asc | sudo tee /etc/apt/trusted.gpg.d/server-7.0.asc

# Step 2: Create a list file for MongoDB
echo "Creating the MongoDB list file for Ubuntu 22.04 (Jammy)..."
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# Step 3: Reload local package database
echo "Reloading the local package database..."
sudo apt-get update

# Step 4: Install the mongosh package
echo "Installing MongoDB Shell (mongosh)..."
sudo apt-get install -y mongodb-mongosh

# Step 5: Confirm mongosh installation
echo "Confirming mongosh installation..."
mongosh --version
