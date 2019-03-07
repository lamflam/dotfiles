#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

print_spotify_track() {
  current_track_property "name"
}

main() {
  print_spotify_track
}

main


