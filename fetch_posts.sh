#!/bin/bash

# Check if required environment variables are set
if [ -z "$BEEHIIV_PUB_ID" ] || [ -z "$BEEHIIV_API_KEY" ]; then
  echo "Error: BEEHIIV_PUB_ID and BEEHIIV_API_KEY environment variables must be set."
  exit 1
fi

# Check if jq is installed
if ! command -v jq &>/dev/null; then
  echo "Error: jq (JSON processor) is not installed. Please install jq and try again."
  exit 1
fi

# Check if curl is installed
if ! command -v curl &>/dev/null; then
  echo "Error: curl is not installed. Please install curl and try again."
  exit 1
fi

# Set the base URL
BASE_URL="https://api.beehiiv.com/v2/publications/$BEEHIIV_PUB_ID/posts"

# Set the initial page number
PAGE=1

# Set the number of results per page
LIMIT=100

# Initialize an array to store all results
ALL_RESULTS=()

# Get the total number of results
TOTAL_RESULTS=$(curl --silent --request GET --url "$BASE_URL?limit=1" --header 'Accept: application/json' --header "Authorization: $BEEHIIV_API_KEY" | jq '.total_results')

# Calculate the total number of pages
TOTAL_PAGES=$((($TOTAL_RESULTS + $LIMIT - 1) / $LIMIT))

echo $TOTAL_PAGES

# Loop over all pages
while [ $PAGE -le $TOTAL_PAGES ]; do
  echo $PAGE
  # Fetch the results for the current page
  RESPONSE=$(curl --silent --request GET --url "$BASE_URL?page=$PAGE&limit=$LIMIT&expand=premium_web_content" --header 'Accept: application/json' --header "Authorization: $BEEHIIV_API_KEY")

  # Add the response to the ALL_RESULTS array
  ALL_RESULTS+=("$RESPONSE")

  # Increment the page number
  PAGE=$((PAGE + 1))
done

# Join the array elements into a single string
JSON_DATA=$(printf "%s\n" "${ALL_RESULTS[@]}")

# Write the JSON data to a file
echo "$JSON_DATA" >temp.json

jq -s '{ data: map(.data[]) }' temp.json >posts.json

rm temp.json

echo "$TOTAL_RESULTS posts written to posts.json"
