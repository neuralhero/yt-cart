#!/bin/bash

source ./.env

# File to store video IDs
VIDEO_IDS_FILE="$ROOT_DIR/video_ids.txt"

# Fetch video IDs
yt-dlp --flat-playlist -J "$PLAYLIST_URL" | jq -r '.entries[].id' > "$VIDEO_IDS_FILE"

# Log the update time
echo "Video IDs updated at $(date)"
