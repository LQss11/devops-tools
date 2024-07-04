#!/bin/bash

# Default values
USERNAME="admin"
PASSWORD="adminadmin123"
URL="https://portainer:9443"

TOKEN=""  # Initialize token variable

# Function to prompt for input with a default value
prompt_with_default() {
  local prompt="$1"
  local default="$2"
  read -p "$prompt [$default]: " input
  echo "${input:-$default}"
}

# Function to authenticate and retrieve token
authenticate_and_get_token() {
  local username="$1"
  local password="$2"
  local url="$3"

  # Extract and store the token
  TOKEN=$(curl -k -s -X POST "$url/api/auth" \
    -H "Content-Type: application/json" \
    -d "{\"username\": \"$username\", \"password\": \"$password\"}" | jq -r '.jwt')

  if [[ -z "$TOKEN" || "$TOKEN" == "null" ]]; then
    echo "Failed to retrieve token. Please check your credentials and URL."
    TOKEN=""
    return 1
  fi

  # Print the token
  echo "$TOKEN"
}

# Function to get settings
get_settings() {
  if [[ -z "$TOKEN" ]]; then
    echo "Please retrieve the token first before fetching settings."
    return 1
  fi

  echo "Fetching settings:"
  curl -k -s -X GET "$URL/api/settings" \
    -H "Authorization: Bearer ${TOKEN}" | jq .
}

# Function to update LDAP settings
update_ldap_settings() {
  if [[ -z "$TOKEN" ]]; then
    echo "Please retrieve the token first before updating LDAP settings."
    return 1
  fi

  local ldap_urls ldap_reader_dn ldap_base_dn ldap_user_attr ldap_group_base_dn ldap_group_attr ldap_password

  ldap_url=$(prompt_with_default "Enter LDAP URL" "10.10.10.10:389")
  ldap_reader_dn=$(prompt_with_default "Enter LDAP Reader DN make sure pass double backslash" "MYDN\\ldap")
  ldap_base_dn=$(prompt_with_default "Enter LDAP Base DN" "DC=example,DC=local")
  ldap_user_attr=$(prompt_with_default "Enter LDAP User Attribute" "sAMAccountName")
  ldap_group_base_dn=$(prompt_with_default "Enter LDAP Group Base DN" "")
  ldap_group_attr=$(prompt_with_default "Enter LDAP Group Attribute" "")
  read -s -p "Enter LDAP password: " ldap_password
  echo

  local ldap_settings_payload='{
    "AuthenticationMethod": 2,
    "LDAPSettings": {
      "AnonymousMode": false,
      "ReaderDN": "'"${ldap_reader_dn//\\/\\\\}"'",
      "URLs": ["'"$ldap_url"'"],
      "TLSConfig": {
        "TLS": false,
        "TLSSkipVerify": false
      },
      "StartTLS": false,
      "SearchSettings": [
        {
          "BaseDN": "'"$ldap_base_dn"'",
          "Filter": "",
          "UserNameAttribute": "'"$ldap_user_attr"'"
        }
      ],
      "GroupSearchSettings": [
        {
          "GroupBaseDN": "'"$ldap_group_base_dn"'",
          "GroupFilter": "",
          "GroupAttribute": "'"$ldap_group_attr"'"
        }
      ],
      "AutoCreateUsers": true,
      "ServerType": 0,
      "AdminAutoPopulate": false,
      "AdminGroupSearchSettings": [
        {
          "GroupBaseDN": "",
          "GroupFilter": "",
          "GroupAttribute": ""
        }
      ],
      "AdminGroups": [],
      "URL": "'"$ldap_url"'",
      "Password": "'"$ldap_password"'"
    }
  }'

  response=$(curl -k -s -X PUT "$URL/api/settings" \
    -H "Authorization: Bearer ${TOKEN}" \
    -H "Content-Type: application/json" \
    -d "$ldap_settings_payload")

  if [[ $? -eq 0 ]]; then
    echo "LDAP settings updated successfully."
  else
    echo "Failed to update LDAP settings."
  fi
}


# Function to create a new registry
create_registry() {
  if [[ -z "$TOKEN" ]]; then
    echo "Please retrieve the token first before creating a registry."
    return 1
  fi

  local registry_name="$1"
  local registry_url="$2"
  local auth="$3"
  local reg_username="$4"
  local reg_password="$5"
  local type="$6"

  # Create the registry using retrieved token
  response=$(curl -k -s -X POST "$URL/api/registries" \
    -H "Authorization: Bearer ${TOKEN}" \
    -H "Content-Type: application/json" \
    -d "{
      \"name\": \"$registry_name\",
      \"url\": \"$registry_url\",
      \"authentication\": $auth,
      \"username\": \"$reg_username\",
      \"password\": \"$reg_password\",
      \"type\": $type
    }")

  # Check if the registry creation was successful
  if echo "$response" | grep -q "Another registry with the same URL and credentials already exists"; then
    echo "Registry already exists for this URL and credentials."
  else
    echo "Registry creation request sent successfully."
  fi
}

