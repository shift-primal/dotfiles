#!/usr/bin/env bash

set -euo pipefail

KEYBINDS_FILE="$HOME/.config/hypr/hyprland/keybinds.conf"

parse_keybinds() {
  local current_group=""
  local group_printed=false

  while IFS= read -r line; do
    [[ -z "${line// /}" ]] && continue

    if [[ "$line" =~ ^###[[:space:]]*(.+)[[:space:]]*###$ ]]; then
      current_group="${BASH_REMATCH[1]}"
      group_printed=false
      continue
    fi

    if [[ "$line" =~ ^#[[:space:]]+([^#].+)$ ]]; then
      current_group="${BASH_REMATCH[1]}"
      group_printed=false
      continue
    fi

    [[ "$line" =~ ^[[:space:]]*# ]] && continue
    [[ "$line" =~ ^\$ ]] && continue

    if [[ "$line" =~ ^[Bb]indd[m]?[[:space:]]*=[[:space:]]*([^,]+),[[:space:]]*([^,]+),[[:space:]]*([^,]+), ]]; then
      if [[ -n "$current_group" && "$group_printed" == false ]]; then
        printf '%b\n' "<b>${current_group}</b>"
        group_printed=true
      fi

      modifiers="${BASH_REMATCH[1]}"
      key="${BASH_REMATCH[2]}"
      description="${BASH_REMATCH[3]}"

      modifiers="${modifiers//\$mainMod/Super}"
      modifiers=$(echo "$modifiers" | xargs)
      key=$(echo "$key" | xargs)
      description=$(echo "$description" | xargs)

      # Rename keys
      key="${key/XF86AudioRaiseVolume/Vol+}"
      key="${key/XF86AudioLowerVolume/Vol-}"
      key="${key/XF86AudioMute/Mute}"
      key="${key/mouse:272/Left Click}"
      key="${key/mouse:273/Right Click}"

      keybind="${modifiers} + ${key}"

      printf '  %-40s <span foreground="#908caa">%s</span>\n' "$description" "$keybind"
    fi
  done <"$KEYBINDS_FILE"
}

printf '\0prompt\x1f󰌌 Keys\n'
printf '\0markup-rows\x1ftrue\n'
printf '\0no-custom\x1ftrue\n'
parse_keybinds
