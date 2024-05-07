#!/bin/bash

# Get the list of node names
nodes=$(kubectl get nodes | awk '{print $1}' | tail -n +2)
# Make sure to install node-shell plugin to login into nodes
# Loop through each node and run the command in the background
for node in $nodes; do
    echo "###### Images On Node $node are ######"
    kubectl node-shell $node <<EOF 2>/dev/null
        crictl image
EOF
    echo ""
done


