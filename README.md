# Improved Beehiiv Search Experience

These two Bash scripts allow you to easily fetch and manage Beehiiv posts.

![exp-beehiiv-search2](https://github.com/securibee/improved-beehiiv-search-experience/assets/51520913/a9fa88d2-c9ac-491d-99c7-eed84e026c5b)

## Requirements

- Bash shell
- `jq` (JSON processor)
- `curl`
- `fzf` (fuzzy finder)

## Setup

Set the following environment variables with your Beehiiv API credentials:
   - `BEEHIIV_PUB_ID`: Your Beehiiv publication ID
   - `BEEHIIV_API_KEY`: Your Beehiiv API key

You can find both on the Beehiiv [integrations page](https://app.beehiiv.com/settings/integrations/api).

## fetch_posts.sh

This script fetches all posts from the Beehiiv API and saves them to a `posts.json` file.

### Usage

```bash
./fetch_posts.sh
```

The script will fetch all posts from the Beehiiv API and save them to `posts.json`. It will also print the total number of posts fetched.

## manage_posts.sh

This script allows you to fuzzy search, select, and perform actions on the posts fetched by `fetch_posts.sh`.

### Usage

```bash
./manage_posts.sh
```

The script will present a fuzzy search interface using `fzf`. You can search for a post by its title, and select it by pressing Enter.

Once a post is selected, you will be prompted to choose an action:

1. **Edit**: Opens the post's edit page in your default browser.
2. **Open**: Opens the post's public URL in your default browser.
3. **Copy**: Copies the post's public URL to your clipboard.

Note: The `fetch_posts.sh` script should be run first to generate the `posts.json` file required by `manage_posts.sh`.

## Notes

- The `open` command is used to open URLs in the default browser. On macOS, this command is built-in. On other systems, you may need to substitute it with the appropriate command for opening URLs.
- The `pbcopy` command is used to copy text to the clipboard on macOS. On other systems, you may need to substitute it with the appropriate command for copying to the clipboard.
