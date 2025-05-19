#!/bin/bash

readonly SELF_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$SELF_DIR/.env"

# Modify these based on own use case
# keep an archive of downloaded videos at archive.txt to avoid repetition
# download to set ROOT_DIR
# download English subtitles and thumbnails
# Embed chapters in the videos, including those from SponsorBlock
# sleep 10-75 seconds between actions to avoid IP blocking

yt-dlp \
  --download-archive "$ROOT_DIR/archive.txt" \
  -P "$ROOT_DIR/downloads/" \
  -o "subtitle:%(uploader)s/%(title)s/subs/%(title)s [%(id)s].%(ext)s" \
  -o "%(uploader)s/%(title)s/%(title)s [%(id)s].%(ext)s" \
  --embed-chapters \
  --playlist-reverse \
  --write-description \
  --write-thumbnail \
  --write-sub --write-auto-sub --sub-lang "en.*" \
  --sponsorblock-mark sponsor \
  --sleep-interval 10 \
  --max-sleep-interval 75 \
  "$PLAYLIST_URL"
