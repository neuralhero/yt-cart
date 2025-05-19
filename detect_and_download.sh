#!/bin/bash

readonly SELF_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$SELF_DIR/.env"

# Paths
VID_HASH_FILE=$(readlink -m "$ROOT_DIR/video_ids_hash.txt")
DOWNLOAD_SCRIPT=$(readlink -m "$SELF_DIR/download_new_videos.sh")

# Fetch video IDs
video_ids=$(yt-dlp --flat-playlist -J "$PLAYLIST_URL" | jq -r '.entries[].id')
video_hash=$(echo -n $video_ids | sha256sum | awk '{print $1}')

# Log the update time
echo "Video IDs and hash fetched at $(date)"

needs_update=false

# Ensure video_ids_hash.txt exists
if [ ! -f "$VID_HASH_FILE" ]; then
  needs_update=true
  echo $video_hash > "$VID_HASH_FILE"
  echo "Created initial video_ids_hash.txt"
else
  prev_video_hash=$(<"$VID_HASH_FILE")
  if [[ "$video_hash" != "$prev_video_hash" ]]; then
    needs_update=true
    echo $video_hash > "$VID_HASH_FILE"
    echo "Change detected and hash updated at $(date)"
  else
    echo "No change detected at $(date)"
  fi
fi

# Download as needed
if [ "$needs_update" = true ]; then
  echo "Downloading new videos at $(date)"
  bash "$DOWNLOAD_SCRIPT"
fi
