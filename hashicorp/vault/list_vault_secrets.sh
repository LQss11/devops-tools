#!/bin/bash
secret_path=$1
echo "# $secret_path"
vault_output=$(vault kv list secret/$secret_path)
keys=$(echo "$vault_output" | tail -n +3)  # Skip the first two lines

# Initialize an empty array to store modified JSON data
data_array=()

# Loop through the keys and retrieve JSON data for each key
for key in $keys; do
    data=$(vault kv get -format=json "secret/$secret_path/$key" | jq -r '.data.data')
    # Add "tool" field to the JSON data with the corresponding key
    modified_data=$(echo "$data" | jq --arg tool "$key" '. + { "tool": $tool }')
    data_array+=("$modified_data")
done

# Join the modified JSON data objects into a single JSON array
combined_data="[ $(IFS=, ; echo "${data_array[*]}") ]"
echo $combined_data | jq -r .
# echo "$combined_data"  | jq -r '[ .[] | keys[] ] | unique | "|" + join(" | ") + " |"'