# Function to verify registries
verify_registries() {
  if [[ -z "$TOKEN" ]]; then
    echo "Please retrieve the token first before verifying registries."
    return 1
  fi

  echo "Checking if the registries have been added:"
  curl -k -s -X GET "$URL/api/registries" \
    -H "Authorization: Bearer ${TOKEN}" | jq .
}

# Function to create a new tag
create_tag() {
  if [[ -z "$TOKEN" ]]; then
    echo "Please retrieve the token first before creating a tag."
    return 1
  fi

  local tag_name
  tag_name=$(prompt_with_default "Enter tag name" "org/acme")

  # Create the tag using retrieved token
  response=$(curl -k -s -X POST "$URL/api/tags" \
    -H "Authorization: Bearer ${TOKEN}" \
    -H "Content-Type: application/json" \
    -d "{\"name\": \"$tag_name\"}")

  # Check if the tag creation was successful
  if [[ $? -eq 0 ]]; then
    echo "Tag '$tag_name' created successfully."
  else
    echo "Failed to create tag '$tag_name'."
  fi
}

# Function to create a new endpoint group
create_endpoint_group() {
  if [[ -z "$TOKEN" ]]; then
    echo "Please retrieve the token first before creating an endpoint group."
    return 1
  fi

  local group_name
  local group_description

  group_name=$(prompt_with_default "Enter group name" "My Endpoint Group")
  group_description=$(prompt_with_default "Enter group description" "Description for My Endpoint Group")

  # Create the endpoint group using retrieved token
  response=$(curl -k -s -X POST "$URL/api/endpoint_groups" \
    -H "Authorization: Bearer ${TOKEN}" \
    -H "Content-Type: application/json" \
    -d "{
      \"associatedEndpoints\": [],
      \"description\": \"$group_description\",
      \"name\": \"$group_name\",
      \"tagIDs\": []
    }")

  # Check if the endpoint group creation was successful
  if [[ $? -eq 0 ]]; then
    echo "Endpoint group '$group_name' created successfully."
  else
    echo "Failed to create endpoint group '$group_name'."
  fi
}

# Function to create a new team
create_team() {
  if [[ -z "$TOKEN" ]]; then
    echo "Please retrieve the token first before creating a team."
    return 1
  fi

  local team_name
  team_name=$(prompt_with_default "Enter team name" "developers")

  # Create the team using retrieved token
  response=$(curl -k -s -X POST "$URL/api/teams" \
    -H "Authorization: Bearer ${TOKEN}" \
    -H "Content-Type: application/json" \
    -d "{
      \"name\": \"$team_name\",
      \"teamLeaders\": []
    }")

  # Check if the team creation was successful
  if [[ $? -eq 0 ]]; then
    echo "Team '$team_name' created successfully."
  else
    echo "Failed to create team '$team_name'."
  fi
}

# Cleanup function to execute on exit
cleanup() {
  echo "Cleaning up..."
  # Add cleanup actions here if needed
  exit 0
}

# Trap Ctrl+C (SIGINT) signal and call cleanup function
trap cleanup SIGINT

# Main script logic
echo "Authenticating and retrieving token..."
authenticate_and_get_token "$USERNAME" "$PASSWORD" "$URL"
if [[ -z "$TOKEN" ]]; then
  echo "Token retrieval failed. Exiting script."
  exit 1
fi
echo "Token retrieved: $TOKEN"
echo

# Main script loop
while true; do
  echo "Select an action:"
  echo "1. Create Registry"
  echo "2. Verify Registries"
  echo "3. Get Settings"
  echo "4. Update LDAP Settings"
  echo "5. Create Tag"
  echo "6. Create Endpoint Group"
  echo "7. Create Team"
  echo "8. Exit"

  read -p "Enter your choice [1-8]: " choice

  case $choice in
    1)
      # Create Registry
      create_registry \
        "$(prompt_with_default "Enter registry name" "myregistry")" \
        "$(prompt_with_default "Enter registry URL" "10.10.10.10:5000")" \
        true \
        "$(prompt_with_default "Enter registry username" "test")" \
        "$(prompt_with_default "Enter registry password" "test123")" \
        3
      ;;
    2)
      # Verify Registries
      verify_registries
      ;;
    3)
      # Get Settings
      get_settings
      ;;
    4)
      # Update LDAP Settings
      update_ldap_settings
      ;;
    5)
      # Create Tag
      create_tag
      ;;
    6)
      # Create Endpoint Group
      create_endpoint_group
      ;;
    7)
      # Create Team
      create_team
      ;;
    8)
      # Exit
      echo "Exiting script."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please enter a number between 1 and 8."
      ;;
  esac

  echo  # Print an empty line for readability
done
