#!/bin/bash

readonly SELF_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$SELF_DIR/.env"

# Paths
ARCHIVE_FILE=$(readlink -m "$ROOT_DIR/archive.txt")
DOWNLOAD_SCRIPT=$(readlink -m "$SELF_DIR/download_new_videos.sh")
IN_PROGRESS_FILE=$(readlink -m "$ROOT_DIR/INPROGRESS")

# Fetch video IDs
video_ids=$(yt-dlp --flat-playlist -I -1 -J "$PLAYLIST_URL" | jq -r '.entries.[].id')

# Log the update time
echo "[yt-cart] Lastest video ID fetched at $(date)"

needs_update=false

# Check if another script is already in progress
if [ -e "$IN_PROGRESS_FILE" ]; then
    echo "[yt-cart] Download in progress. Quitting at $(date)"
    exit 1
fi 

# Check if there are new videos to download
if [ ! -f "$ARCHIVE_FILE" ]; then
  needs_update=true
  echo "[yt-cart] archive.txt doesn't exsit, will run the script"
else
  archive_ids=$(<"$ARCHIVE_FILE")
  if [[ $archive_ids != *"youtube $video_ids"* ]]; then
    needs_update=true
    echo "[yt-cart] Playlist changes detected at $(date)"
  else
    echo "[yt-cart] No change detected at $(date)"
  fi
fi

# Download as needed
if [ "$needs_update" = true ]; then
  touch "$IN_PROGRESS_FILE"
  echo "[yt-cart] Downloading new videos at $(date)"
  bash "$DOWNLOAD_SCRIPT"
  rm "$IN_PROGRESS_FILE"
  echo "[yt-cart] Download completed at $(date)"
fi
