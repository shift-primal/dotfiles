#!/bin/bash

# Microphone control script with mako notifications
# Usage: mic.sh up|down|mute

STEP=5 # Volume change percentage

get_volume() {
  wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print int($2 * 100)}'
}

is_muted() {
  wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED
}

# Generate a progress bar using Unicode blocks
# $1 = percentage (0-100)
make_bar() {
  local percent=$1
  local bar_length=20
  local filled=$((percent * bar_length / 100))
  local empty=$((bar_length - filled))

  local bar=""
  for ((i = 0; i < filled; i++)); do bar+="█"; done
  for ((i = 0; i < empty; i++)); do bar+="░"; done

  echo "$bar"
}

send_notification() {
  local volume=$(get_volume)
  local bar=$(make_bar "$volume")
  local icon
  local title

  if is_muted; then
    icon="microphone-sensitivity-muted"
    title="Microphone (Muted)"
  elif [ "$volume" -ge 70 ]; then
    icon="microphone-sensitivity-high"
    title="Microphone"
  elif [ "$volume" -ge 30 ]; then
    icon="microphone-sensitivity-medium"
    title="Microphone"
  else
    icon="microphone-sensitivity-low"
    title="Microphone"
  fi

  # The -h string:x-dunst-stack-tag:mic ensures mako replaces
  # previous mic notifications instead of stacking them
  notify-send \
    -h string:x-dunst-stack-tag:mic \
    -i "$icon" \
    -u low \
    -t 1500 \
    "$title" "$bar $volume%"
}

case "$1" in
up)
  wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ "${STEP}%+"
  send_notification
  ;;
down)
  wpctl set-volume @DEFAULT_AUDIO_SOURCE@ "${STEP}%-"
  send_notification
  ;;
mute)
  wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
  send_notification
  ;;
*)
  echo "Usage: $0 {up|down|mute}"
  exit 1
  ;;
esac
