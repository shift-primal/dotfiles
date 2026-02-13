#!/usr/bin/env bash

PROFILE_DIR="$HOME/.config/hypr/profiles"
SYMLINK="$HOME/.config/hypr/overrides"

# List available profiles
profiles=$(ls -1 "$PROFILE_DIR")

if [[ -n "$1" ]]; then
  # Direct mode: pass profile name as argument
  selected="$1"
else
  # Interactive mode: use rofi
  selected=$(echo "$profiles" | rofi -dmenu -p "Hyprland Profile")
fi

[[ -z "$selected" ]] && exit 1

if [[ ! -d "$PROFILE_DIR/$selected/" ]]; then
  notify-send "Hypr Profile" "Profile '$selected' not found"
  exit 1
fi

# Remove old symlink -> make new
rm -rf "$SYMLINK"
ln -s "$PROFILE_DIR/$selected" "$SYMLINK"

# Reload Hyprland (twice) to pick up changes

hyprctl reload
sleep 2
hyprctl reload

notify-send "Hypr Profile" "Switched to: $selected"
