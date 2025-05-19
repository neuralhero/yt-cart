#!/bin/bash

source ./.env

# Modify these based on own use case
yt-dlp \
  --download-archive "$ROOT_DIR/archive.txt" \
  -P "$ROOT_DIR" \
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
