#!/bin/bash
group=$1
title=$(echo "# $group" | tr '[:lower:]' '[:upper:]')

# Fetch the vault data once
vault_data=$(vault kv list -format=json secret/$group)

# Extract keys from the vault data
keys=($(echo "$vault_data" | jq -r '.[]'))

# Initialize the associative array for modified data
declare -A modified_data_array

# Loop through the keys and retrieve JSON data for each key
for key in "${keys[@]}"; do
    data=$(vault kv get -format=json "secret/$group/$key" 2>/dev/null)

    # Check if vault kv get was successful
    if [ $? -eq 0 ]; then
        data=$(echo "$data" | jq -r '.data.data')
        modified_data=$(echo "$data" | jq --arg tool "$key" '. + { "object": $tool }')
        
        # Store the modified data in an associative array
        modified_data_array["$key"]=$modified_data
    else
        error_message=$(echo "$data" | jq -r '.errors[0]')
        if [[ "$error_message" == *"permission denied"* ]]; then
            echo "Skipping '$key' due to permission denied error."
        fi
    fi
done

# Initialize a Markdown table header
table_header=""

# Loop through the keys and build the header based on available fields
for key in "${keys[@]}"; do
    modified_data="${modified_data_array[$key]}"
    if [ -n "$modified_data" ]; then
        field_names=$(echo "$modified_data" | jq -r 'keys[]')
        for field in $field_names; do
            table_header+="| $field "
        done
        break  # Only need the header from the first key
    fi
done
table_header+="|"

# Initialize a variable to store Markdown table rows
table_rows=""

shopt -s nocasematch
# Loop through the keys again and retrieve JSON data from the array
for key in "${keys[@]}"; do
    modified_data="${modified_data_array[$key]}"
    
    # Check if data exists for this key
    if [ -n "$modified_data" ]; then
        table_row=""
        for field in $table_header; do
            if [ "$field" != "|" ]; then
                value=$(echo "$modified_data" | jq -r --arg field "$field" '.[$field] // "N/A"')
                
                # Replace values while ignoring case
                if [[ "$value" == "n/a" ]]; then
                    value="🚫"
                elif [[ "$value" == "false" ]]; then
                    value="❌"
                elif [[ "$value" == "true" ]]; then
                    value="✅"
                fi
                
                table_row+="| $value "
            fi
        done
        table_row+="|"
        table_rows+="\n$table_row"
    fi
done

# Add the header separator
header_separator=$(echo "$table_header" | sed 's/[^|]/-/g')
table_header="$table_header\n$header_separator"

# Combine the table header and rows
markdown_table="$title\n$table_header$table_rows"

echo -e "$markdown_table"
