#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

print_spotify_album() {
  current_track_property "album"
}

main() {
  print_spotify_album
}

main

