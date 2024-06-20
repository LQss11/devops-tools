#!/bin/bash

# On-premises Azure DevOps API endpoint and authentication details
AZURE_DEVOPS_URL="https://dev.azure.com/OrganizationName"
PROJECT="My%20Wiki"  # Replace with your project name
WIKI_IDENTIFIER="My-Wiki.wiki"  # Adjust as per your wiki identifier
# WIKI_PAGE_PATH="/aaaaa"  # Adjust as per the path of your wiki page
WIKI_PAGE_PATH="/aaaaa/bbbb"  # Adjust as per the path of your wiki page
AUTH_TOKEN=":tokenexample"  # Replace with your personal access token or appropriate authentication

# Content to update or create
NEW_CONTENT="Updated content for page"

# Construct the API URL for fetching page details
API_URL="${AZURE_DEVOPS_URL}/${PROJECT}/_apis/wiki/wikis/${WIKI_IDENTIFIER}/pages?path=${WIKI_PAGE_PATH}&api-version=5.1"

# Function to delete existing wiki page
delete_wiki_page() {
  # Check if the page exists
  existing_page=$(curl -s -X GET -u "$AUTH_TOKEN" "$API_URL")

  if [[ $existing_page == *"The page '${WIKI_PAGE_PATH}' specified in the operation does not exist in the wiki."* ]]; then
    echo "Wiki page '${WIKI_PAGE_PATH}' does not exist."
  else
    # Page exists, extract page ID
    page_id=$(echo "$existing_page" | jq -r '.value[0].id')

    # Delete the existing page
    curl -s -X DELETE -u "$AUTH_TOKEN" "${API_URL}&api-version=5.1"
    echo "Deleted existing wiki page '${WIKI_PAGE_PATH}'"
  fi
}

# Function to create new wiki page
create_wiki_page() {
  # Create new wiki page with updated content
  curl -s -X PUT -u "$AUTH_TOKEN" "$API_URL" \
    -H "Content-Type: application/json" \
    -d '{
      "content": "'"${NEW_CONTENT} and date is $(date)"'"
    }'
  echo "Created new wiki page '${WIKI_PAGE_PATH}'"
}

# Execute functions to delete and create wiki page
delete_wiki_page
create_wiki_page
