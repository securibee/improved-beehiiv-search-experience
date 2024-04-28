#!/bin/bash

if ! [ -f posts.json ]; then
	echo "posts.json does not exist."
fi

# Function to fuzzy search and extract fields
fuzzy_search() {
	json_file="$1"
	selected_item=$(jq -r '.data[] | [.id, .title, .web_url] | @tsv' "$json_file" | fzf --delimiter='\t' --with-nth=2)
	if [ -n "$selected_item" ]; then
		IFS=$'\t' read -r id title web_url <<<"$selected_item"
	else
		echo "No item selected."
		return 1
	fi

	id="${id##post_}"       # Remove "post_" prefix from id
	id="${id%% *}"          # Remove any trailing whitespace from id
	title="${title#* }"     # Remove leading whitespace from title
	web_url="${web_url#* }" # Remove leading whitespace from web_url
}

# Function to prompt for action and execute it
take_action() {
	edit_url="https://app.beehiiv.com/posts/$id/edit"
	open_or_copy_url="$web_url"

	echo "Select an action:"
	echo "1. Edit"
	echo "2. Open"
	echo "3. Copy"

	# Only require input instead of requiring extra "Enter" action
	read -n 1 -r action

	case "$action" in
	1)
		open "$edit_url"
		;;
	2)
		open "$open_or_copy_url"
		;;
	3)
		echo "$open_or_copy_url" | pbcopy
		;;
	*)
		echo "Invalid action"
		;;
	esac
}

# Check if jq is installed
if ! command -v jq &>/dev/null; then
	echo "jq is required but not installed. Please install it first."
	exit 1
fi

fuzzy_search posts.json
take_action
