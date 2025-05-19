#!/bin/bash

readonly SELF_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$SELF_DIR/.env"

DOWNLOAD_DIR=$(readlink -m "$ROOT_DIR/downloads/")
ARCHIVE_DIR=$(readlink -m "$ROOT_DIR/archive/")

mkdir -p "$(dirname "$ARCHIVE_DIR")"

# find the clip folders older than 7 days under each author 
find "$DOWNLOAD_DIR" -mindepth 2 -maxdepth 2 -type d -mtime +7 | while read -r folder; do
    rel_folder=$(readlink -m "${folder#$DOWNLOAD_DIR}")
    new_folder=$(readlink -m "$ARCHIVE_DIR/$rel_folder")
    mkdir -p "$new_folder"
    mv "$folder/" "$new_folder/"
    echo "Archived: $rel_folder"
done
