#!/usr/bin/env bash

# Path to your keybinds config
KEYBINDS_FILE="$HOME/.config/hypr/hyprland/keybinds.conf"

# Parse keybindings and format for rofi, preserving groups
parse_keybinds() {
  local current_group=""
  local group_printed=false

  while IFS= read -r line; do
    # Skip empty lines
    [[ -z "${line// /}" ]] && continue

    # Check for major section headers (### SECTION ###)
    if [[ "$line" =~ ^###[[:space:]]*(.+)[[:space:]]*###$ ]]; then
      current_group="${BASH_REMATCH[1]}"
      group_printed=false
      continue
    fi

    # Check for sub-group headers (# Group Name)
    if [[ "$line" =~ ^#[[:space:]]+([^#].+)$ ]]; then
      current_group="${BASH_REMATCH[1]}"
      group_printed=false
      continue
    fi

    # Skip other comments and variable definitions
    [[ "$line" =~ ^[[:space:]]*# ]] && continue
    [[ "$line" =~ ^\$ ]] && continue

    # Match bindd or binddm lines (case-insensitive for Bindd)
    if [[ "$line" =~ ^[Bb]indd[m]?[[:space:]]*=[[:space:]]*([^,]+),[[:space:]]*([^,]+),[[:space:]]*([^,]+), ]]; then
      # Print group header if we haven't yet for this group
      if [[ -n "$current_group" && "$group_printed" == false ]]; then
        echo "─── $current_group ───"
        group_printed=true
      fi

      modifiers="${BASH_REMATCH[1]}"
      key="${BASH_REMATCH[2]}"
      description="${BASH_REMATCH[3]}"

      # Replace $mainMod with Super
      modifiers="${modifiers//\$mainMod/Super}"

      # Clean up extra spaces
      modifiers=$(echo "$modifiers" | xargs)
      key=$(echo "$key" | xargs)
      description=$(echo "$description" | xargs)

      # Format the keybind
      keybind="${modifiers} + ${key}"

      # Output in format: "Description | Keybind"
      printf "  %-48s | %s\n" "$description" "$keybind"
    fi
  done <"$KEYBINDS_FILE"
}

# Show in rofi (no sort to preserve group order)
parse_keybinds | rofi -dmenu -i -p "Keybindings" -theme-str 'listview {columns: 1;}'
