#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

print_spotify_artist() {
  current_track_property "artist"
}

main() {
  print_spotify_artist
}

main
