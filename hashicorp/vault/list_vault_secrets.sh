#!/bin/bash
secret_path=$1
echo "# $secret_path"
vault_output=$(vault kv list secret/$secret_path)
keys=$(echo "$vault_output" | tail -n +3)  # Skip the first two lines

# Initialize an empty array to store modified JSON data
data_array=()

# Loop through the keys and retrieve JSON data for each key
for key in $keys; do
    data=$(vault kv get -format=json "secret/$secret_path/$key" 2>/dev/null)
    
    # Check if vault kv get was successful
    if [ $? -eq 0 ]; then
        # Extract JSON data from the result
        data=$(echo "$data" | jq -r '.data.data')
        
        # Add "tool" field to the JSON data with the corresponding key
        modified_data=$(echo "$data" | jq --arg tool "$key" '. + { "tool": $tool }')
        data_array+=("$modified_data")
    fi
done

# Join the modified JSON data objects into a single JSON array
combined_data="[ $(IFS=, ; echo "${data_array[*]}") ]"
echo $combined_data | jq -r .


#### POLICY example
## dev env secrets under paths like this secret/<level1>/<level2>/test
# path "secret/data/+/+/dev"
# {
#   capabilities = ["read"]
# }
## Test env secrets under paths like this secret/<level1>/<level2>/test
# path "secret/data/+/+/test"
# {
#   capabilities = ["read"]
# }

## Allow liting secrets under paths like this secret/<level1>/<level2>/*
# path "secret/metadata/+/*"
# {
#   capabilities = ["list"]
# }

