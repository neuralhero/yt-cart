#!/bin/bash

readonly SELF_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$SELF_DIR/.env"

# Paths
VIDEO_IDS_FILE=$(readlink -m "$ROOT_DIR/video_ids.txt")
PREV_VIDEO_IDS_FILE=$(readlink -m "$ROOT_DIR/prev_video_ids.txt")
DOWNLOAD_SCRIPT=$(readlink -m "$SELF_DIR/download_new_videos.sh")

# Ensure prev_video_ids.txt exists
if [ ! -f "$PREV_VIDEO_IDS_FILE" ]; then
  touch "$PREV_VIDEO_IDS_FILE"
  echo "Created initial prev_video_ids.txt"
fi

# Check for changes
if ! diff "$VIDEO_IDS_FILE" "$PREV_VIDEO_IDS_FILE" >/dev/null; then
  echo "Change detected at $(date). Triggering download..."
  cp "$VIDEO_IDS_FILE" "$PREV_VIDEO_IDS_FILE"
  bash "$DOWNLOAD_SCRIPT"
else
  echo "No change detected at $(date)."
fi
